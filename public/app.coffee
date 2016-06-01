HOST = "http://127.0.0.1:3000"

angular.module('west', [
  'ui.bootstrap',
  'west-router',
  'west-dbms'
])

.filter('richtext', ['$sce', ($sce)->
  (html)->
    $sce.trustAsHtml(html)
])
.controller('main', ($scope, $timeout, DBMS, $route)->


  $scope.router = $route

  $scope.now = new Date()
  update = ()->
    $scope.now = new Date()
    $timeout(update, 1000)
  update()

  $scope.slides = DBMS.slides

  DBMS.news.refresh()

  $scope.news_list = DBMS.news.data

  $scope.news_dic = DBMS.news.dic

  $scope.about = DBMS.about

  $scope.notify = DBMS.notify

  $scope.contact = DBMS.contact

  $scope.policy_list = DBMS.policy_list
)
.controller 'login', ($scope, $http, $location)->
  $scope.form = {
    username: ""
    password: ""
  }
  $scope.login = ()->
    $http.post("#{HOST}/users/login", $scope.form)
    .then (res)->
      console.log res.data
      alert("Login successfully.")
      $location.path('/').replace()
    .catch (res)->
      err = res.data
      alert(err.message)

.controller 'publish', ($scope, $http)->
  $scope.form = {
    title: ""
    content: ""
  }

  $scope.publish = ()->
    $scope.form.content = CKEDITOR.instances.content.getData()
    $http.post("#{HOST}/news", $scope.form)
    .then (res)->
      console.log res.data
      alert("Publish successfully.")
    .catch (res)->
      err = res.data
      alert(err.message)