rm(list = ls())

# Load libraries
library(terra)
library(sf)
library(dplyr)
library(ggplot2)
library(exactextractr)
library(openxlsx)
library(viridis)

# Set folder
folder <- "C:/Users/Obed Kissi Adonteng/Desktop/pop density"

# Load administrative boundaries
admin1_sf <- st_read(file.path(folder, "gadm36_GHA.gpkg"), layer = "gadm36_GHA_1")

# Load population density raster (e.g., WorldPop)
pop_raster <- rast(file.path(folder, "gha_pd_2020_1km.tif"))

# Check and align CRS
print(crs(pop_raster))
print(st_crs(admin1_sf))

# Extract total population density (sum of raster cell values within each region)
admin1_sf$Pop_density <- exact_extract(pop_raster, admin1_sf, 'mean')

# Plot log-transformed population density
ggplot(admin1_sf) +
  geom_sf(aes(fill = log1p(Pop_density))) +  # log1p handles zeros well
  scale_fill_viridis_c(
    option = "magma",
    name = "Log(Pop. Density + 1)",
    labels = scales::label_comma()
  ) +
  theme_minimal() +
  labs(
    title = "Population Density Across Ghana’s Regions (2000)",
    subtitle = "Log-transformed sum of population density (1km resolution)",
    caption = "Author: Obed Kissi Adonteng | Data Source: WorldPop (www.worldpop.org)"
  )


# Export data to Excel
df_to_export <- st_set_geometry(admin1_sf, NULL)
write.xlsx(df_to_export, file = file.path(folder, "ghana_population_density_data.xlsx"))

