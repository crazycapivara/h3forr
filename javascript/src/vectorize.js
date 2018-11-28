var callThis = function(funcName, data, params) {
  return h3[funcName].apply(null, data.concat(params));
};

module.exports = function(funcName, x, params) {
  params = params || [];
  if (!Array.isArray(x)) {
    return callThis(funcName, [x], params);
  }

  return x.map(function(data) {
    data = Array.isArray(data) ? data : [data];
    return callThis(funcName, data, params);
  });
};
