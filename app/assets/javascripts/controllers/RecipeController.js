var controllers = angular.module('controllers');

controllers.controller("RecipeController", [
  '$scope', '$routeParams', '$location', '$resource', 'flash', function ($scope, $routeParams, $location, $resource, flash) {
      var Recipe;
      Recipe = $resource('/recipes/:id', {
          id: "@id",
          format: 'json'
      }, {
          'save': {
              method: 'PUT'
          },
          'create': {
              method: 'POST'
          }
      });
      if ($routeParams.id) {
          Recipe.get({
              id: $routeParams.id
          }, (function (recipe) {
              return $scope.recipe = recipe;
          }), (function (httpResponse) {
              $scope.recipe = null;
              return flash.error = "Sorry, Recipe Not Found!";
          }));
      } else {
          $scope.recipe = {};
      }
      $scope.back = function () {
          return $location.path("/");
      };
      $scope.edit = function () {
          return $location.path("/recipe/" + $scope.recipe.id + "/edit");
      };
      $scope.cancel = function () {
          if ($scope.recipe.id) {
              return $location.path("/recipe/" + $scope.recipe.id);
          } else {
              return $location.path("/");
          }
      };
      $scope.save = function () {
          var onError;
          onError = function (_httpResponse) {
              return flash.error = "Something went wrong";
          };
          if ($scope.recipe.id) {
              return $scope.recipe.$save((function () {
                  return $location.path("/recipe/" + $scope.recipe.id);
              }), onError);
          } else {
              return Recipe.create($scope.recipe, (function (newRecipe) {
                  return $location.path("/recipe/" + newRecipe.id);
              }), onError);
          }
      };
      return $scope["delete"] = function () {
          $scope.recipe.$delete();
          return $scope.back();
      };
  }
]);
