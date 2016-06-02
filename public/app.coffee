HOST = "http://127.0.0.1:3000"

angular.module('west', [
  'ui.bootstrap',
  'west-router',
  'west-dbms'
])

.directive 'ckEditor', ->
  {
    require: '?ngModel'
    link: (scope, elm, attr, ngModel) ->
      ck = CKEDITOR.replace(elm[0])
      return if not ngModel
      ck.on 'pasteState', ->
        scope.$apply ->
          ngModel.$setViewValue ck.getData()

      ngModel.$render = (value) ->
        ck.setData ngModel.$viewValue

  }

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

.controller 'publish', ($scope, DBMS)->
  $scope.form = DBMS.publish_news

  $scope.publish = ()->
    DBMS.publish_news.create()
    .then ->
      DBMS.publish_news.title = ""
      DBMS.publish_news.content = ""
    .catch (err)->
      alert(err.data.message)
      console.log err

.controller 'update', ($scope, DBMS, $route)->
  news_id = $route.current.params.news_id
  DBMS.publish_news.title = DBMS.news.dic[news_id].title
  DBMS.publish_news.content = DBMS.news.dic[news_id].content
  $scope.form = DBMS.publish_news

  $scope.publish = ()->
    DBMS.publish_news.update(news_id)
    .then ->
      DBMS.publish_news.title = ""
      DBMS.publish_news.content = ""
    .catch (err)->
      alert(err.data.message)
      console.log err