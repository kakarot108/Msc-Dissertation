/**
 * Function to mask clouds using the Sentinel-2 QA band
 * @param {ee.Image} image Sentinel-2 image
 * @return {ee.Image} cloud masked Sentinel-2 image
 */ 
function maskS2clouds(image) {
  var qa = image.select('QA60');

  // Bits 10 and 11 are clouds and cirrus, respectively.
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  // Both flags should be set to zero, indicating clear conditions.
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
      .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  return image.updateMask(mask).divide(10000);
}

var dataset = S2.filterBounds(AOI).filterDate('2021-03-01', '2021-03-30').filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
                  .map(maskS2clouds).median()
var data = dataset.clip(AOI);

var lai = data.expression(
      '6.753*((NIR-RED)/(NIR+RED))',{
        'NIR': data.select('B8'),
        'RED': data.select('B4'),
        
      });
      
  print('LAI Dibrugarh',lai);
  Map.centerObject(AOI, 8);
var palettes = require('users/gena/packages:palettes');
var palette = palettes.colorbrewer.Greens[9];
var laiParams = {min: 0, max: 5, palette: palette};
Map.addLayer(lai, laiParams, 'LAI image');
