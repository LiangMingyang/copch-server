var express = require('express');
var router = express.Router();
var news = require('./news');

/* GET home page. */
router.use('/news', news);

module.exports = router;
