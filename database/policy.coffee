module.exports = (sequelize, DataTypes) ->
  sequelize.define 'policy', {
    title:
      type: DataTypes.TEXT('long')
      allowNull: false
      validate:
        notEmpty: true
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