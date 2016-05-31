// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';
  var host;

  host = "127.0.0.1:3000";

  this.angular.module('copch-admin', []).controller('copch-admin.publish', function($scope, $http) {
    $scope.form = {};
    $scope.form.title = "";
    $scope.form.content = "";
    return $scope.publish = function() {
      if ($scope.form.title === "") {
        return alert("标题不能为空");
      }
      $scope.form.content = CKEDITOR.instances.content.getData();
      return $http.post("http://" + host + "/news", $scope.form).then(function(res) {
        console.log(res);
        return alert("Success.");
      })["catch"](function(err) {
        console.log(err);
        return alert(err.data.message);
      });
    };
  });

}).call(this);

//# sourceMappingURL=app.js.map
