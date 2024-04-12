library(sp)
library(ncdf4)
library(rgeos)
library(raster)
library(maptools)
library(rgdal)
library(rasterVis)
library(RColorBrewer)
library(latticeExtra)
setwd ("D:/DISSERTATION")
getwd()
## ----------- Adding Of Shapefiles --------------------------
#shp <- shapefile("D:/DISSERTATION/ASSAM SHP/Assam_District/Dibrugarh.shp")
studydis <- shapefile("D:/DISSERTATION/ASSAM SHP/Assam_District/Study_area/study_dis.shp")

indForest <- raster("D:/DISSERTATION/INDICES/Decadal_LULC_India_1336/LULC_2005_Clip1.tif")
unique(indForest)

# create classification matrix
reclass_df <- c(1, 1, 1,
                1.1, 3.1, NA,
                3.2, 5.1, 1,
                7.1, 10.1, NA,
                13.1, 15.1, 1)
reclass_df

# reshape the object into a matrix with columns and rows
reclass_m <- matrix(reclass_df,
                    ncol = 3,
                    byrow = TRUE)
reclass_m

# reclassify the raster using the reclass object - reclass_m
library(snow)
beginCluster()

chm_classified <- reclassify(indForest,
                             reclass_m)
endCluster()

unique(chm_classified)

plot(chm_classified)

## --------------------- Dibrugarh Indices ----------- Masking -------------------------
dib21 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Dibrugarh_2021.tif")
diblai21 <- raster("D:/DISSERTATION/INDICES/Dibrugarh_21_LAI.tif")
dibfpar21 <- raster("D:/DISSERTATION/INDICES/Dibrugarh_21_FPAR.tif")
dibevi21 <- raster("D:/DISSERTATION/INDICES/Dibrugarh_21_EVI.tif")
dibchl21 <- raster("D:/DISSERTATION/INDICES/Dibrugarh_21_CHL.tif")
dibnbi21 <- raster("D:/DISSERTATION/INDICES/NBI-20220505T060453Z-001/NBI/Dibrugarh_21_NBI.tif")

dib21[dib21 == 1] <- NA
plot(dib21)

diblai21 <- resample(diblai21, dib21)
diblai21_msk <- mask(diblai21, dib21)
plot(diblai21_msk)

dibfpar21 <- resample(dibfpar21,dib21)
dibfpar21_msk <- mask(dibfpar21,dib21)
plot(dibfpar21_msk)

dibevi21 <- resample(dibevi21,dib21)
dibevi21_msk <- mask(dibevi21,dib21)
plot(dibevi21_msk)

dibchl21 <- resample(dibchl21,dib21)
dibchl21_msk <- mask(dibchl21,dib21)
plot(dibchl21_msk)

dibnbi21 <- resample(dibnbi21,dib21)
dibnbi21_msk <- mask(dibnbi21,dib21)
plot(dibnbi21_msk)

## --------------------- Sonitpur Indices ----------- Masking -------------------------

soni21 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Sonitpur_2021.tif")
sonilai21 <- raster("D:/DISSERTATION/INDICES/New folder/Sonitpur_LAI.tif")
sonifpar21 <- raster("D:/DISSERTATION/INDICES/New folder/Sonitpur_21_FPAR.tif")
sonievi21 <- raster("D:/DISSERTATION/INDICES/New folder/Sonitpur_21_EVI.tif")
sonichl21 <- raster("D:/DISSERTATION/INDICES/New folder/Sonitpur_21_CHL.tif")
soninbi21 <- raster("D:/DISSERTATION/INDICES/NBI-20220505T060453Z-001/NBI/Sonitpur_21_NBI.tif")

soni21[soni21 == 1] <- NA
plot(soni21)

sonilai21 <- resample(sonilai21, soni21)
sonilai21_msk <- mask(sonilai21, soni21)
plot(sonilai21_msk)

sonifpar21 <- resample(sonifpar21, soni21)
sonifpar21_msk <- mask(sonifpar21, soni21)
plot(sonifpar21_msk)

sonievi21 <- resample(sonievi21, soni21)
sonievi21_msk <- mask(sonievi21, soni21)
plot(sonievi21_msk)

sonichl21 <- resample(sonichl21, soni21)
sonichl21_msk <- mask(sonichl21, soni21)
plot(sonichl21_msk)

soninbi21 <- resample(soninbi21, soni21)
soninbi21_msk <- mask(soninbi21, soni21)
plot(soninbi21_msk)

## --------------------- Jorhat Indices ----------- Masking -------------------------

