
# Load necessary libraries
library(raster)
library(data.table)  # Alternatively, you can use library(dplyr)

# Read the raster datasets
lulc_raster <- raster("/Users/ceedindia/Documents/TEA/BioChemical/Data/CLASSIFICATION/LULC-20220611T143740Z-001/LULC/Sonitpur_2022_LULC.tif")
chl_raster <- raster("/Users/ceedindia/Documents/TEA/BioChemical/Data/INDICES/New folder/Sonitpur_21_CHL.tif")

# Extract unique LULC classes
lulc_classes <- unique(values(lulc_raster))

# Function to calculate zonal statistics for a given class
zonal_stats <- function(class, lulc_raster, chl_raster) {
  mask <- lulc_raster == class
  masked_chl <- mask(chl_raster, mask)
  masked_values <- values(masked_chl)
  masked_values <- masked_values[!is.na(masked_values)]  # Exclude NA values
  
  return(data.table(
    LULC_Class = class,
    mean = mean(masked_values),
    sum = sum(masked_values),
    std_dev = sd(masked_values)
  ))
}

# Apply the function to each LULC class and combine the results
results <- lapply(lulc_classes, zonal_stats, lulc_raster, chl_raster)
results_df <- rbindlist(results)

# Export the results to a CSV file
write.csv(results_df, "/path/to/zonal_statistics.csv", row.names = FALSE)
