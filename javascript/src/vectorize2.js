module.exports = function(funcName, x, params) {
  return x.map(function(data) {
    return h3[funcName].apply(null, [data].concat(params));
  });
};
