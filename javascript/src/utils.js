var utils = {};

utils.bufferPointsLinear = function(data, radius, res) {
  const h3Resolution = res || 8;
  const layer = {};
  data.forEach(function(item) {
    const lat = item[0];
    const lng = item[1];
    const baseIndex = h3.geoToH3(lat, lng, h3Resolution);
    // add multiple surrounding rings with less weight in each
    const rings = h3.kRingDistances(baseIndex, radius);
    const step = 1 / (radius + 1);
    rings.forEach(function(ring, distance) {
      ring.forEach(function(h3Index) {
        layer[h3Index] = (layer[h3Index] || 0) + 1 - distance * step;
      });
    });
  });

  // return layer;
  return parseLayer(layer);
};

var parseLayer = function(layer) {
  return Object.keys(layer).map(function(key) {
    return { h3_index: key, weight: layer[key] };
  });
};

module.exports = utils;
