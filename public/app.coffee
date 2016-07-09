
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
.controller('main', ($scope, $timeout, DBMS, $location, $route)->


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

  DBMS.user.refresh()
  $scope.user = DBMS.user

  $scope.delete = (news)->
    c = confirm("确定要删除这条新闻吗？")
    return if not c
    DBMS.news.delete(news)
    .then ->
      $location.path('/news').replace()
    .catch (err)->
      alert(err.data.message)
      console.log err
)
.controller 'login', ($scope, $http, $location, DBMS)->
  $scope.form = {
    username: ""
    password: ""
  }
  $scope.login = ()->
    $http.post("/users/login", $scope.form)
    .then (res)->
      console.log res.data
      DBMS.user.refresh()
      alert("Login successfully.")
      $location.path('/').replace()
    .catch (res)->
      err = res.data
      alert(err.message)

.controller 'publish', ($scope, $location, DBMS)->
  $scope.form = {
    title : ""
    content : ""
  }

  $scope.publish = ()->
    DBMS.news.push($scope.form)
    .then (news)->
      $scope.form.title = ""
      $scope.form.content = ""
      $location.path("/news/#{news.id}").replace()
    .catch (err)->
      alert(err.data.message)
      console.log err

.controller 'update', ($scope, $location, DBMS, $route)->
  news_id = $route.current.params.news_id
  $scope.form = {
    id : news_id
    title : DBMS.news.dic[news_id].title
    content : DBMS.news.dic[news_id].content
  }

  $scope.publish = ()->
    DBMS.news.update($scope.form)
    .then (news)->
      $scope.form.title = ""
      $scope.form.content = ""
      $location.path("/news/#{news.id}").replace()
    .catch (err)->
      alert(err.data.message)
      console.log err