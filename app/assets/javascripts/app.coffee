templicious = angular.module('templicious',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

templicious.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'RecipesController'
      )
      .when('/recipe/new',
        templateUrl: "form.html"
        controller:  'RecipeController'
      )
      .when('/recipe/:id',
        templateUrl: "show.html"
        controller: 'RecipeController'
      )
      .when('/recipe/:id/edit',
        templateUrl: "form.html"
        controller: 'RecipeController'
      )
      .when('/zip/:id',
        templateUrl: "zip/show.html"
        controller: 'ZipController'
      )
])

controllers = angular.module('controllers',[])
