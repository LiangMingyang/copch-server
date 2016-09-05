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
    controller: 'news'
  )
  .when('/news/:news_id',
    templateUrl: 'tpls/news-detail.tpl.html'
  )
  .when('/expert',
    templateUrl: 'tpls/expert.tpl.html'
  )
  .when('/policy',
    templateUrl: 'tpls/policy.tpl.html'
    controller: 'policy'
  )
  .when('/policy/:policy_id',
    templateUrl: 'tpls/policy-detail.tpl.html'
  )
  .when('/contact',
    templateUrl: 'tpls/contact.tpl.html'
  )
  .when('/login',
    templateUrl: 'tpls/login.tpl.html'
    controller: 'user'
  )
  .when('/publish',
    templateUrl: 'tpls/publisher.tpl.html'
    controller : 'news'
  )
  .when('/adopt',
    templateUrl: 'tpls/publisher.tpl.html'
    controller : 'policy'
  )
  .when('/update/:news_id',
    templateUrl: 'tpls/editor.tpl.html'
    controller : 'news'
  )
  .when('/edit/:policy_id',
    templateUrl: 'tpls/editor.tpl.html'
    controller : 'policy'
  )
  .when('/edit-richtext/:key',
    templateUrl: 'tpls/edit-richtext.tpl.html'
    controller : 'edit-richtext'
  )
  .otherwise(
    redirectTo: '/index'
  )
)