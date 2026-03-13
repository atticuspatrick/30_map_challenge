# Day 1: Challenge Classic: Map with point data (e.g., individual locations, points of interest, clusters). 
# Focus on effective symbolization and density visualization.

# 1.) Source globals ----
source(here('scripts/globals.R'))

# 2.) Read data ----

# read vancouver shape file
van_boundaries <- st_read(here('data/local-area-boundary.shp'))

# read olympic venues
van_venues <- st_read(here('data/olympic-venues.shp'))

# 3.) Explore and clean data ----
# View(van_boundaries)
# View(van_venues)

# remove thunderbird arena as it is not in the city proper
van_venues_clean <- van_venues %>% 
  filter(VENUE != 'UBC Thunderbird Arena') %>% 
  rename(Venue = VENUE)

# 4.) Create basic map ----
van_map1 <- ggplot() +
  geom_sf(data = van_boundaries, fill = 'blue', color = 'black', alpha = 0.1)+
  geom_sf(data = van_venues_clean, aes(color = Venue), size = 3) + 
  # geom_sf_text(data = van_venues_clean, 
  #              aes(label = VENUE)) +
  theme_void() +
  theme(legend.position = 'top',
        plot.title = element_text(hjust = 0.5, family = 'Futura Bold'),
        text = element_text(family = 'Futura'))+
  guides(color = guide_legend(nrow = 3)) +
  scale_color_brewer(palette = 'Set1')+
  labs(title = 'Vancouver 2010 Olympic Venues', 
       caption = '*UBC Thunderbird not included as it falls outside of city boundaries.') +
  annotation_scale() 
van_map1

ggsave(here('plots/day_1_map.png'), van_map1, height = 10, width = 12, dpi = 300)

