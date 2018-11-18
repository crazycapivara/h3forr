module.exports = function(func_name, x) {
  if (!Array.isArray(x)) {
    return h3[func_name](x);
  }

  return x.map(function(values) {
    values = Array.isArray(values) ? values : [values];
    return h3[func_name].apply(null, values);
  });
};
