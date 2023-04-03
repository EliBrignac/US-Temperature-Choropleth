

pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes,
                 ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny,
                 stringr, tidyr, maps, lubridate)


df <- read.csv("UnitedStatesLandTemperaturesByState(Cleaned).csv")
head(df)

df <- df %>% mutate(date = dt)
# Convert the date format using lubridate
df$date <- dmy(df$date)

# Convert the date format to "yyyy/dd/mm"
df$date <- format(df$date, "%Y/%d/%m")

head(df)

df$year <- year(ymd(df$date))
df$month <- month(ymd(df$date))

df <- df %>% 
  select(-dt)

head(df)

month_abbreviations <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                         "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

head(df)
df$month <- factor(df$month, labels = month_abbreviations)
head(df)



df <- df %>% 
  filter(year >= 1900 & year < 2013) %>%
  filter(State != "District Of Columbia") %>%
  mutate(State = if_else(State == "Georgia (State)", "Georgia", State)) %>%
  filter(State != "District of columbia")

write.csv(df, "USAverageTemps1900-2012.csv", row.names = F)

