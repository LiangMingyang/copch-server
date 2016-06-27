// Generated by CoffeeScript 1.10.0
(function() {
  var Errors, db, express, passwordHash, router;

  express = require('express');

  router = express.Router({
    mergeParams: true
  });

  db = require('../database');

  passwordHash = require('password-hash');

  Errors = require('../errors');

  router.post('/login', function(req, res) {
    var User, form;
    form = {
      username: req.body.username,
      password: req.body.password
    };
    User = db.models.user;
    return User.find({
      where: {
        username: form.username
      }
    }).then(function(user) {
      if (!user) {
        throw new Errors.LoginError("Wrong username.");
      }
      if (!passwordHash.verify(form.password, user.password)) {
        throw new Errors.LoginError("Wrong password.");
      }
      req.session.user = {
        id: user.id,
        nickname: user.nickname,
        username: user.username
      };
      user.last_login = new Date();
      return user.save();
    }).then(function(user) {
      return res.json(user.get({
        plain: true
      }));
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  }).get('/logout', function(req, res) {
    delete req.session.user;
    return res.json({
      message: "success"
    });
  }).get('/', function(req, res) {
    return res.json(req.session.user);
  });

  module.exports = router;

}).call(this);

//# sourceMappingURL=users.js.map
