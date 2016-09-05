// Generated by CoffeeScript 1.10.0
(function() {
  module.exports = function(sequelize, DataTypes) {
    return sequelize.define('policy', {
      title: {
        type: DataTypes.TEXT('long'),
        allowNull: false,
        validate: {
          notEmpty: true
        }
      },
      content: {
        type: DataTypes.TEXT('long')
      },
      access_level: {
        type: DataTypes.ENUM('private', 'protect', 'public'),
        defaultValue: 'public'
      }
    }, {
      underscored: true
    });
  };

}).call(this);

//# sourceMappingURL=policy.js.map