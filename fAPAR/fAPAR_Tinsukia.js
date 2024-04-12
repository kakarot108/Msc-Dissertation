 var maskcloud1 = function(image) { 
var QA60 = image.select(['QA60']);
return image.updateMask(QA60.lt(1));
};

//core use for data call 
var image = ee.ImageCollection("COPERNICUS/S2_SR")
  .filterBounds(table)
  .filterDate('2021-03-01', '2021-03-30') // change date range here
  .map(maskcloud1)
  .median()
  .clip(table);

print(image);

//calculting NDVI
var NDVI = image.expression (
  '((NIR-RED)/(NIR+RED))',{
    'NIR': image.select('B8'),
    'RED': image.select('B4'),
  }).rename('NDVI');
  
print('NDVI',NDVI);

var palettes = require('users/gena/packages:palettes');
var palette = palettes.colorbrewer.Greens[9];
    
Map.centerObject(table,8);

//NDVI VISUALIZATION

var NDVIParams = {min: -1, max: 1, palette: palette};
Map.addLayer(NDVI, NDVIParams, 'NDVI image');

//Calculating min and max values:
var min = NDVI.reduceRegion(ee.Reducer.min(), table, 40).values();
print(min, 'NDVI_Min');
var max = NDVI.reduceRegion(ee.Reducer.max(), table, 40).values();
print(max, 'NDVI_max');

var FPAR = NDVI.expression (
  '((NDVI-(-0.26))*(0.95-0.05)/((0.72-(-0.26))))+0.05',{
    'NDVI': NDVI.select('NDVI')
  }).rename('FPAR');
print('FPAR',FPAR);

var palettes = require('users/gena/packages:palettes');
var palette = palettes.colorbrewer.Greens[9];

Map.centerObject(table,8);
var fparParams = {min: 0, max: 1, palette: palette};
Map.addLayer(FPAR, fparParams, 'FPAR image');

var min = FPAR.reduceRegion(ee.Reducer.min(), table, 40).values();
print(min, 'FPAR_Min');
var max = FPAR.reduceRegion(ee.Reducer.max(), table, 40).values();
print(max, 'FPAR_max');
