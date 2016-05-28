'use strict';

@angular.module('copch-admin',[])

.controller 'copch-admin.publish', ($scope, $http)->
  $scope.form = {}
  $scope.form.title = ""
  $scope.form.content = ""

  $scope.publish = ()->
    return alert "标题不能为空" if $scope.form.title is ""
    alert $scope.form.title
    alert CKEDITOR.instances.content.getData()
    CKEDITOR.instances.content.setData("<p>Yes, you did it!</p>")
    #console.log CKEDITOR.instances.content

