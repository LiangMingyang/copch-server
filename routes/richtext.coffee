express = require('express')
router = express.Router(mergeParams: true)
db = require('../database')
Errors = require('../errors')

router.get '/', (req, res)->
  Richtext = db.models.richtext
  name = req.query.key
  Richtext.find(
    where:
      name : name
  )
  .then (richtext)->
    throw new Errors.InvalidAccess() if not richtext
    richtext = richtext.get(plain:true)
    res.json(richtext)
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

router.post '/', (req, res)->
  Richtext = db.models.richtext
  name = req.query.key
  User = db.models.user
  db.Promise.resolve()
  .then ->
    return if not req?.session?.user?.id
    User.findById req.session.user.id
  .then (user)->
    throw new Errors.InvalidAccess() if not user
    Richtext.find(
      where:
        name : name
    )
  .then (richtext)->
    return richtext if richtext
    Richtext.create(
      name: name
      content : req.body.content
    )
  .then (richtext)->
    richtext = richtext.get(plain:true)
    res.json(richtext)
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

module.exports = router