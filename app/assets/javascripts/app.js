var templicious = angular.module('templicious', [
    'templates', 'ngRoute', 'ngResource', 'controllers', 'angular-flash.service',
    'angular-flash.flash-alert-directive'
]);

templicious.config([
'$routeProvider', 'flashProvider', function ($routeProvider, flashProvider) {
    flashProvider.errorClassnames.push("alert-danger");
    flashProvider.warnClassnames.push("alert-warning");
    flashProvider.infoClassnames.push("alert-info");
    flashProvider.successClassnames.push("alert-success");
    return $routeProvider.when('/', {
        templateUrl: "recipe/index.html",
        controller: 'RecipesController'
    }).when('/recipe/new', {
        templateUrl: "recipe/form.html",
        controller: 'RecipeController'
    }).when('/recipe/:id', {
        templateUrl: "recipe/show.html",
        controller: 'RecipeController'
    }).when('/recipe/:id/edit', {
        templateUrl: "recipe/form.html",
        controller: 'RecipeController'
    }).when('/zip/:id', {
        templateUrl: "zip/show.html",
        controller: 'ZipController'
    });
}
]);

var controllers = angular.module('controllers', []);
