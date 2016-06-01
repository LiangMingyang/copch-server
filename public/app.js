// Generated by CoffeeScript 1.10.0
(function() {
  var HOST;

  HOST = "http://127.0.0.1:3000";

  angular.module('west', ['ui.bootstrap', 'west-router', 'west-dbms']).filter('richtext', [
    '$sce', function($sce) {
      return function(html) {
        return $sce.trustAsHtml(html);
      };
    }
  ]).controller('main', function($scope, $timeout, DBMS, $route) {
    var update;
    $scope.router = $route;
    $scope.now = new Date();
    update = function() {
      $scope.now = new Date();
      return $timeout(update, 1000);
    };
    update();
    $scope.slides = DBMS.slides;
    DBMS.news.refresh();
    $scope.news_list = DBMS.news.data;
    $scope.news_dic = DBMS.news.dic;
    $scope.about = DBMS.about;
    $scope.notify = DBMS.notify;
    $scope.contact = DBMS.contact;
    return $scope.policy_list = DBMS.policy_list;
  }).controller('login', function($scope, $http, $location) {
    $scope.form = {
      username: "",
      password: ""
    };
    return $scope.login = function() {
      return $http.post(HOST + "/users/login", $scope.form).then(function(res) {
        console.log(res.data);
        alert("Login successfully.");
        return $location.path('/').replace();
      })["catch"](function(res) {
        var err;
        err = res.data;
        return alert(err.message);
      });
    };
  }).controller('publish', function($scope, $http) {
    $scope.form = {
      title: "",
      content: ""
    };
    return $scope.publish = function() {
      $scope.form.content = CKEDITOR.instances.content.getData();
      return $http.post(HOST + "/news", $scope.form).then(function(res) {
        console.log(res.data);
        return alert("Publish successfully.");
      })["catch"](function(res) {
        var err;
        err = res.data;
        return alert(err.message);
      });
    };
  });

}).call(this);

//# sourceMappingURL=app.js.map
