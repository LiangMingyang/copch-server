
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

  DBMS.richtext.refresh()

  DBMS.policies.refresh()

  $scope.news_list = DBMS.news.data

  $scope.news_dic = DBMS.news.dic

  $scope.about = DBMS.richtext.about

  $scope.notify = DBMS.richtext.notify

  $scope.contact = DBMS.richtext.contact

  $scope.expert = DBMS.richtext.expert

  $scope.policy_list = DBMS.policies.data

  $scope.policy_dic = DBMS.policies.dic

  DBMS.user.refresh()
  $scope.user = DBMS.user

)
.controller 'user', ($scope, $http, $location, DBMS)->
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

  $scope.logout = ()->
    $http.get("/users/logout")
    .then (res)->
      console.log res.data
      DBMS.user.refresh()
      alert("Logout successfully.")
      $location.path('/').replace()
    .catch (res)->
      err = res.data
      alert(err.message)
      
.controller 'news', ($scope, $location, $route, DBMS)->
  $scope.form = {
    title : ""
    content : ""
  }

  $scope.create = ()->

    DBMS.news.push($scope.form)
    .then (news)->
      $scope.form.title = ""
      $scope.form.content = ""
      $location.path("/news/#{news.id}").replace()
    .catch (err)->
      alert(err.data.message)
      console.log err

  $scope.delete = (news)->
    c = confirm("确定要删除这条新闻吗？")
    return if not c
    DBMS.news.delete(news)
    .then ->
      $location.path('/news').replace()
    .catch (err)->
      alert(err.data.message)
      console.log err

  news_id = $route.current.params.news_id
  if news_id
    $scope.form = {
      id : news_id
      title : DBMS.news.dic[news_id].title
      content : DBMS.news.dic[news_id].content
    }

  $scope.update = ()->
    DBMS.news.update($scope.form)
    .then (news)->
      $scope.form.title = ""
      $scope.form.content = ""
      $location.path("/news/#{news.id}").replace()
    .catch (err)->
      alert(err.data.message)
      console.log err

.controller 'policy', ($scope, $location, $route, DBMS)->
  $scope.form = {
    title : ""
    content : ""
  }

  $scope.create = ()->
    DBMS.policies.push($scope.form)
    .then (policy)->
      $scope.form.title = ""
      $scope.form.content = ""
      $location.path("/policy/#{policy.id}").replace()
    .catch (err)->
      alert(err.data.message)
      console.log err

  policy_id = $route.current.params.policy_id
  if policy_id
    $scope.form = {
      id : policy_id
      title : DBMS.policies.dic[policy_id].title
      content : DBMS.policies.dic[policy_id].content
    }

  $scope.update = ()->
    DBMS.policies.update($scope.form)
    .then (policy)->
      $scope.form.title = ""
      $scope.form.content = ""
      console.log policy.id
      $location.path("/policy/#{policy.id}").replace()
    .catch (err)->
      alert(err.data.message)
      console.log err

  $scope.delete = (policy)->
    c = confirm("确定要删除这条政策吗？")
    return if not c
    DBMS.policies.delete(policy)
    .then ->
      $location.path('/policy').replace()
    .catch (err)->
      alert(err.data.message)
      console.log err


.controller 'edit-richtext', ($scope, $location, DBMS, $route)->
  $scope.richtext = {}
  $scope.richtext.name = $route.current.params.key
#  console.log $scope.richtext.name
  $scope.richtext.content = DBMS.richtext[$scope.richtext.name].content

  $scope.update = ()->
    console.log $scope.richtext
    DBMS.richtext.update($scope.richtext)
    .then ->
      alert("Updated successfully.")
      $location.path("/index").replace()
    .catch (err)->
      alert(err.data.message)
      console.log err