express = require('express')
router = express.Router(mergeParams: true)
db = require('../database')
Errors = require('../errors')

router
.get '/', (req, res)->
  News = db.models.news
  User = db.models.user
  News.findAll(
    include : [
      model : User
      as : 'creator'
    ]
  )
  .then (news_list)->
    news_list = (news.get(plain:true) for news in news_list)
    res.json(news_list)
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

.get '/:news_id', (req, res)->
  News = db.models.news
  User = db.models.user
  News.find(
    where:
      id : req.params.news_id
    include : [
      model : User
      as : 'creator'
    ]
  )
  .then (news)->
    throw new Errors.InvalidAccess("Cannot find this piece of news.") if not news
    res.json(news.get(plain:true))
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
  News = db.models.news
  User = db.models.user
  User.find req?.session?.user?.id
  .then (user)->
    throw new Errors.InvalidAccess() if not user
    News.create(
      title : req.body.title
      content : req.body.content
      creator_id : user.id
    )
  .then (news)->
    console.log news.get(plain:true)
    res.json(news.get(plain:true))
  .catch (err)->
    console.log err
    res.status(err.status || 400)
    res.json(err)

.post '/:news_id', (req, res)->
  News = db.models.news
  News.find(req.params.news_id)
  .then (news)->
    throw new Errors.InvalidAccess("Cannot find this piece of news.") if not news
    news.title = req.body.title
    news.content = req.body.content
    news.save()
  .then (news)->
    res.json(news.get(plain:true))
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

module.exports = router