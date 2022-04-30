## stats bomb work

library(tidyverse)
library(ggplot2)
library(devtools)
## installs stats bomb wrapper and dependencies
## remotes::install_version("SDMTools", "1.1-221")
## devtools::install_github("statsbomb/StatsBombR")
library(StatsBombR)
## load free data
all_comps <- FreeCompetitions()

## filter down to mens wc 2020/21
all_free_matches <- FreeMatches(all_comps)
# all_comps %>% filter(competition_id == )
## summarize what comps we have
all_free_matches %>% 
  group_by(competition.competition_name, home_team.home_team_gender) %>%
  summarize(c = n()) %>%
  arrange(c)

## wc data, just england
wc_data <- all_free_matches %>%
  filter(competition.competition_id == 43) %>%
  filter(home_team.home_team_name == 'England' | away_team.away_team_name == 'England')

## euro data, just england
euro_data <- all_free_matches %>%
  filter(competition.competition_id == 55) %>%
  filter(home_team.home_team_name == 'England' | away_team.away_team_name == 'England')

## conveniently they played 7 games in both competitions

## merge those: 
all_match_data <- as.data.frame(rbind(wc_data, euro_data))

## now we want to extract just data for Harry Kane
## to start we need to get the event data for his matches
england_event_data <- StatsBombFreeEvents(all_match_data)

## built in hook for cleaning data
england_event_data <- allclean(england_event_data)

## just HK data
full_hk <- england_event_data %>%
  filter(player.name == 'Harry Kane') %>%
  filter(period != 5) # remove penatly shootout

## checking out what types of events there are
full_hk %>%
  filter(player.name == 'Harry Kane') %>%
  group_by(type.name) %>%
  summarize(count = n())
    
## Harry Kane shots:
## note Harry Kane has player ID 10955
shots_hk <- full_hk %>%
  group_by(player.name, player.id) %>%
  filter(player.name == 'Harry Kane') %>%
  summarize(shots = sum(type.name == "Shot", na.rm = TRUE)) 

## minutes data is stored separately
minutes_data <- get.minutesplayed(england_event_data)

## Harry Kane minutes:
minutes_hk <- minutes_data %>% 
  group_by(player.id) %>% 
  filter(player.id == 10955) %>% 
  summarize(minutes = sum(MinutesPlayed)) %>%
  mutate(nineties = minutes/90)

## combine column wise on id
agg_hk <- left_join(shots_hk, minutes_hk) %>%
  mutate(shots_per90 = shots/nineties)

## HK passes, that are completed into the box
hk_box_passes <- full_hk %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & player.id==10955) %>%
  filter(pass.end_location.x>=102 & pass.end_location.y<=62 & pass.end_location.y>=18) # the box!

## HK Passes, switches
hk_switches <- full_hk %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & player.id==10955) %>% 
  filter(pass.switch == TRUE) #%>%
  #summarize(count = n()) %>%
  #select(count)

## HK, Receptions inside the middle third?
hk_receptions_middle_third <- full_hk %>%
  filter(type.name=="Ball Receipt*" & player.id==10955) %>%
  filter(location.x >= 40 & location.x <= 80)

## HK, Passes that start in the middle third?
hk_passes_middle_third <- full_hk %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & player.id==10955) %>% 
  filter(location.x >=40 & location.x <=80)

## HK, goals! including penalties.
hk_goals <- full_hk %>%
  filter(player.name == 'Harry Kane' & type.name == 'Shot' & shot.outcome.id == 97)

## mega df, then, will contain...
## shots, minutes, nineties, shots_per90, goals, switches, 
## balls into the box, middle 1/3 receptions, middle 1/3 passes
agg_hk <- agg_hk %>% 
  mutate(
         goals = hk_goals %>% summarize(count = n()),
         goals_per90 = goals/nineties,
         middle_third_passes = hk_passes_middle_third %>% summarize(count = n()), 
         middle_third_passes_per90 = middle_third_passes / nineties,
         middle_third_receptions = hk_receptions_middle_third %>% summarize(count = n()),
         middle_third_receptions_per90 = middle_third_receptions / nineties,
         passes_into_box = hk_box_passes %>% summarize(count = n()),
         passes_into_box_per90 = passes_into_box / nineties,
         switches = hk_switches %>% summarize(count = n()),
         switches_per90 = switches / nineties
         )

## Pitch Plots

## Draw 18 Passing Plot
  create_Pitch() + 
  geom_segment(data = hk_box_passes, aes(x = location.x,
                                  y = location.y,
                                  xend = pass.end_location.x,
                                  yend = pass.end_location.y),
                              lineend = "round",
                                  size = 0.5,
                                  colour = "#000000",
                              arrow = arrow(length = unit(0.07, "inches"),
                                            ends = "last", type = "open")) +
  labs(title = "Harry Kane, Completed Box Passes", subtitle = "Word Cup 2018 and Euro 2020") +
  scale_y_reverse() +
  coord_fixed(ratio = 105/100)
  
