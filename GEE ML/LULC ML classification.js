GEE - Code: https://code.earthengine.google.com/d625b7a78b47f8372748e8fa30642622?noload=true

//////////// LU/LC classes = Water _ Agriculture _ Waste Land _Built Up _ Forest
// Sentinel 2a cloud masking ---------------------------------------------------------- 
function maskCloudAndShadowsSR(image) {
  var cloudProb = image.select('MSK_CLDPRB');
  var snowProb = image.select('MSK_SNWPRB');
  var cloud = cloudProb.lt(10);
  var scl = image.select('SCL'); 
  var shadow = scl.eq(3); // 3 = cloud shadow
  var cirrus = scl.eq(10); // 10 = cirrus
  // Cloud probability less than 10% or cloud shadow classification
  var mask = cloud.and(cirrus.neq(1)).and(shadow.neq(1));
  return image.updateMask(mask);
}

//core use for data call ---------------------------------------------------------------
var image = ee.ImageCollection("COPERNICUS/S2_SR")
  .filterBounds(table)
  .filterDate('2020-01-01', '2020-12-30') // change date range here
  .map(maskCloudAndShadowsSR)
  .median()
  .clip(table);

print(image);

//Add indicies for Better Accuracy
var addIndices = function(image) {
  var ndvi = image.normalizedDifference(['B8', 'B4']).rename(['ndvi']);
  var ndbi = image.normalizedDifference(['B11', 'B8']).rename(['ndbi']);
  var mndwi = image.normalizedDifference(['B3', 'B11']).rename(['mndwi']); 
  var bsi = image.expression(
      '(( X + Y ) - (A + B)) /(( X + Y ) + (A + B)) ', {
        'X': image.select('B11'), //swir1
        'Y': image.select('B4'),  //red
        'A': image.select('B8'), // nir
        'B': image.select('B2'), // blue
    }).rename('bsi');
  var evi = image.expression(
    '2.5 * ((NIR - RED) / (NIR + 6 * RED - 7.5 * BLUE + 1))', {
      'NIR': image.select('B8'),
      'RED': image.select('B4'),
      'BLUE': image.select('B2')
    }).rename('evi');
  var evi2 = image.expression(
    '2.4 * ((NIR - RED) / (NIR + RED + 1))', {
      'NIR': image.select('B8'),
      'RED': image.select('B4'),
      'BLUE': image.select('B2')
    }).rename('evi2');
  var evi2_2 = image.expression(
    '2.5 * ((NIR - RED) / (NIR + 2.4 * RED + 1))', {
      'NIR': image.select('B8'),
      'RED': image.select('B4'),
      'BLUE': image.select('B2')
    }).rename('evi2_2');
  var gari = image.expression(
    'B8 -(B3-(B2-B4))/B8-(B3+(B2-B4))',{
      'B8': image.select('B8'),
      'B4': image.select('B4'),
      'B3': image.select('B3'),
      'B2': image.select('B2')
    }).rename('gari');
  var gbndvi = image.expression(
    'B8-(B3+B2)/B8+(B3+B2)',{
     'B8': image.select('B8'),
     'B3': image.select('B3'),
     'B2': image.select('B2') 
    }).rename('gbndvi');
  var gdvi = image.expression(
    'B8-B3',{
     'B8': image.select('B8'),
     'B3': image.select('B3')
    }).rename('gdvi');
  var savi = image.expression(
    '1.5*B8-B4/B8+B4+0.5',{
      'B8': image.select('B8'),
      'B4': image.select('B4')
    }).rename('savi');
  var gli = image.expression(
    '2*B3-B5-B2/2*B3+B5+B2',{
      'B3': image.select('B3'),
      'B5': image.select('B5'),
      'B2': image.select('B2') 
    }).rename('gli');
  var gndvi = image.expression(
    'B8-B3/B8+B3',{
     'B8': image.select('B8'),
     'B3': image.select('B3')
    }).rename('gndvi');
  var lci = image.expression(
    'B8-B5/B8+B4',{
      'B8': image.select('B8'),
      'B5': image.select('B5'),
      'B4': image.select('B4')
    }).rename('lci');
  var mndvi = image.expression(
    'B8-B4/B8+B4-2*B2',{
      'B8': image.select('B8'),
      'B4': image.select('B4'),
      'B2': image.select('B2')
     }).rename('mndvi');
  var msavi2 = image.expression(
  '(2 * NIR + 1 - sqrt(pow((2 * NIR + 1), 2) - 8 * (NIR - RED)) ) / 2',{
      'NIR': image.select('B8'), 
      'RED': image.select('B4')
  }).rename('msavi2');
  var ndre = image.expression(
    'B7-B5/B7+B5',{
      'B7': image.select('B7'),
      'B5': image.select('B5')
    }).rename('ndre');
  var tci = image.expression(
    '1.2*(B5-B3)-1.5*(B4-B3)*sqrt(B5/B4)',{
      'B5': image.select('B5'),
      'B4': image.select('B4'),
      'B3': image.select('B3')
    }).rename('tci');
  var tvi = ndvi.expression(
    'sqrt(ndvi+0.5)',{
      'ndvi': ndvi.select('ndvi')
    }).rename('tvi');
  var vi700 = image.expression(
    'B5-B4/B5+B4',{
     'B5': image.select('B5'),
     'B4': image.select('B4')
    }).rename('vi700');
  var slavi = image.expression(
    'B8/B4+B12',{
      'B8': image.select('B8'),
      'B4': image.select('B4'),
      'B12': image.select('B12')
    }).rename('slavi');
return image.addBands(ndvi).addBands(ndbi).addBands(mndwi).addBands(bsi).addBands(evi).addBands(evi2).addBands(evi2_2).addBands(gari).addBands(gbndvi).addBands(gdvi).addBands(savi).addBands(gli).addBands(gndvi).addBands(lci).addBands(mndvi).addBands(msavi2).addBands(ndre).addBands(tci).addBands(tvi).addBands(vi700).addBands(slavi)
}

