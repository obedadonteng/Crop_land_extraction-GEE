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

Source: WorldPop 
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

Only for visualization :Applies log1p() transformation (i.e., log(x + 1)) to handle skewed distributions and zero values.

Adds titles, legends, and stylistic elements for clarity.

Data Export:

Converts the sf object to a regular data frame (drops geometry).

Saves the table to an Excel file using openxlsx::write.xlsx().



# SPEI (climate indicater)

This R script processes monthly SPEI (Standardized Precipitation Evapotranspiration Index) data from NetCDF files for Ghana’s administrative regions (GADM Level 1). It extracts mean SPEI values per region for each month, combines all monthly data, and then computes annual average SPEI by region.

Purpose
Extract drought indicator values (SPEI) at the regional level for Ghana.

Aggregate monthly data into annual regional averages.

Prepare clean, tabular datasets for further analysis or visualization.

Inspect NetCDF metadata to understand the structure and attributes of the data files.

📁 Data Inputs
Administrative boundaries: GADM Level 1 shapefile for Ghana, stored in a geopackage (gadm36_GHA.gpkg).

SPEI data: Monthly NetCDF files (.nc) located in a folder named drought within your main project folder.

The script assumes a file naming convention containing the year and month in YYYYMM format (e.g., ...202001.area-subset.nc).


🔁 Workflow Summary
Workflow
Setup and Data Loading

Clear workspace.

Load required libraries.

Define folders for main data and SPEI NetCDF files.

Load Ghana regional boundaries from the GADM geopackage.

File Discovery and Date Parsing

List all NetCDF files in the drought folder.

Parse year and month from filenames using a regex-based function.

Data Extraction Loop

Loop over all NetCDF files.

For each file:

Load raster data.

Extract mean SPEI value for each region.

Append year, month, region, and SPEI to a list.

Data Aggregation

Combine monthly data into a single dataframe.

Optionally save the full monthly data CSV.

Compute average annual SPEI for each region.

Export final aggregated CSV.

NetCDF Metadata Inspection (Optional)

Uses ncmeta and ncdf4 packages to examine the contents of a sample NetCDF file.

Prints:

Dimensions: to understand spatial/temporal extent.

Variables: lists variables available in the file.

Global attributes: metadata describing the dataset.

Variable attributes: detailed info on SPEI variable, including units and other metadata.

Calendar type: checks the calendar system used in the time dimension.

This section helps verify the structure and content of NetCDF files before analysis.

The metadata inspection is for understanding the NetCDF files.

Output Files
monthly_spei_by_region.csv — monthly SPEI values per region.

ghana_region_yearly_spei.csv — average annual SPEI per region.


# Harmonized Nighlight data 

Description
This Google Earth Engine (GEE) script extracts and harmonizes annual nighttime light (NTL) data over Ghana's old administrative boundaries (10 regions) for the years 2000 to 2020. It combines multiple NTL datasets (DMSP-OLS, harmonized VIIRS, and raw VIIRS) into a consistent time series and computes the average nighttime light intensity per region per year.

📁 Data Inputs
Ghana ADM1 boundaries (old 10 regions): FAO GAUL 2015 dataset.

DMSP-OLS stable lights (2000–2013): Harmonized DMSP nighttime lights dataset.

VIIRS harmonized monthly composites (2014–2018): Harmonized VIIRS nighttime lights dataset.

Raw VIIRS monthly composites (2019–2020): Raw VIIRS monthly nighttime lights data from NOAA.

Harmonization Approach
Loads pre-harmonized DMSP (2000–2013) and VIIRS (2014–2018) nightlight datasets from sat-io's open data catalog.

Loops through each year from 2000 to 2018:

Picks the correct harmonized image for that year (DMSP or VIIRS).

Extracts it and renames the band to ntl.

Then applies a harmonization function to the raw VIIRS (2019–2020) to match the scale of the 2000–2018 harmonized dataset.

This approach is approximate but useful for consistency across the entire time series.

🔁 Workflow Summary

Load Ghana ADM1 boundaries (old 10 regions) from FAO GAUL.

Load harmonized DMSP and VIIRS NTL datasets, and raw VIIRS data.

Define a harmonization function for raw VIIRS.

Build yearly composites for each year from 2000 to 2020 by selecting the appropriate dataset.

Compute the mean nighttime light value for each administrative region per year.

Export the results as a CSV file to Google Drive.

Output
CSV file named harmonized_NTL_Ghana_ADM1_2000_2020_old_boundaries.csv containing mean NTL values per region per year.



# Important Notes
CRS Alignment: All the scripts checked coordinate reference systems (CRS) between the raster and vector data.Raster CRS: ID["EPSG",4326]; Vector CRS: GEOGCRS["WGS 84"]

Adjust all file paths based on your local directory structure.

Update folder and nc_folder variables to your local paths.

Ensure all necessary R packages are installed (eg: terra, sf, dplyr, exactextractr, ncmeta, ncdf4).

Run the script to process all SPEI NetCDF files in the specified folder.

Review outputs in the designated folder.