jor21 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Jorhat_2021.tif")
jorlai21 <- raster("D:/DISSERTATION/INDICES/New folder/Jorhat_21_LAI.tif")
jorfpar21 <- raster("D:/DISSERTATION/INDICES/New folder/Jorhat_21_FPAR.tif")
jorevi21 <- raster("D:/DISSERTATION/INDICES/New folder/Jorhat_21_EVI.tif")
jorchl21 <- raster("D:/DISSERTATION/INDICES/New folder/Jorhat_21_CHL.tif")
jornbi21 <- raster("D:/DISSERTATION/INDICES/NBI-20220505T060453Z-001/NBI/Jorhat_21_NBI.tif")

jor21[jor21 == 1] <- NA
plot(jor21)

jorlai21 <- resample(jorlai21, jor21)
jorlai21_msk <- mask(jorlai21, jor21)
plot(jorlai21_msk)

jorfpar21 <- resample(jorfpar21, jor21)
jorfpar21_msk <- mask(jorfpar21, jor21)
plot(jorfpar21_msk)

jorevi21 <- resample(jorevi21, jor21)
jorevi21_msk <- mask(jorevi21, jor21)
plot(jorevi21_msk)

jorchl21 <- resample(jorchl21, jor21)
jorchl21_msk <- mask(jorchl21, jor21)
plot(jorchl21_msk)

jornbi21 <- resample(jornbi21, jor21)
jornbi21_msk <- mask(jornbi21, jor21)
plot(jornbi21_msk)

## --------------------- Sivsagar Indices ----------- Masking -------------------------

siv21 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Sivsagar_2021.tif")
sivlai21 <- raster("D:/DISSERTATION/INDICES/New folder/Sivsagar_LAI.tif")
sivfpar21 <- raster("D:/DISSERTATION/INDICES/New folder/Sivsagar_21_FPAR.tif")
sivevi21 <- raster("D:/DISSERTATION/INDICES/New folder/Sivsagar_21_EVI.tif")
sivchl21 <- raster("D:/DISSERTATION/INDICES/New folder/Sivsagar_21_CHL.tif")
sibnbi21 <- raster("D:/DISSERTATION/INDICES/NBI-20220505T060453Z-001/NBI/Sivsagar_21_NBI.tif")

siv21[siv21 == 1] <- NA
plot(siv21)

sivlai21 <- resample(sivlai21, siv21)
sivlai21_msk <- mask(sivlai21, siv21)
plot(sivlai21_msk)

sivfpar21 <- resample(sivfpar21, siv21)
sivfpar21_msk <- mask(sivfpar21, siv21)
plot(sivfpar21_msk)

sivevi21 <- resample(sivevi21, siv21)
sivevi21_msk <- mask(sivevi21, siv21)
plot(sivevi21_msk)

sivchl21 <- resample(sivchl21, siv21)
sivchl21_msk <- mask(sivchl21, siv21)
plot(jorchl21_msk)

sibnbi21 <- resample(sibnbi21, siv21)
sivnbi21_msk <- mask(sibnbi21, siv21)
plot(sivnbi21_msk)

## --------------------- Tinsukia Indices ----------- Masking -------------------------

tin21 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Tinsukia_2021.tif")
tinlai21 <- raster("D:/DISSERTATION/INDICES/New folder/Tinsukia_21_LAI.tif")
tinfpar21 <- raster("D:/DISSERTATION/INDICES/New folder/Tinsukia_21_FPAR.tif")
tinevi21 <- raster("D:/DISSERTATION/INDICES/New folder/Tinsukia_21_EVI.tif")
tinchl21 <- raster("D:/DISSERTATION/INDICES/New folder/Tinsukia_21_CHL.tif")
tinnbi21 <- raster("D:/DISSERTATION/INDICES/NBI-20220505T060453Z-001/NBI/Tinsukia_21_NBI.tif")

tin21[tin21 == 1] <- NA
plot(tin21)

tinlai21 <- resample(tinlai21, tin21)
tinlai21_msk <- mask(tinlai21, tin21)
plot(sivlai21_msk)

tinfpar21 <- resample(tinfpar21, tin21)
tinfpar21_msk <- mask(tinfpar21, tin21)
plot(tinfpar21_msk)

tinevi21 <- resample(tinevi21, tin21)
tinevi21_msk <- mask(tinevi21, tin21)
plot(tinevi21_msk)

tinchl21 <- resample(tinchl21, tin21)
tinchl21_msk <- mask(tinchl21, tin21)
plot(tinchl21_msk)

