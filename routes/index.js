var express = require('express');
var router = express.Router();
var news = require('./news');
var users = require('./users');

/* GET home page. */
router.use('/news', news);
router.use('/users', users);

module.exports = router;
