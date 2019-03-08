var utils = {};

utils.kmToRadius2 = function (km, h3Resolution) {
  return Math.floor(km / h3.edgeLength(h3Resolution, h3.UNITS.km));
};

var bufferPointsLinear = function(data, radius) {
  const h3Resolution = 8;
  const layer = {};
  data.forEach(function(item) {
    const lat = item[0];
    const lng = item[1];
    const stationIndex = h3.geoToH3(lat, lng, h3Resolution);
    // add surrounding multiple surrounding rings, with less weight in each
    const rings = h3.kRingDistances(stationIndex, radius);
    const step = 1 / (radius + 1);

    rings.forEach(function(ring, distance) {
      ring.forEach(function(h3Index) {
        layer[h3Index] = (layer[h3Index] || 0) + 1 - distance * step;
      });
    });
  });

  // return layer;
  return normalizeLayer(layer);
};

function normalizeLayer(layer) {
  const zeroBaseline = false;
  const hexagons = Object.keys(layer);
  // Pass one, get max (and min if needed)
  const max = hexagons.reduce(function(max, hex) {
    return Math.max(max, layer[hex]);
  }, -Infinity);
  const min = zeroBaseline ? 0 :
        hexagons.reduce(function(min, hex) {
          return Math.min(min, layer[hex]);
        }, Infinity);
  // Pass two, normalize
  hexagons.forEach(function(hex) {
    layer[hex] = (layer[hex] - min) / (max - min);
  });

  return layer;
  // return Object.keys(layer).map(function(key) {
  //  return [key, Number(layer[key])];
  // });
}
