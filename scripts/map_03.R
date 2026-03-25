# Challenge Classic: Create a map focused on area features (e.g., administrative regions, 
# land use, boundaries). Use fills, patterns, and choropleth techniques.

# 1.) Source globals ----
library(here)
source(here('scripts/globals.R'))
options(scipen = 999)

# 2.) Read data ----

# measles data
measles_data_csv <- read_csv(here('data/data-table.csv'))

# pop data
pop_data <- read_csv(here('data/NST-EST2025-ALLDATA.csv'))

# map data
library(usmap)
# better option imo
library(maps)
library(mapdata)

# 3.) graph US states
us_map <- map_data('state')
us_map$region

# clean measles and pop data
measles_data_clean <- measles_data_csv %>% 
  mutate(Location = tolower(Location)) %>% 
  select(`2025`, Location) %>% 
  rename(cases = `2025`)

pop_data_clean <- pop_data %>% 
  select(POPESTIMATE2025, NAME) %>% 
  mutate(NAME = tolower(NAME))

# join measles and pop data
us_map_measles <- us_map %>% 
  left_join(
    measles_data_clean,
      by = c('region' = 'Location')
  ) %>% 
  left_join(
    pop_data_clean,
      by = c('region' = 'NAME')
  ) %>% 
  mutate(pct_of_pop = cases / POPESTIMATE2025)

# plot data on a map
measles_map <- us_map_measles %>%
  ggplot(aes(x = long, y = lat, group = group, fill = pct_of_pop)) +
  geom_polygon(color = 'white')+
  theme_void()+
  map_theme_minimal()+
  scale_fill_continuous(labels = scales::label_percent())+
  labs(title = 'Measles Cases as a Percent of 2025 Population',
       fill = '% of Population')+
  theme(plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), 'cm'),
        legend.position = 'right')
# Looks like south carolina and some parts of the mid and south west were hit
# pretty hard over the course of 2025. Could do a follow up map using 2025 proxy
# population data to assess changes into the new year too here.
