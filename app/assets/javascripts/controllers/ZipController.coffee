controllers = angular.module('controllers')
controllers.controller("ZipController", [ '$scope', '$routeParams', '$location', '$resource', 'flash',
  ($scope,$routeParams,$location,$resource,flash)->

    FarmersMarket = $resource(
      '/farmers_markets/:id', 
      { id: "@id", format: 'json' }
    )
    SocialSecurityBeneficiaries = $resource(
      '/social_security_beneficiaries/:id', 
      { id: "@id", format: 'json' }
    )

    $scope.zip = $routeParams.id

    FarmersMarket.query({zip: $scope.zip}, 
      (results)-> $scope.farmersMarkets = results
    )
    SocialSecurityBeneficiaries.get({id: $scope.zip},
      ( (socialSecurityBeneficiaries)-> $scope.socialSecurityBeneficiaries = socialSecurityBeneficiaries ),
      ( (httpResponse)->
        $scope.socialSecurityBeneficiaries = null
        flash.error   = "Sorry, Recipe Not Found!"
      )
    )

    $scope.gotoZip = (zip)-> $location.path("/zip/#{zip}")

    # $scope.showMarketDetail = ->
    #   $scope.farmersMarketDetail = 
    #   FarmersMarket.get({id: $routeParams.id},
    #     ( (recipe)-> $scope.recipe = recipe ),
    #     ( (httpResponse)->
    #       $scope.recipe = null
    #       flash.error   = "Sorry, Recipe Not Found!"
    #     )
    #   )
])