module.exports = (sequelize, DataTypes) ->
  sequelize.define 'richtext', {
    name:
      type: DataTypes.STRING
      unique: true
      allowNull: false
    content:
      type: DataTypes.TEXT('long')
    access_level:
      type: DataTypes.ENUM('private', 'protect', 'public')
      defaultValue: 'public'
#creator foreign key
#group   foreign key
  }, {
    underscored: true
  }