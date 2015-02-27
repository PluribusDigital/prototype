controllers = angular.module('controllers')
controllers.controller("RecipeController", [ '$scope', '$routeParams', '$location', '$resource', 'flash',
  ($scope,$routeParams,$location,$resource,flash)->

    Recipe = $resource('/recipes/:id', { id: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.id
      Recipe.get({id: $routeParams.id},
        ( (recipe)-> $scope.recipe = recipe ),
        ( (httpResponse)->
          $scope.recipe = null
          flash.error   = "Sorry, Recipe Not Found!"
        )
      )
    else
      $scope.recipe = {}
    
    $scope.back = -> $location.path("/")

    $scope.edit = -> $location.path("/recipes/#{$scope.recipe.id}/edit")

    $scope.cancel = ->
      if $scope.recipe.id
        $location.path("/recipes/#{$scope.recipe.id}")
      else
        $location.path("/")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.recipe.id
        $scope.recipe.$save(
          ( ()-> $location.path("/recipes/#{$scope.recipe.id}") ),
          onError)
      else
        Recipe.create($scope.recipe,
          ( (newRecipe)-> $location.path("/recipes/#{newRecipe.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.recipe.$delete()
      $scope.back()

])