Sequelize = require('sequelize')
path = require('path')
config = require('../config')

sequelize = new Sequelize(config.database.name, config.database.username, config.database.password, config.database.setting)

News = sequelize.import path.join(__dirname, 'news')
User = sequelize.import path.join(__dirname, 'user')

News.belongsTo(User, as: 'creator')

module.exports = sequelize