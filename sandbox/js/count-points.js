function countPoints(data, res) {
  const layer = {};
  data.forEach(function(item) {
    const lat = item[0];
    const lng = item[1];
    const h3Index = h3.geoToH3(lat, lng, res);
    layer[h3Index] = (layer[h3Index] || 0) + 1;
  });
  return layer;
  // return normalizeLayer(layer, true);
}
