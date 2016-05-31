express = require('express')
router = express.Router(mergeParams: true)
db = require('../database')
passwordHash = require('password-hash')
Errors = require('../errors')

router
.post '/login', (req, res)->
  form = {
    username: req.body.username
    password: req.body.password
  }

  #precheckForLogin(form)
  User = db.models.user

  User.find {
    where:
      username: form.username
  }
  .then (user)->
#过滤
    throw new Errors.LoginError("Wrong username.") if not user #没有找到该用户
    throw new Errors.LoginError("Wrong password.") if not passwordHash.verify(form.password, user.password) #判断密码是否正确
    req.session.user = {
      id: user.id
      nickname: user.nickname
      username: user.username
    }
    user.last_login = new Date()
    user.save()
  .then (user)->
    res.json(user.get(plain:true))
  .catch (err)->
    res.status(err.status || 400)
    res.json(err)

.get '/logout', (req, res)->
  delete req.session.user
  res.json(message: "success")


module.exports = router