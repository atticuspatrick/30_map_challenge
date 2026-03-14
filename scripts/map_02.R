# Day 2: Challenge Classic: Map linear features (e.g., roads, rivers, migration paths, 
# flow lines). Explore line thickness, color, and direction to convey information.

# 1.) Source globals ----
library(here)
source(here('scripts/globals.R'))

# 2.) Read data ----

# read boston shape file
bos_boundaries <- st_read(here('data/City_of_Boston_Outline_Boundary_Water_Excluded.shp'))
# source: https://data.boston.gov/dataset/city-of-boston-outline-boundary-water-excluded

# read boston  venues
bos_streets <- st_read(here('data/Boston_Street_Segments_SAM_System.shp'))
# source: https://data.boston.gov/dataset/boston-street-segments-sam-system

# 3.) Explore and clean data ----
# View(bos_streets)

# 4.) Create basic map ----
bos_map <- ggplot() +
  geom_sf(data = bos_boundaries)+
  geom_sf(data = bos_streets)+
  labs(title = '2024 Boston Street Map')+
  map_theme_minimal()+
  annotation_scale()
bos_map

ggsave(here('plots/day_2_map.png'), bos_map, height = 10, width = 12, dpi = 300)

