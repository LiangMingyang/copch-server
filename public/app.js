// Generated by CoffeeScript 1.10.0
(function() {
  angular.module('west', ['ui.bootstrap', 'west-router', 'west-dbms']).directive('ckEditor', function() {
    return {
      require: '?ngModel',
      link: function(scope, elm, attr, ngModel) {
        var ck;
        ck = CKEDITOR.replace(elm[0]);
        if (!ngModel) {
          return;
        }
        ck.on('pasteState', function() {
          return scope.$apply(function() {
            return ngModel.$setViewValue(ck.getData());
          });
        });
        return ngModel.$render = function(value) {
          return ck.setData(ngModel.$viewValue);
        };
      }
    };
  }).filter('richtext', [
    '$sce', function($sce) {
      return function(html) {
        return $sce.trustAsHtml(html);
      };
    }
  ]).controller('main', function($scope, $timeout, DBMS, $location, $route) {
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
    DBMS.richtext.refresh();
    $scope.news_list = DBMS.news.data;
    $scope.news_dic = DBMS.news.dic;
    $scope.about = DBMS.richtext.about;
    $scope.notify = DBMS.notify;
    $scope.contact = DBMS.contact;
    $scope.policy_list = DBMS.policy_list;
    DBMS.user.refresh();
    $scope.user = DBMS.user;
    return $scope["delete"] = function(news) {
      var c;
      c = confirm("确定要删除这条新闻吗？");
      if (!c) {
        return;
      }
      return DBMS.news["delete"](news).then(function() {
        return $location.path('/news').replace();
      })["catch"](function(err) {
        alert(err.data.message);
        return console.log(err);
      });
    };
  }).controller('login', function($scope, $http, $location, DBMS) {
    $scope.form = {
      username: "",
      password: ""
    };
    return $scope.login = function() {
      return $http.post("/users/login", $scope.form).then(function(res) {
        console.log(res.data);
        DBMS.user.refresh();
        alert("Login successfully.");
        return $location.path('/').replace();
      })["catch"](function(res) {
        var err;
        err = res.data;
        return alert(err.message);
      });
    };
  }).controller('publish', function($scope, $location, DBMS) {
    $scope.form = {
      title: "",
      content: ""
    };
    return $scope.publish = function() {
      return DBMS.news.push($scope.form).then(function(news) {
        $scope.form.title = "";
        $scope.form.content = "";
        return $location.path("/news/" + news.id).replace();
      })["catch"](function(err) {
        alert(err.data.message);
        return console.log(err);
      });
    };
  }).controller('update', function($scope, $location, DBMS, $route) {
    var news_id;
    news_id = $route.current.params.news_id;
    $scope.form = {
      id: news_id,
      title: DBMS.news.dic[news_id].title,
      content: DBMS.news.dic[news_id].content
    };
    return $scope.publish = function() {
      return DBMS.news.update($scope.form).then(function(news) {
        $scope.form.title = "";
        $scope.form.content = "";
        return $location.path("/news/" + news.id).replace();
      })["catch"](function(err) {
        alert(err.data.message);
        return console.log(err);
      });
    };
  }).controller('edit-richtext', function($scope, $location, DBMS, $route) {
    $scope.richtext = {};
    $scope.richtext.name = $route.current.params.key;
    $scope.richtext.content = DBMS.richtext[$scope.richtext.name].content;
    return $scope.update = function() {
      return DBMS.richtext.update($scope.richtext).then(function() {
        alert("Updated successfully.");
        return $location.path("/index").replace();
      })["catch"](function(err) {
        alert(err.data.message);
        return console.log(err);
      });
    };
  });

}).call(this);

//# sourceMappingURL=app.js.map
