module.exports = {
  database:
    type: 'mysql'
    name: 'copch'
    username: 'root'
    password: 'soar159357'
    setting:
      host: 'localhost'
      dialect: 'mysql'
      port: 3306
      timezone: '+08:00'  
      pool:
        max: 500
        min: 0
        idle: 10000
      logging: null
  redis:
    secret: 'copch'
    resave: false
    saveUninitialized: true
    cookie: {maxAge: 1000 * 60 * 60 * 24} #null to create a browser-session
}