tinnbi21 <- resample(tinnbi21, tin21)
tinnbi21_msk <- mask(tinnbi21, tin21)
plot(tinnbi21_msk)

## -------------------- Merging Masked IMages of Different Indicies---------------------

mergedrasterlai <- raster::merge(sonilai21_msk, jorlai21_msk, sivlai21_msk,  diblai21_msk, tinlai21_msk, 
                              tolerance = 0.3)
plot(mergedrasterlai, ylim = c(26.5, 28))

mergedrasterevi <- raster::merge(sonievi21_msk, jorevi21_msk, sivevi21_msk, dibevi21_msk, tinevi21_msk,
                                 tolerance = 0.3)
plot(mergedrasterevi, ylim = c(26.5, 28))

mergedrasterfpar <- raster::merge(sonifpar21_msk, jorfpar21_msk, sivfpar21_msk, dibfpar21_msk, tinfpar21_msk,
                                  tolerance = 0.3)
plot(mergedrasterfpar, ylim = c(26.5, 28))

mergedrasterchl <- raster::merge(sonichl21_msk, jorchl21_msk, sivchl21_msk, dibchl21_msk, tinchl21_msk,
                                 tolerance = 0.3)
plot(mergedrasterchl, ylim = c(26.5, 28))

mergedrasternbi <- raster::merge(soninbi21_msk, jornbi21_msk, sivnbi21_msk, dibnbi21_msk, tinnbi21_msk, 
                                 tolerance = 0.3)
plot(mergedrasternbi, ylim = c(26.5, 28))

## ----------------- Merged Complete Indicies of Different Districts of Assam ---------------------

mergedrasterlai1 <- raster::merge(sonilai21, jorlai21, sivlai21,  diblai21, tinlai21, 
                                 tolerance = 0.3)
plot(mergedrasterlai1, ylim = c(26.5, 28))

mergedrasterevi1 <- raster::merge(sonievi21, jorevi21, sivevi21, dibevi21, tinevi21,
                                 tolerance = 0.3)
plot(mergedrasterevi1, ylim = c(26.5, 28))

mergedrasterfpar1 <- raster::merge(sonifpar21, jorfpar21, sivfpar21, dibfpar21, tinfpar21,
                                  tolerance = 0.3)
plot(mergedrasterfpar1, ylim = c(26.5, 28))

mergedrasterchl1 <- raster::merge(sonichl21, jorchl21, sivchl21, dibchl21, tinchl21,
                                 tolerance = 0.3)
plot(mergedrasterchl1, ylim = c(26.5, 28))

mergedrasternbi1 <- raster::merge(soninbi21, jornbi21, sibnbi21, dibnbi21, tinnbi21, 
                                 tolerance = 0.3)
plot(mergedrasternbi1, ylim = c(26.5, 28))

### ------------------------------------------- Tea and Forest Masking -----------------------------------------------------
## ---------------------------------------------------- LAI ----------------------------------------------------------------
mergedrasterlai <- resample(mergedrasterlai, chm_classified)
mergedrasterlai11 <- resample(mergedrasterlai1, chm_classified)
indForestmm <- mask(mergedrasterlai11, chm_classified)
LAI_F_T <- raster::merge(mergedrasterlai, indForestmm)
LAI_F_T1 <- reclassify(LAI_F_T, cbind(-Inf, 0, NA))
plot(LAI_F_T1)

## -----------------------------------------------------FPAR-----------------------------------------------------------------
mergedrasterfpar <- resample(mergedrasterfpar, chm_classified)
mergedrasterfpar11 <- resample(mergedrasterfpar1, chm_classified)
forestM <- mask(mergedrasterfpar11, chm_classified)
FPAR_F_T <- raster::merge(mergedrasterfpar, forestM)
FPAR_F_T1 <- reclassify(FPAR_F_T, cbind(-Inf, 0.2, NA))
plot(FPAR_F_T1)
## ------------------------------------------------------ EVI -------------------------------------------------------------
mergedrasterevi <- resample(mergedrasterevi, chm_classified)
mergedrasterevi11 <- resample(mergedrasterevi1, chm_classified)
forestM1 <- mask(mergedrasterevi11, chm_classified)
EVI_F_T <- raster::merge(mergedrasterevi, forestM1)
EVI_F_T1 <- reclassify(EVI_F_T, cbind(-Inf, 0, NA))
plot(EVI_F_T1)

## ----------------------------------------------------- chlorophyll ----------------------------------------------------
mergedrasterchl <- resample(mergedrasterchl, chm_classified)
mergedrasterchl11 <- resample(mergedrasterchl1, chm_classified)
forestM2 <- mask(mergedrasterchl11, chm_classified)
CHL_F_T <- raster::merge(mergedrasterchl, forestM2)
CHL_F_T1 <- reclassify(CHL_F_T, cbind(-Inf, 0, NA))
plot(CHL_F_T1)

