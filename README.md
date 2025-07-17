# Crop_land_extraction-GEE
This Google Earth Engine (GEE) script estimates the cropland area (in square kilometers) for each first-level administrative region (ADM1) in Ghana for the year 2015. It uses the MODIS MCD12Q1 Land Cover dataset and regional boundaries from the FAO GAUL 2015 dataset.The included example uses data for 2015, but the method was applied from 2001 to 2020, with each year processed and downloaded individually.

You can also manually uploaded the GADM 3.6 ADM1 shapefile to your GEE Assets to compare results (both boundary datasets reflect Ghana’s pre-2018 10-region structure).

📁 Dataset Sources
1. Administrative Boundaries
a. FAO GAUL 2015(https://developers.google.com/earth-engine/datasets/catalog/FAO_GAUL_2015_level1)
Dataset: FAO/GAUL/2015/level1

Description: ADM1 boundaries for Ghana as recognized by the FAO up to 2015.

Structure: Reflects 10 regions (pre-2018 structure).

Use case: Historical consistency to align with other regional-level variables that are not easily disaggregated to the newer 16-region structure.

b. GADM 3.6 (Manually Uploaded) (https://gadm.org/download_world36.html#google_vignette). Note that you may have challenges downloading the old shapefiles sometimes from this source
Dataset: users/your_username/gadm36_GHA_1 (replace with your actual asset path) 

Description: First-level administrative boundaries from GADM v3.6.

Structure: Also reflects Ghana’s 10 regions, as GADM 3.6 predates the 2018 administrative reform.

Purpose: You uploaded this to compare cropland estimates across boundary datasets.

🔴 Note: Both GAUL and GADM 3.6 represent outdated regional structures and do not include the 6 new regions created in 2018 (for a total of 16).

2. Land Cover Classification
Dataset: MODIS/006/MCD12Q1

Description: MODIS global land cover classification using the IGBP scheme.

Resolution: 500m

Class 12: Croplands (herbaceous crops).

✅ Script Workflow
Load ADM1 Boundaries
Selects either GAUL or GADM (both with 10-region structures) to define regions.

Load MODIS Land Cover (2015)
Retrieves and selects the IGBP land cover class image for 2015.

Identify Cropland Pixels
Selects pixels labeled as cropland (Class 12).

Summarize by Region
Aggregates total cropland area for each ADM1 region.

Add Output Field
Adds a field called cropland_km2 with the result per region.

Export to CSV
Outputs results as a table to Google Drive.

****************************************************************
Why Select Class 12?
Class 12 = Croplands
This class includes:Lands covered with herbaceous crops that are cultivated for food, fiber, or fuel. These areas are dominated by single-season crops and typically have clearly defined planting and harvesting seasons."

Reason for selection:
Class 12 was selected because it best captures areas used for crop cultivation, which is the core focus of your analysis—estimating the spatial extent of cropland across Ghanaian regions.

Excludes other land types such as: Grasslands (Class 10), Urban areas (Class 13), Mixed cropland/natural vegetation (Class 14). This focus on pure cropland ensures the cropland area estimates are accurate and not diluted by mixed-use or transitional landscapes.

Calculate Area in km²
Converts pixel values to actual area (sq km) based on resolution.
******************************************************************

# Pop density extraction
This R script computes and visualizes the average population density for each of Ghana's first-level administrative regions (ADM1) using gridded population raster data. It also exports the resulting statistics for further analysis.The provided script demonstrates the process using data for the year 2020, but the same approach was applied repeatedly for your full sample period (e.g., 2000 to 2020), processing one year at a time.

📁 Data Inputs
Administrative Boundaries:

Source: GADM v3.6

File: gadm36_GHA.gpkg

Layer: gadm36_GHA_1

Description: First-level administrative boundaries (10 regions of Ghana as defined pre-2018).

Population Density Raster:

Source: WorldPop (or similar global population data provider)

File: gha_pd_2020_1km.tif

Description: 1-kilometer resolution raster estimating population density (people per square kilometer) for the year 2020.

🔁 Workflow Summary
Environment Setup:

Clears the R environment using rm(list = ls()).

Loads required libraries for spatial data handling, raster analysis, plotting, and Excel export.

Data Import:

Loads vector boundary data using sf::st_read().

Loads population raster using terra::rast().

Coordinate Reference System (CRS) Check:

Prints CRS for both raster and vector data to ensure they are compatible for spatial extraction.

Spatial Analysis:

Uses exactextractr::exact_extract() to calculate the mean population density within each ADM1 region.

Stores the result in a new column (Pop_density) in the sf object.

Visualization:

Uses ggplot2 and viridis to generate a choropleth map.

Applies log1p() transformation (i.e., log(x + 1)) to handle skewed distributions and zero values.

Adds titles, legends, and stylistic elements for clarity.

Data Export:

Converts the sf object to a regular data frame (drops geometry).

Saves the table to an Excel file using openxlsx::write.xlsx().