## Draw Full Passing Plot
  create_Pitch() + 
    geom_segment(data = hk_all_passes, aes(x = location.x,
                                           y = location.y,
                                           xend = pass.end_location.x,
                                           yend = pass.end_location.y),
                 lineend = "round",
                 size = 0.5,
                 colour = "#000000",
                 arrow = arrow(length = unit(0.07, "inches"),
                               ends = "last", type = "open")) +
    labs(title = "Harry Kane, Completed Passes", subtitle = "Word Cup 2018 and Euro 2020") +
    scale_y_reverse() +
    coord_fixed(ratio = 105/100)
  
## Draw Switches
  create_Pitch() + 
    geom_segment(data = hk_switches, aes(x = location.x,
                                           y = location.y,
                                           xend = pass.end_location.x,
                                           yend = pass.end_location.y),
                 lineend = "round",
                 size = 0.5,
                 colour = "#000000",
                 arrow = arrow(length = unit(0.07, "inches"),
                               ends = "last", type = "open")) +
    labs(title = "Harry Kane, Completed Switches", subtitle = "Word Cup 2018 and Euro 2020") +
    scale_y_reverse() +
    coord_fixed(ratio = 105/100)
  
## Draw Shooting Maps

## HK Shots, non penalty
hk_shots <- england_event_data %>% 
  filter(player.id == 10955) %>%
  filter(type.name == "Shot" & (shot.type.name != "Penalty" | is.na(shot.type.name))) %>%
  mutate(goal_or_no_goal = ifelse(shot.outcome.id == 97, "goal", "no_goal"))
  
## shot data... shot.outcome.id -> 97 is a goal
## shot data... shot.body_part.id -> "Head" = 21, "Right Foot" = 23, "Left Foot" = 24
colnames(hk_shots)

## subsetted df with only relevant info for plotting
hk_shots_smaller <- hk_shots %>%
  select(location.x, location.y, goal_or_no_goal, shot.statsbomb_xg)

shot_map <- create_Shot_Map(hk_shots_smaller, "Harry Kane Shot Map", "WC 2018 and Euro 2020", xG_and_footedness = FALSE, vanilla = FALSE, xG_for_Scale = TRUE)    

sum(hk_shots_smaller$shot.statsbomb_xg)

## export as svg
ggsave(file="shot_map.svg", plot=shot_map, width=16, height=16)

## Draw Heatmap

## heatmap -- where is HK playing? -- offensive actions only...
offensive_events <- c("Ball Receipt*", "Ball Recovery","Carry",
                      "Dispossessed","Dribble","Foul",
                      "Injury","Stoppage","Miscontrol","Pass","Shot")

hk_offensive <- full_hk %>% 
  filter(type.name %in% offensive_events)

heatmap <- hk_offensive %>% mutate(location.x = ifelse(location.x>120, 120, location.x),
            location.y = ifelse(location.y>80, 80, location.y),
            location.x = ifelse(location.x<0, 0, location.x),
            location.y = ifelse(location.y<0, 0, location.y))

# 6 x bins
heatmap$xbin <- cut(heatmap$location.x, breaks = seq(from=0, to=120, by = 20),include.lowest=TRUE )
# 4 y bins
heatmap$ybin <- cut(heatmap$location.y, breaks = seq(from=0, to=80, by = 20),include.lowest=TRUE)

binned_heatmap <- heatmap %>%
  mutate(total_OA = n()) %>%
  group_by(xbin, ybin) %>%
  summarise(bin_OA = n(),
            bin_pct = bin_OA/total_OA,
            location.x = median(location.x),
            location.y = median(location.y)) %>%
  group_by(xbin, ybin)

distinct_binned_heatmap <- distinct(binned_heatmap)

activitycolors <- c("#dc2429", "#dc2329", "#df272d", "#df3238", "#e14348", "#e44d51",
                             "#e35256", "#e76266", "#e9777b", "#ec8589", "#ec898d", "#ef9195",
                             "#ef9ea1", "#f0a6a9", "#f2abae", "#f4b9bc", "#f8d1d2", "#f9e0e2",
                             "#f7e1e3", "#f5e2e4", "#d4d5d8", "#d1d3d8", "#cdd2d6", "#c8cdd3", "#c0c7cd",
                             "#b9c0c8", "#b5bcc3", "#909ba5", "#8f9aa5", "#818c98", "#798590",
                             "#697785", "#526173", "#435367", "#3a4b60", "#2e4257", "#1d3048",
                             "#11263e", "#11273e", "#0d233a", "#020c16")

