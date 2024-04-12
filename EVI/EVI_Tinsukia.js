/** 
 * Function to mask clouds using the Sentinel-2 QA band
 * @param {ee.Image} image Sentinel-2 image
 * @return {ee.Image} cloud masked Sentinel-2 image
 */
var S2 = ee.ImageCollection("COPERNICUS/S2");
 
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
//computing EVI
var evi = data.expression(
    '2.5 * ((NIR - RED) / (NIR + 6 * RED - 7.5 * BLUE + 1))', {
      'NIR': data.select('B8'),
      'RED': data.select('B4'),
      'BLUE': data.select('B2')
});
// Display the result.
Map.centerObject(data, 8);
var eviParams = {min: -1, max: 1, palette: ['brown','white','darkgreen']};
Map.addLayer(evi, eviParams, 'evi');
//Map.setCenter(76.5257,11.6376); 
Map.centerObject(AOI, 8);
// Export the image, specifying scale and region.
//Export.image.toDrive({
  //image: evi,
  //description: 'EVI_2021',
  //scale: 10,
  //fileFormat: 'GeoTIFF',
  //region: AOI,
  //maxPixels: 995731250,
  //formatOptions: {
    //cloudOptimized: true
  //}
//});
