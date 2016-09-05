express = require('express')
router = express.Router(mergeParams: true)
db = require('../database')
Errors = require('../errors')

router
.get '/', (req, res)->
  Policy = db.models.policy
  User = db.models.user
  Policy.findAll(
    where:
      access_level: 'public'
    include : [
      model : User
      as : 'creator'
    ]
  )
  .then (policies_list)->
    policies_list = (policies.get(plain:true) for policies in policies_list)
    res.json(policies_list)
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

.get '/:policies_id', (req, res)->
  Policy = db.models.policy
  User = db.models.user
  Policy.find(
    where:
      id : req.params.policies_id
      access_level: 'public'
    include : [
      model : User
      as : 'creator'
    ]
  )
  .then (policies)->
    throw new Errors.InvalidAccess("Cannot find this piece of policies.") if not policies
    res.json(policies.get(plain:true))
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

#.use [
#  (req, res, next)->
#    if req?.session?.user?.id is undefined
#      err = new Errors.InvalidAccess()
#      console.log err
#      res.status(err.status || 400)
#      res.json(err)
#    else
#      next(req, res)
#]
.post '/', (req, res)->
  Policy = db.models.policy
  User = db.models.user
  db.Promise.resolve()
  .then ->
    return if not req?.session?.user?.id
    User.findById req.session.user.id
  .then (user)->
    throw new Errors.InvalidAccess() if not user
    Policy.create(
      title : req.body.title
      content : req.body.content
      creator_id : user.id
    )
  .then (policies)->
    res.json(policies.get(plain:true))
  .catch (err)->
    console.log err
    res.status(err.status || 400)
    res.json(err)

.post '/:policies_id', (req, res)->
  Policy = db.models.policy
  User = db.models.user
  db.Promise.resolve()
  .then ->
    return if not req?.session?.user?.id
    User.findById req.session.user.id
  .then (user)->
    throw new Errors.InvalidAccess() if not user
    Policy.findById(req.params.policies_id)
  .then (policies)->
    throw new Errors.InvalidAccess("Cannot find this piece of policies.") if not policies
    policies.title = req.body.title
    policies.content = req.body.content
    policies.save()
  .then (policies)->
    res.json(policies.get(plain:true))
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

.delete '/:policies_id', (req, res)->
  Policy = db.models.policy
  User = db.models.user
  db.Promise.resolve()
  .then ->
    return if not req?.session?.user?.id
    User.findById req.session.user.id
  .then (user)->
    throw new Errors.InvalidAccess() if not user
    Policy.findById(req.params.policies_id)
  .then (policies)->
    throw new Errors.InvalidAccess("Cannot find this piece of policies.") if not policies
    policies.access_level = "private"
    policies.save()
  .then (policies)->
    res.json(policies.get(plain:true))
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

module.exports = router