heatmap_viz <- ggplot(data = distinct_binned_heatmap, aes(x = location.x, y = location.y, fill = bin_pct, group=bin_pct)) +
  geom_bin2d(binwidth = c(20, 20), position = "identity", alpha = 0.9) + #2
  annotate("rect",xmin = 0, xmax = 120, ymin = 0, ymax = 80, fill = NA, colour = "black", size = 0.6) +
  annotate("rect",xmin = 0, xmax = 60, ymin = 0, ymax = 80, fill = NA, colour = "black", size = 0.6) +
  annotate("rect",xmin = 18, xmax = 0, ymin = 18, ymax = 62, fill = NA, colour = "white", size = 0.6) +
  annotate("rect",xmin = 102, xmax = 120, ymin = 18, ymax = 62, fill = NA, colour = "white", size = 0.6) +
  annotate("rect",xmin = 0, xmax = 6, ymin = 30, ymax = 50, fill = NA, colour = "white", size = 0.6) +
  annotate("rect",xmin = 120, xmax = 114, ymin = 30, ymax = 50, fill = NA, colour = "white", size = 0.6) +
  annotate("rect",xmin = 120, xmax = 120.5, ymin =36, ymax = 44, fill = NA, colour = "black", size = 0.6) +
  annotate("rect",xmin = 0, xmax = -0.5, ymin =36, ymax = 44, fill = NA, colour = "black", size = 0.6) +
  annotate("segment", x = 60, xend = 60, y = -0.5, yend = 80.5, colour = "white", size = 0.6)+
  annotate("segment", x = 0, xend = 0, y = 0, yend = 80, colour = "black", size = 0.6)+
  annotate("segment", x = 120, xend = 120, y = 0, yend = 80, colour = "black", size = 0.6)+
  theme(rect = element_blank(),
        line = element_blank()) +
  annotate("point", x = 12 , y = 40, colour = "white", size = 1.05) +
  annotate("point", x = 108 , y = 40, colour = "white", size = 1.05) +
  annotate("path", colour = "white", size = 0.6,
           x=60+10*cos(seq(0,2*pi,length.out=2000)),
           y=40+10*sin(seq(0,2*pi,length.out=2000)))+
  annotate("point", x = 60 , y = 40, colour = "white", size = 1.05) +
  annotate("path", x=12+10*cos(seq(-0.3*pi,0.3*pi,length.out=30)), size = 0.6,
           y=40+10*sin(seq(-0.3*pi,0.3*pi,length.out=30)), col="white") +
  annotate("path", x=108-10*cos(seq(-0.3*pi,0.3*pi,length.out=30)), size = 0.6,
           y=40-10*sin(seq(-0.3*pi,0.3*pi,length.out=30)), col="white") +
  theme(axis.text.x=element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        plot.caption=element_text(size=13, hjust=0.5, vjust=0.5),
        plot.subtitle = element_text(size = 15, hjust = 0.5),
        axis.text.y=element_blank(),
        legend.title = element_blank(),
        legend.text=element_text(size=10),
        legend.key.size = unit(1, "cm"),
        plot.title = element_text(margin = margin(r = 10, b = 10), face="bold",size = 20, colour = "black", hjust = 0.5),
        legend.direction = "vertical",
        axis.ticks=element_blank(),
        plot.background = element_rect(fill = "white"),
        strip.text.x = element_text(size=13)) + #4
  scale_y_reverse() + #5
  scale_fill_gradientn(colours = activitycolors, na.value = "black", trans = "reverse", labels =
                         scales::percent_format(accuracy = 1)) + #6
  labs(title = "Where Does Harry Kane Attack on Average?", subtitle = "WC 2018 + Euro 2020") + #7
  coord_fixed(ratio = 95/100)

## export as svg
ggsave(file="heat_map.svg", plot=heatmap_viz, width=16, height=16)

## simple bar graph for Kane's goals
kane <- c("Harry Kane", 10, "England")
ronaldo <- c("Cristiano Ronaldo", 9, "Portugal")
lukaku <- c("Romelu Lukaku", 8, "Belgium")

graph_df <- as.data.frame(rbind(kane, ronaldo, lukaku))
colnames(graph_df) <- c("Player", "Goals", "Country")

write.csv(graph_df, "top_scorers_df.csv")

## mount passes
full_mount <- england_event_data %>%
  filter(player.name == 'Mason Mount') %>%
  filter(period != 5) # remove penatly shootout

mount_passes <- full_mount %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & player.id==7843)

mount_passes <- apply(mount_passes,2,as.character)

write.csv(mount_passes, "mount_passes.csv")

## Mount minutes:
minutes_data %>% 
  group_by(player.id) %>% 
  filter(player.id == 7843) %>% 
  summarize(minutes = sum(MinutesPlayed)) %>%
  mutate(nineties = minutes/90)

## trent passes
full_trent <- england_event_data %>%
  filter(player.name == 'Trent Alexander-Arnold') %>%
  filter(period != 5) # remove penatly shootout

trent_passes <- full_trent %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & player.id==3664)

## Trent minutes:
minutes_data %>% 
  group_by(player.id) %>% 
  filter(player.id == 3664) %>% 
  summarize(minutes = sum(MinutesPlayed)) %>%
  mutate(nineties = minutes/90)


trent_passes <- apply(trent_passes,2,as.character)

write.csv(trent_passes, "trent_passes.csv")
