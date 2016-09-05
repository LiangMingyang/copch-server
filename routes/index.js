var express = require('express');
var router = express.Router();
var news = require('./news');
var users = require('./users');
var richtext = require('./richtext');
var policies = require("./policies");

/* GET home page. */
router.use('/news', news);
router.use('/users', users);
router.use('/richtext', richtext);
router.use('/policies', policies);

module.exports = router;
