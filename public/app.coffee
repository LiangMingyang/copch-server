'use strict';

host = "127.0.0.1:3000"

@angular.module('copch-admin',[])

.controller 'copch-admin.publish', ($scope, $http)->
  $scope.form = {}
  $scope.form.title = ""
  $scope.form.content = ""

  $scope.publish = ()->
    return alert "标题不能为空" if $scope.form.title is ""
    $scope.form.content = CKEDITOR.instances.content.getData()
    $http.post("http://#{host}/news", $scope.form)
    .then (res)->
      console.log res
      alert("Success.")
    .catch (err)->
      console.log err
      alert(err.message)
    #CKEDITOR.instances.content.setData("<p>Yes, you did it!</p>")
    #console.log CKEDITOR.instances.content

