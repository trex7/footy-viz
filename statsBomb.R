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
  filter(player.name == 'Harry Kane')

## checking out what types of events there are
full_hk %>%
  filter(player.name == 'Harry Kane') %>%
  group_by(type.name) %>%
  summarize(count = n())
    
## Harry Kane shots:
## note Harry Kane has player ID 10955
shots_hk <- england_event_data %>%
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

## HK passes
hk_box_passes <- england_event_data %>%
  filter(type.name=="Pass" & is.na(pass.outcome.name) & player.id==10955) %>%
  filter(pass.end_location.x>=102 & pass.end_location.y<=62 & pass.end_location.y>=18) # the box!
  
## Draw Passing Plot
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
  
## HK Shots
hk_shots <- england_event_data %>% 
  filter(player.id == 10955) %>%
  filter(type.name == "Shot" & (shot.type.name != "Penalty" | is.na(shot.type.name))) %>%
  mutate(goal_or_no_goal = ifelse(shot.outcome.id == 97, "goal", "no_goal"))

## shot data... shot.outcome.id -> 97 is a goal
## shot data... shot.body_part.id -> "Head" = 21, "Right Foot" = 23, "Left Foot" = 24
colnames(hk_shots)

create_Shot_Map(hk_shots, "Harry Kane Shot Map", "WC 2018 + Euro 2020", xG = TRUE)    
