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

//calculting NOAC

var NAOC = image.expression(
          '(1/2*(1- red/rededge))',{
            'red': image.select('B4'),
            'rededge': image.select('B7'),
            
         }).rename('NAOC');
print(NAOC);
         
var chl = NAOC.expression(
  '-3.8868 + 101.94 * NAOC',{
    'NAOC': NAOC.select('NAOC')
  }).rename('Chl');

var palettes = require('users/gena/packages:palettes');
var palette = palettes.colorbrewer.Greens[9];
    
print(chl);
var min = chl.reduceRegion(ee.Reducer.min(), table, 20).values();
print(min, 'chl_Min');
var max = chl.reduceRegion(ee.Reducer.max(), table, 20).values();
print(max, 'chl_max');
Map.centerObject(table,8);

/*var ChlPalette = ['FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718',
              '74A901', '66A000', '529400', '3E8601', '207401', '056201',
              '004C00', '023B01', '012E01', '011D01', '011301'];
*/
var ChlParams = {min: 0, max: 40, palette: palette};
Map.addLayer(chl, ChlParams, 'CHL image');
