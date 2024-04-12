install.packages("sf")
library(ncdf4)
library(rgeos)
library(raster)
library(maptools)
library(rgdal)
library(rasterVis)
library(RColorBrewer)
library(latticeExtra)
library(sf)
setwd ("D:/DISSERTATION")
getwd()
studydis <- read_sf("D:/DISSERTATION/ASSAM SHP/Assam_District/Study_area/study_dis.shp")
ggplot(studydis) +
  geom_sf(aes(fill = ST_NM), color = "black", inherit.aes = F, alpha = 1)
names(studydis)
## ----------------- 1990 ----------------------------

soni90 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/1990/Sonitpur_1990.tif")
jor90 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/1990/Jorhat_1990.tif")
sib90 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/1990/Sivsagar_1990.tif")
dib90 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/1990/Dibrugarh_1990.tif")
tin90 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/1990/Tinsukia_1990.tif")
#plot(soni90)

soni90[soni90 == 1] <- NA
soni90_poly <- rasterToPolygons(soni90) 
shapefile(soni90_poly, 'sonitpur_1990_shp.shp')

jor90[jor90 == 1] <- NA
jor90_poly <- rasterToPolygons(jor90) 
shapefile(jor90_poly, 'Jorhat_1990_shp11.shp')

sib90[sib90 == 1] <- NA
sib90_poly <- rasterToPolygons(sib90) 
shapefile(sib90_poly, 'Sivsagar_1990_shp.shp')

dib90[dib90 == 1] <- NA
dib90_poly <- rasterToPolygons(dib90) 
shapefile(dib90_poly, 'Dibrugarh_1990_shp.shp')

tin90[tin90 == 1] <- NA
tin90_poly <- rasterToPolygons(tin90) 
shapefile(tin90_poly, 'Tinsukia_1990_shp.shp')

#plot(soni90_poly)
fr <- st_read(soni90_poly)
fe$area <- st_area(fr)
fr$area <- fr$area/1000000

#Transform non-NA values to 1
soni90[!is.na(soni90)]<-1

#Get frequency of pixels by value
#1's will be the number of non-NA pixels
freq(soni90)

#-----------------------------------------
mergedraster90 <- raster::merge(soni90, jor90, sib90,  dib90, tin90, 
                                 tolerance = 0.3)
plot(mergedraster90, ylim = c(25.75, 28))

l<-as.factor(mergedraster90)
rat <- levels(l)[[1]]
rat[["landcover"]] <- c("Tea Plantation", "Non Tea")
levels(mergedraster90) <- rat
a <- levelplot(mergedraster90, col.regions=c("darkGreen","lightblue"), 
          main = "Tea Plantation Map of 1990", xlab="Longitude", ylab="Latitude",)
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

soni2000 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2000/Sonitpur_2000.tif")
jor2000 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2000/Jorhat_2000.tif")
sib2000 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2000/Sivsagar_2000.tif")
dib2000 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2000/Dibrugarh_2000.tif")
tin2000 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2000/Tinsukia_2000.tif")

soni2000[soni2000 == 1] <- NA
soni2000_poly <- rasterToPolygons(soni2000) 
shapefile(soni2000_poly, 'sonitpur_2000_shp.shp')

jor2000[jor2000 == 1] <- NA
jor2000_poly <- rasterToPolygons(jor2000) 
shapefile(jor2000_poly, 'Jorhat_200_shp.shp')

sib2000[sib2000 == 1] <- NA
sib2000_poly <- rasterToPolygons(sib2000) 
shapefile(sib2000_poly, 'Sivsagar_2000_shp.shp')

dib2000[dib2000 == 1] <- NA
dib2000_poly <- rasterToPolygons(dib2000) 
shapefile(dib2000_poly, 'Dibrugarh_2000_shp.shp')

tin2000[tin2000 == 1] <- NA
tin2000_poly <- rasterToPolygons(tin2000) 
shapefile(tin2000_poly, 'Tinsukia_2000_shp.shp')

mergedraster2000 <- raster::merge(soni2000, jor2000, sib2000,  dib2000, tin2000, 
                                tolerance = 0.3)
plot(mergedraster2000, ylim = c(25.75, 28))