## -------------------------------------------------------- NBI ----------------------------------------------------------
mergedrasternbi <- resample(mergedrasternbi, chm_classified)
mergedrasternbi11 <- resample(mergedrasternbi1, chm_classified)
forestM3 <- mask(mergedrasternbi11, chm_classified)
NBI_F_T <- raster::merge(mergedrasternbi, forestM3)
NBI_F_T1 <- reclassify(NBI_F_T, cbind(-Inf, 0, NA))
plot(NBI_F_T1)

library(latticeExtra)
# setting your own colors
mytheme <- rasterTheme(region = brewer.pal(9, "YlGn"))
 

a <- levelplot(mergedrasterlai, margin = FALSE, par.settings = mytheme,
          main = "Leaf Area Index 2022 of five district",
          colorkey = list(space = "bottom", width = 0.7))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

a <- levelplot(mergedrasterevi, margin = FALSE, par.settings = mytheme,
               main = "Enhanced Vegetation Index 2022 of five district",
               colorkey = list(space = "bottom", width = 0.7))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

a <- levelplot(mergedrasterfpar, margin = FALSE, par.settings = mytheme,
               main = "Fraction of Photosynthetically Active Radiation 2022 of five district",
               colorkey = list(space = "bottom", width = 0.7))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

a <- levelplot(mergedrasterchl, margin = FALSE, par.settings = mytheme,
               main = "Chlorophyll (µg/cm2) 2022 of five district",
               colorkey = list(space = "bottom", width = 0.7))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

a <- levelplot(mergedrasternbi, margin = FALSE, par.settings = mytheme,
               main = "NBI (Nitrogen Balance Index) 2022 of five district",
               colorkey = list(space = "bottom", width = 0.7))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

##---------------------------------------------------------------------------------------------------
##----------------------------- Complete Indicies Plot ---------------------------------------------

a <- levelplot(LAI_F_T1, margin = FALSE, par.settings = mytheme,
               ylim = c(26.2, 28),
               xlim = c(92.3, 96),
               main = "Leaf Area Index 2022 of five district",
               colorkey = list(space = "right", width = 0.9))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

a <- levelplot(EVI_F_T1, margin = FALSE, par.settings = mytheme,
               ylim = c(26.2, 28),
               xlim = c(92.3, 96),
               main = "               Enhanced Vegetation Index 2022 of five district",
               colorkey = list(space = "right", width = 0.9))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

a <- levelplot(FPAR_F_T1, margin = FALSE, par.settings = mytheme,
               ylim = c(26.2, 28),
               xlim = c(92.3, 96),
               main = "             Fraction of Photosynthetically Active Radiation 2022 of five district",
               colorkey = list(space = "right", width = 0.9))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

a <- levelplot(CHL_F_T1, margin = FALSE, par.settings = mytheme,
               ylim = c(26.2, 28),
               xlim = c(92.3, 96),
               main = "Chlorophyll (µg/cm2) 2022 of five district",
               colorkey = list(space = "right", width = 0.9))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

a <- levelplot(NBI_F_T1, margin = FALSE, par.settings = mytheme,
               ylim = c(26.2, 28),
               xlim = c(92.3, 96),
               main = "       NBI (Nitrogen Balance Index) 2022 of five district",
               colorkey = list(space = "right", width = 0.9))
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

## ---------------------------------------- Plotting of Histograms --------------------------------------------------
## ---------------------------------------------------------------------------------------------------------------

# Create the histogram.
hist(FPAR_F_T1,xlab = "FPAR (Fraction of Photosynthetically Active Radiation)",col = "lightgreen",border = "black", 
     main = "FPAR Tea along with Forest Pixels Values", xlim = c(0.2,1))

hist(EVI_F_T1,xlab = "EVI (Enchaced Vegetation Index)",col = "lightgreen",border = "black", 
     main = "EVI Tea along with Forest Pixels Values", xlim = c(0.0,0.6))

hist(CHL_F_T1,xlab = "Chl (Chlorophyll)",col = "lightgreen",border = "black", 
     main = "Chlorophyll Tea along with Forest Pixels Values", xlim = c(0,40))

hist(NBI_F_T1,xlab = "NBI (Nitrogen Balance Index)",col = "lightgreen",border = "black", 
     main = "NBI Tea along with Forest Pixels Values", xlim = c(0,40))
