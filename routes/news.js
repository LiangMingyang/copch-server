// Generated by CoffeeScript 1.10.0
(function() {
  var Errors, db, express, router;

  express = require('express');

  router = express.Router({
    mergeParams: true
  });

  db = require('../database');

  Errors = require('../errors');

  router.get('/', function(req, res) {
    var News, User;
    News = db.models.news;
    User = db.models.user;
    return News.findAll({
      where: {
        access_level: 'public'
      },
      include: [
        {
          model: User,
          as: 'creator'
        }
      ]
    }).then(function(news_list) {
      var news;
      news_list = (function() {
        var i, len, results;
        results = [];
        for (i = 0, len = news_list.length; i < len; i++) {
          news = news_list[i];
          results.push(news.get({
            plain: true
          }));
        }
        return results;
      })();
      return res.json(news_list);
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  }).get('/:news_id', function(req, res) {
    var News, User;
    News = db.models.news;
    User = db.models.user;
    return News.find({
      where: {
        id: req.params.news_id,
        access_level: 'public'
      },
      include: [
        {
          model: User,
          as: 'creator'
        }
      ]
    }).then(function(news) {
      if (!news) {
        throw new Errors.InvalidAccess("Cannot find this piece of news.");
      }
      return res.json(news.get({
        plain: true
      }));
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  }).post('/', function(req, res) {
    var News, User;
    News = db.models.news;
    User = db.models.user;
    return db.Promise.resolve().then(function() {
      var ref, ref1;
      if (!(req != null ? (ref = req.session) != null ? (ref1 = ref.user) != null ? ref1.id : void 0 : void 0 : void 0)) {
        return;
      }
      return User.findById(req.session.user.id);
    }).then(function(user) {
      if (!user) {
        throw new Errors.InvalidAccess();
      }
      return News.create({
        title: req.body.title,
        content: req.body.content,
        creator_id: user.id
      });
    }).then(function(news) {
      return res.json(news.get({
        plain: true
      }));
    })["catch"](function(err) {
      console.log(err);
      res.status(err.status || 400);
      return res.json(err);
    });
  }).post('/:news_id', function(req, res) {
    var News, User;
    News = db.models.news;
    User = db.models.user;
    return db.Promise.resolve().then(function() {
      var ref, ref1;
      if (!(req != null ? (ref = req.session) != null ? (ref1 = ref.user) != null ? ref1.id : void 0 : void 0 : void 0)) {
        return;
      }
      return User.findById(req.session.user.id);
    }).then(function(user) {
      if (!user) {
        throw new Errors.InvalidAccess();
      }
      return News.findById(req.params.news_id);
    }).then(function(news) {
      if (!news) {
        throw new Errors.InvalidAccess("Cannot find this piece of news.");
      }
      news.title = req.body.title;
      news.content = req.body.content;
      return news.save();
    }).then(function(news) {
      return res.json(news.get({
        plain: true
      }));
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  })["delete"]('/:news_id', function(req, res) {
    var News, User;
    News = db.models.news;
    User = db.models.user;
    return db.Promise.resolve().then(function() {
      var ref, ref1;
      if (!(req != null ? (ref = req.session) != null ? (ref1 = ref.user) != null ? ref1.id : void 0 : void 0 : void 0)) {
        return;
      }
      return User.findById(req.session.user.id);
    }).then(function(user) {
      if (!user) {
        throw new Errors.InvalidAccess();
      }
      return News.findById(req.params.news_id);
    }).then(function(news) {
      if (!news) {
        throw new Errors.InvalidAccess("Cannot find this piece of news.");
      }
      news.access_level = "private";
      return news.save();
    }).then(function(news) {
      return res.json(news.get({
        plain: true
      }));
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  });

  module.exports = router;

}).call(this);

//# sourceMappingURL=news.js.map
