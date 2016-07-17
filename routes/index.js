var express = require('express');
var router = express.Router();
var news = require('./news');
var users = require('./users');
var richtext = require('./richtext');

/* GET home page. */
router.use('/news', news);
router.use('/users', users);
router.use('/richtext', richtext);

module.exports = router;