l<-as.factor(mergedraster2000)
rat <- levels(l)[[1]]
rat[["landcover"]] <- c("Tea Plantation", "Non Tea")
levels(mergedraster2000) <- rat
a <- levelplot(mergedraster2000, col.regions=c("darkGreen","lightblue"), 
               main = "Tea Plantation Map of 2000", xlab="Longitude", ylab="Latitude",)
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

soni2010 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2010/Sonitpur_2010.tif")
jor2010 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2010/Jorhat_2010.tif")
sib2010 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2010/Sivsagar_2010.tif")
dib2010 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2010/Dibrugarh_2010.tif")
tin2010 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2010/Tinsukia_2010.tif")
#plot(sib2010)

soni2010[soni2010 == 1] <- NA
soni2010_poly <- rasterToPolygons(soni2010) 
shapefile(soni2010_poly, 'sonitpur_2010_shp.shp')

jor2010[jor2010 == 1] <- NA
jor2010_poly <- rasterToPolygons(jor2010) 
shapefile(jor2010_poly, 'Jorhat_2010_shp.shp')

sib2010[sib2010 == 1] <- NA
sib2010_poly <- rasterToPolygons(sib2010) 
shapefile(sib2010_poly, 'Sivsagar_2010_shp.shp')

dib2010[dib2010 == 1] <- NA
dib2010_poly <- rasterToPolygons(dib2010) 
shapefile(dib2010_poly, 'Dibrugarh_2010_shp.shp')

tin2010[tin2010 == 1] <- NA
tin2010_poly <- rasterToPolygons(tin2010) 
shapefile(tin2010_poly, 'Tinsukia_2010_shp.shp')

mergedraster2010 <- raster::merge(soni2010, jor2010, sib2010,  dib2010, tin2010, 
                                  tolerance = 0.3)
plot(mergedraster2010, ylim = c(25.75, 28))

l<-as.factor(mergedraster2010)
rat <- levels(l)[[1]]
rat[["landcover"]] <- c("Tea Plantation", "Non Tea")
levels(mergedraster2010) <- rat
a <- levelplot(mergedraster2010, col.regions=c("darkGreen","lightblue"), 
               main = "Tea Plantation Map of 2010", xlab="Longitude", ylab="Latitude",)
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

soni2022 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Sonitpur_2021.tif")
jor2022 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Jorhat_2021.tif")
sib2022 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Sivsagar_2021.tif")
dib2022 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Dibrugarh_2021.tif")
tin2022 <- raster("D:/DISSERTATION/CLASSIFICATION/Clipped_Classification/2021/Tinsukia_2021.tif")

soni2022[soni2022 == 1] <- NA
soni2022_poly <- rasterToPolygons(soni2022) 
shapefile(soni2022_poly, 'sonitpur_2022_shp.shp')

jor2022[jor2022 == 1] <- NA
jor2022_poly <- rasterToPolygons(jor2022) 
shapefile(jor2022_poly, 'Jorhat_2022_shp.shp')

sib2022[sib2022 == 1] <- NA
sib2022_poly <- rasterToPolygons(sib2022) 
shapefile(sib2022_poly, 'Sivsagar_2022_shp.shp')

dib2022[dib2022 == 1] <- NA
dib2022_poly <- rasterToPolygons(dib2022) 
shapefile(dib2022_poly, 'Dibrugarh_2022_shp.shp')

tin2022[tin2022 == 1] <- NA
tin2022_poly <- rasterToPolygons(tin2022) 
shapefile(tin2022_poly, 'Tinsukia_2022_shp.shp')

mergedraster2022 <- raster::merge(soni2022, jor2022, sib2022,  dib2022, tin2022, 
                                  tolerance = 0.3)
plot(mergedraster2022, ylim = c(25.75, 28))

writeRaster(mergedraster2022, filename="Tea_Plantation_2022.tif", format="GTiff", overwrite=TRUE)

l<-as.factor(mergedraster2022)
rat <- levels(l)[[1]]
rat[["landcover"]] <- c("Tea Plantation", "Non Tea")
levels(mergedraster2022) <- rat
a <- levelplot(mergedraster2022, col.regions=c("darkGreen","lightblue"), 
               main = "Tea Plantation Map of 2022", xlab="Longitude", ylab="Latitude",)
a + layer(sp.polygons(studydis, col = 'black', lwd = 0.5))

          
