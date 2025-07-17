# Crop_land_extraction-GEE
This Google Earth Engine (GEE) script estimates the cropland area (in square kilometers) for each first-level administrative region (ADM1) in Ghana for the year 2015. It uses the MODIS MCD12Q1 Land Cover dataset and regional boundaries from the FAO GAUL 2015 dataset.

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

###################################################################
Why Select Class 12?
Class 12 = Croplands
This class includes:Lands covered with herbaceous crops that are cultivated for food, fiber, or fuel. These areas are dominated by single-season crops and typically have clearly defined planting and harvesting seasons."

Reason for selection:
Class 12 was selected because it best captures areas used for crop cultivation, which is the core focus of your analysis—estimating the spatial extent of cropland across Ghanaian regions.

Excludes other land types such as: Grasslands (Class 10), Urban areas (Class 13), Mixed cropland/natural vegetation (Class 14). This focus on pure cropland ensures the cropland area estimates are accurate and not diluted by mixed-use or transitional landscapes.

Calculate Area in km²
Converts pixel values to actual area (sq km) based on resolution.
##################################################################
