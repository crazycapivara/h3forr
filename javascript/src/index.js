require("@babel/polyfill");
global.h3 = require("h3-js");
global.sayHello = function() {
   console.log("hello");
};