var Image1 = addIndices(image);
print(Image1, 'Image1');

var label = 'class' 
var bands = ['B2', 'B3', 'B4','B5','B6','B7','B8', 'B8A','B11', 'ndvi', 'ndbi', 'mndwi', 'bsi', 'evi', 'evi2', 'evi2_2','gari','gbndvi','gdvi','savi','gli','gndvi','lci','mndvi','msavi2','ndre','tci','tvi','vi700','slavi']; // These are bands with 10 meter spatial resolution. 


var visParamsTrue = {bands: ['B8', 'B4', 'B3'], min: 0, max: 2500, gamma: 1.1};
Map.centerObject(table, 10);
Map.addLayer(Image1, visParamsTrue, 'image');

// selects the bands 
var Image1 = Image1.select(bands)
print(Image1,'IMAGE1');

/////////////////////////////// Merging Control Points ////////////////////////////////////////////

var gcps = Water.merge(Agriculture).merge(Waste_Land).merge(Built_Up).merge(Forest).merge(Tea_Plantation);
print(gcps, 'gcps');

// Export flood polygons as shape-file
Export.table.toDrive({
  collection:gcps,
  description:'Gcps_Dibrugarh',
  fileFormat:'SHP',
  fileNamePrefix:'Gcps_Dibrugarh'
});

var classProperty = 'class';

var training = Image1.select(bands).sampleRegions({
  collection: gcps,
  properties: [classProperty],
  scale: 80
});
print(training, 'training');

var withRandom = training.randomColumn('random');
// We want to reserve some of the data for testing, to avoid overfitting the model.
var split = 0.7;  // Roughly 70% training, 30% testing.
var trainingPartition = withRandom.filter(ee.Filter.lt('random', split));
var testingPartition = withRandom.filter(ee.Filter.gte('random', split));

// Train a classifier.
var classifier = ee.Classifier.smileRandomForest(1000, 2, 5, 0.5, 50, 11).train({
  features: trainingPartition,  
  classProperty: 'class', 
  inputProperties: bands
});
print(classifier, 'classifier');

// // Classify the image.
var classified = Image1.classify(classifier);

Map.addLayer(classified, {min: 0, max: 5, palette: ['6088BB', 'FFB03B', 'AA3A3A', 'F32424', '9EB23B', '3EC70B']}); 

//////////////////////////////////////////// Focal Filtering /////////////////////////////////////////////

var image4 = classified.focal_mode();
Map.addLayer(image4, {min: 0, max: 5, palette: ['6088BB', 'FFB03B', 'AA3A3A', 'F32424', '9EB23B', '3EC70B']})

//----------------------------Area Calculation--------------------------------------
//Select the class from the classified image
/*var tea = classified.select('classification').eq(0);//vegetation has 0 value in my case
//Calculate the pixel area in square kilometer
var area_tea = tea.multiply(ee.Image.pixelArea()).divide(1000000);
//Reducing the statistics for your study area
var stat = area_tea.reduceRegion ({
  reducer: ee.Reducer.sum(),
  geometry: table,
  scale: 30,
  maxPixels: 1e9
});
//Get the sq km area for Tea Plantation
print ('Tea Plantation Area (in sq.km)', stat);*/

//************************************************************************** 
// Accuracy Assessment
//************************************************************************** 

var test = testingPartition.classify(classifier);

// Print the confusion matrix.
var confusionMatrix = test.errorMatrix(classProperty, 'classification');
print('Confusion Matrix', confusionMatrix);
print('Overall Accuracy:', confusionMatrix.accuracy());
print('Producers Accuracy:', confusionMatrix.producersAccuracy());
print('Consumers Accuracy:', confusionMatrix.consumersAccuracy());
print('Kappa statistic:', confusionMatrix.kappa());

////////////////////////////////////////////// Export To Drive ////////////////////////////////////////////
Export.image.toDrive({
   image: image,
   description: 'Dibrugarh_2022_S2',
   scale: 10,
   region: table,
   maxPixels: 1e13,
});


//////////////////////// Feature Importance or Decrease in Accuracy //////////////////////////////////////

var importance = ee.Dictionary(classifier.explain().get('importance'))

var sum = importance.values().reduce(ee.Reducer.sum())

var relativeImportance = importance.map(function(key, val) {
   return (ee.Number(val).multiply(100)).divide(sum)
  })
print(relativeImportance, 'Relative Importance');

var importanceFc = ee.FeatureCollection([
  ee.Feature(null, relativeImportance)
])

var chart2 = ui.Chart.feature.byProperty({
  features: importanceFc
}).setOptions({
      title: 'RF Variable Importance - Method 2',
      vAxis: {title: 'Importance'},
      hAxis: {title: 'Bands'}
  })
print(chart2, 'Relative Importance')
