var templicious = angular.module('templicious', [
    'templates', 'ngRoute', 'ngResource', 'controllers', 'angular-flash.service',
    'angular-flash.flash-alert-directive', 'ui.bootstrap'
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

templicious
.factory('ChartInitializer', function ($rootScope, $window, $q) {
    var deferred = $q.defer();

    $window.google.load('visualization', '1',
        {
            packages: ['corechart'],
            callback: function () {
                $rootScope.$apply(function () {
                    deferred.resolve();
                });
            }
        });

    //Usage: ChartInitializer.initialized.then(callback)
    return {
        initialized: deferred.promise
    };
});

templicious
.factory('MapInitializer', function ($rootScope, $window, $q) {
    //Google's url for async maps initialization accepting callback function
    var asyncUrl = 'https://maps.googleapis.com/maps/api/js?callback=',
        deferred = $q.defer();

    //Callback function - resolving promise after maps successfully loaded
    $window.googleMapsInitialized = deferred.resolve;

    //Async loader
    var asyncLoad = function (asyncUrl, callbackName) {
        var script = document.createElement('script');
        //script.type = 'text/javascript';
        script.src = asyncUrl + callbackName;
        document.body.appendChild(script);
    };

    //Start loading google maps
    asyncLoad(asyncUrl, 'googleMapsInitialized');

    //Usage: MapInitializer.initialized.then(callback)
    return {
        initialized: deferred.promise
    };
});
