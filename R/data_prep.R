#standard batting statistics
batting_2016 <- read.csv("batting_2016.txt")
batting_2017 <- read.csv("batting_2017.txt")
batting_2018 <- read.csv("batting_2018.txt")
batting_2019 <- read.csv("batting_2019.txt")

#batting value statistics
value_2016 <- read.csv("value_2016.txt")
value_2017 <- read.csv("value_2017.txt")
value_2018 <- read.csv("value_2018.txt")
value_2019 <- read.csv("value_2019.txt")

#filter to unique rows only
#for players who switched teams, multiple rows are recorded - only want their season total
batting_2016 <- batting_2016[!duplicated(batting_2016$Name),]
batting_2017 <- batting_2017[!duplicated(batting_2017$Name),]
batting_2018 <- batting_2018[!duplicated(batting_2018$Name),]
batting_2019 <- batting_2019[!duplicated(batting_2019$Name),]

#filter out anyone with no salary listed for the season
#first convert character Salary column to numeric
value_2016$Salary <- str_replace_all(value_2016$Salary, "[^[:alnum:]]", "") %>% as.numeric()
value_2017$Salary <- str_replace_all(value_2017$Salary, "[^[:alnum:]]", "") %>% as.numeric()
value_2018$Salary <- str_replace_all(value_2018$Salary, "[^[:alnum:]]", "") %>% as.numeric()
value_2019$Salary <- str_replace_all(value_2019$Salary, "[^[:alnum:]]", "") %>% as.numeric()

#then drop any row with NA for salary
value_2016 <- value_2016 %>% drop_na(Salary)
value_2017 <- value_2017 %>% drop_na(Salary)
value_2018 <- value_2018 %>% drop_na(Salary)
value_2019 <- value_2019 %>% drop_na(Salary)

#remove last 2 rows of batting statistics (these contain summary stats for the league)
batting_2016 <- batting_2016 %>% drop_na(Age)
batting_2017 <- batting_2017 %>% drop_na(Age)
batting_2018 <- batting_2018 %>% drop_na(Age)
batting_2019 <- batting_2019 %>% drop_na(Age)

#combine data frames into 1 complete data frame
#drop duplicate columns except Name, which we join on
#use inner_join to only keep rows that exist in both data frames
complete_2016 <- batting_2016 %>% select(!c(Rk, Age, Tm, G, PA, Pos.Summary)) %>% inner_join(., value_2016)
complete_2017 <- batting_2017 %>% select(!c(Rk, Age, Tm, G, PA, Pos.Summary)) %>% inner_join(., value_2017)
complete_2018 <- batting_2018 %>% select(!c(Rk, Age, Tm, G, PA, Pos.Summary)) %>% inner_join(., value_2018)
complete_2019 <- batting_2019 %>% select(!c(Rk, Age, Tm, G, PA, Pos.Summary)) %>% inner_join(., value_2019)
#reorder columns for cleanliness
complete_2016 <- complete_2016[, c(1, 26:27, 2, 28:29, 3:24, 30:47)]
complete_2017 <- complete_2017[, c(1, 26:27, 2, 28:29, 3:24, 30:47)]
complete_2018 <- complete_2018[, c(1, 26:27, 2, 28:29, 3:24, 30:47)]
complete_2019 <- complete_2019[, c(1, 26:27, 2, 28:29, 3:24, 30:47)]

