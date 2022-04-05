library(tidyverse)
library(worldfootballR)

## relevant match urls

# contains match urls for each bundesliga game, 2020-21 season and 2021-22 season
match_urls <- get_match_urls(country = "GER", gender = "M", season_end_year = c(2021:2022))

# contain's bayern's match urls
bayern_match_urls <- match_urls[grepl("Bayern", match_urls)]

length(bayern_match_urls) # 59 as expected 

# okay, first need to work out ....
# bayerns data (no dupes! )
# this originally returns 2 rows for each game,
# get bayern when it is the Team implicated
bayern_summary_raw <- get_advanced_match_stats(bayern_match_urls, stat_type = "summary", team_or_player = "team")

bayern_summary_df <- bayern_summary_raw %>% filter(Team == "Bayern Munich")

bayern_defense_raw <- get_advanced_match_stats(bayern_match_urls, stat_type = "defense", team_or_player = "team")

bayern_defense_df <- bayern_defense_raw %>% filter(Team == "Bayern Munich")

bayern_misc_raw <- get_advanced_match_stats(bayern_match_urls, stat_type = "misc", team_or_player = "team")

bayern_misc_df <- bayern_misc_raw %>% filter(Team == "Bayern Munich")

# now pick out what columns we want from each and then combine them into a big df.

## first, have to pull out: goals, bayern xG, opponent, opponent xG, bayern yellow cards, bayern red cards
bayern_team_df_selected <- bayern_summary_df %>%
  mutate(bayern_goals = ifelse(grepl('Bayern Munich', Home_Team), Home_Score, Away_Score)) %>%
  mutate(bayern_xG = ifelse(grepl('Bayern Munich', Home_Team), Home_xG, Away_xG)) %>%
  mutate(opponent_goals = ifelse(grepl('Bayern Munich', Home_Team), Away_Score, Home_Score)) %>%
  mutate(opponent_xG = ifelse(grepl('Bayern Munich', Home_Team), Away_xG, Home_xG)) %>%
  mutate(opponent_name = ifelse(grepl('Bayern Munich', Home_Team), Away_Team, Home_Team)) %>%
  mutate(bayern_yc = ifelse(grepl('Bayern Munich', Home_Team), Home_Yellow_Cards, Away_Yellow_Cards)) %>%
  mutate(bayern_rc = ifelse(grepl('Bayern Munich', Home_Team), Home_Red_Cards, Away_Red_Cards)) %>%
  select(Match_Date, opponent_name, bayern_goals, bayern_xG, opponent_goals, opponent_xG, bayern_yc, bayern_rc)

bayern_defense_df_selected <- bayern_defense_df %>%
  select(Tkl_Tackles, TklW_Tackles, `Def 3rd_Tackles`, `Mid 3rd_Tackles`, `Att 3rd_Tackles`, Tkl_percent_Vs_Dribbles, Press_Pressures, Succ_Pressures, `_percent_Pressures`, Blocks_Blocks, Sh_Blocks, Int, Clr, Err)

bayern_misc_df_selected <- bayern_misc_df %>%
  select(Fls, Recov, Won_Aerial_Duels, Lost_Aerial_Duels, Won_percent_Aerial_Duels)

bayern_combined_df <- as.data.frame(cbind(bayern_team_df_selected, bayern_defense_df_selected, bayern_misc_df_selected))

# leroys data

leroy_passing_raw <- get_advanced_match_stats(bayern_match_urls, stat_type = "passing", team_or_player = "player")

leroy_passing_df <- leroy_passing_raw %>% filter(Player == "Leroy Sané")

leroy_passing_types_raw <- get_advanced_match_stats(bayern_match_urls, stat_type = "passing_types", team_or_player = "player")

leroy_passing_types_df <- leroy_passing_types_raw %>% filter(Player == "Leroy Sané")

leroy_possession_raw <- get_advanced_match_stats(bayern_match_urls, stat_type = "possession", team_or_player = "player")

leroy_possession_df <- leroy_possession_raw %>% filter(Player == "Leroy Sané")

# have to extract when he is a goal scorer.. that data isn't in the API

leroy_goals_vector <- c(0)
for (i in 1:length(leroy_possession_df$League)) {
  leroy_goals_vector[i] <- ifelse(grepl('Bayern Munich', leroy_possession_df$Home_Team[i]), 
                                  length(grep('Leroy Sané', leroy_possession_df$Home_Goals[i])),
                                  length(grep('Leroy Sané', leroy_possession_df$Away_Goals[i])))
}

leroy_goals_df <- as.data.frame(leroy_goals_vector)
colnames(leroy_goals_df) <- c("goals")

# now, extract what we care about

leroy_passing_selected <- leroy_passing_df %>% 
  mutate(opponent_name = ifelse(grepl('Bayern Munich', Home_Team), Away_Team, Home_Team)) %>%
  select(Match_Date, opponent_name, Team, Min, Cmp_Total, Att_Total, Cmp_percent_Total, TotDist_Total, PrgDist_Total, Ast, xA, KP, Final_Third, PPA, CrsPA, Prog)

leroy_passing_types_selected <- leroy_passing_types_df %>% select(Att, Live_Pass_Types, Press_Pass_Types, Crs_Pass_Types, Sw_Pass_Types, Cmp_Outcomes)

leroy_possession_selected <- leroy_possession_df %>% select(Touches_Touches, `Mid 3rd_Touches`, `Att 3rd_Touches`, `Att Pen_Touches`, Succ_Dribbles, Att_Dribbles, Succ_percent_Dribbles, Player_NumPl_Dribbles, Carries_Carries, TotDist_Carries, PrgDist_Carries, Prog_Carries, Final_Third_Carries, CPA_Carries, Mis_Carries, Rec_Receiving, Rec_percent_Receiving)

leroy_combined_df <- as.data.frame(cbind(leroy_passing_selected, leroy_passing_types_selected, leroy_possession_selected, leroy_goals_df))

## add column to note what season it is
leroy_combined_df <- leroy_combined_df %>%
  mutate(conv_match_date = as.Date(Match_Date, "%A %B %d, %Y")) %>%
  arrange(conv_match_date) %>% 
  mutate(manager = ifelse(row_number() <= 31, 'Flick', 'Nagelsmann'))

## add column to note what season it is
# tableau wants 1/1/12
bayern_combined_df <- bayern_combined_df %>%
  mutate(conv_match_date = as.Date(Match_Date, "%A %B %d, %Y")) %>%
  arrange(conv_match_date) %>% 
  mutate(manager = ifelse(row_number() <= 31, 'Flick', 'Nagelsmann'))

## write to .csvs 
write.csv(bayern_combined_df, file = "bayern.csv", row.names = FALSE)
write.csv(leroy_combined_df, file = "leroy.csv", row.names = FALSE)

# test results
leroy_combined_df %>%
  count(manager)


