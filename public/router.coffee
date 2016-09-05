angular.module('west-router', [
  'ngRoute',
])
.config( ($routeProvider)->
  $routeProvider
  .when('/index',
    templateUrl: 'tpls/index.tpl.html',
  )
  .when('/about',
    templateUrl: 'tpls/about.tpl.html',
  )
  .when('/news',
    templateUrl: 'tpls/news.tpl.html'
    controller: 'publish'
  )
  .when('/news/:news_id',
    templateUrl: 'tpls/news-detail.tpl.html'
  )
  .when('/expert',
    templateUrl: 'tpls/expert.tpl.html'
  )
  .when('/policy',
    templateUrl: 'tpls/policy.tpl.html'
    controller: 'adopt'
  )
  .when('/policy/:policy_id',
    templateUrl: 'tpls/policy-detail.tpl.html'
  )
  .when('/contact',
    templateUrl: 'tpls/contact.tpl.html'
  )
  .when('/login',
    templateUrl: 'tpls/login.tpl.html'
    controller: 'login'
  )
  .when('/publish',
    templateUrl: 'tpls/editor.tpl.html'
    controller : 'publish'
  )
  .when('/adopt',
    templateUrl: 'tpls/adopt.tpl.html'
    controller : 'adopt'
  )
  .when('/update/:news_id',
    templateUrl: 'tpls/editor.tpl.html'
    controller : 'update'
  )
  .when('/edit/:policy_id',
    templateUrl: 'tpls/adopt.tpl.html'
    controller : 'edit'
  )
  .when('/edit-richtext/:key',
    templateUrl: 'tpls/edit-richtext.tpl.html'
    controller : 'edit-richtext'
  )
  .otherwise(
    redirectTo: '/index'
  )
)