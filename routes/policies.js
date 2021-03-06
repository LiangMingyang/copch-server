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
    var Policy, User;
    Policy = db.models.policy;
    User = db.models.user;
    return Policy.findAll({
      where: {
        access_level: 'public'
      },
      include: [
        {
          model: User,
          as: 'creator'
        }
      ]
    }).then(function(policies_list) {
      var policies;
      policies_list = (function() {
        var i, len, results;
        results = [];
        for (i = 0, len = policies_list.length; i < len; i++) {
          policies = policies_list[i];
          results.push(policies.get({
            plain: true
          }));
        }
        return results;
      })();
      return res.json(policies_list);
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  }).get('/:policies_id', function(req, res) {
    var Policy, User;
    Policy = db.models.policy;
    User = db.models.user;
    return Policy.find({
      where: {
        id: req.params.policies_id,
        access_level: 'public'
      },
      include: [
        {
          model: User,
          as: 'creator'
        }
      ]
    }).then(function(policies) {
      if (!policies) {
        throw new Errors.InvalidAccess("Cannot find this piece of policies.");
      }
      return res.json(policies.get({
        plain: true
      }));
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  }).post('/', function(req, res) {
    var Policy, User;
    Policy = db.models.policy;
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
      return Policy.create({
        title: req.body.title,
        content: req.body.content,
        creator_id: user.id
      });
    }).then(function(policies) {
      return res.json(policies.get({
        plain: true
      }));
    })["catch"](function(err) {
      console.log(err);
      res.status(err.status || 400);
      return res.json(err);
    });
  }).post('/:policies_id', function(req, res) {
    var Policy, User;
    Policy = db.models.policy;
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
      return Policy.findById(req.params.policies_id);
    }).then(function(policies) {
      if (!policies) {
        throw new Errors.InvalidAccess("Cannot find this piece of policies.");
      }
      policies.title = req.body.title;
      policies.content = req.body.content;
      return policies.save();
    }).then(function(policies) {
      return res.json(policies.get({
        plain: true
      }));
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  })["delete"]('/:policies_id', function(req, res) {
    var Policy, User;
    Policy = db.models.policy;
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
      return Policy.findById(req.params.policies_id);
    }).then(function(policies) {
      if (!policies) {
        throw new Errors.InvalidAccess("Cannot find this piece of policies.");
      }
      policies.access_level = "private";
      return policies.save();
    }).then(function(policies) {
      return res.json(policies.get({
        plain: true
      }));
    })["catch"](function(err) {
      res.status(err.status || 400);
      return res.json(err);
    });
  });

  module.exports = router;

}).call(this);

//# sourceMappingURL=policies.js.map
