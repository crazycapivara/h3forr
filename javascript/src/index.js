require("@babel/polyfill");
global.document = { }; // Fix, because 'document' needs to be defined
global.h3 = require("h3-js");
global.vectorize = require("./vectorize.js");
global.vectorize2 = require("./vectorize2.js");
global.utils = require("./utils.js");
global.sayHello = function() {
   console.log("hello");
};
