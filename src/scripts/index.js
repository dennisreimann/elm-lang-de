'use strict';

require('../styles/main.styl');
require('../styles/header.styl');

var Elm = require('../elm/Main');
var node = document.getElementById('app');
var app = Elm.Main.embed(node);