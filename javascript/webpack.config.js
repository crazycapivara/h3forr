const path = require('path');

module.exports = {
  mode: 'production',
  entry: './src/index.js',
  output: {
    filename: 'h3-bundle.js',
    path: path.resolve(__dirname, '../inst/js')
  },
  node: {
    fs: 'empty'
  }
};
