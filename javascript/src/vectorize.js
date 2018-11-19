var callThis = function(func_name, values, params) {
  return h3[func_name].apply(null, values.concat(params));
};

module.exports = function(func_name, x, params) {
  params = params || [];
  if (!Array.isArray(x)) {
    return callThis(func_name, [x], params);
  }

  return x.map(function(values) {
    values = Array.isArray(values) ? values : [values];
    return callThis(func_name, values, params);
  });
};
