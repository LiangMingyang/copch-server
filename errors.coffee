class LoginError extends Error
  constructor: (@message = "用户名或密码错误") ->
    @name = 'LoginError'
    @status = 401
    Error.captureStackTrace(this, LoginError)

class InvalidAccess extends Error
  constructor: (@message = "做不到") ->
    @name = 'InvalidAccess'
    @status = 403
    Error.captureStackTrace(this, InvalidAccess)

module.exports = {
  LoginError  : LoginError
  InvalidAccess : InvalidAccess
}