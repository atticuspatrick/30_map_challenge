# Library packages ----
library(tidyverse)
library(sf)       # for shapefiles / spatial data
library(tmap)     # for easy thematic mapping
library(ggplot2)  # optional, for static maps
library(here)
library(survey)
library(ggspatial)

# functions
map_theme_minimal <- function() {
  theme_void() +
    theme(
      legend.position = "top",
      plot.title = element_text(
        hjust = 0.5,
        family = "Futura Bold"
      ),
      text = element_text(
        family = "Futura"
      )
    )
}
