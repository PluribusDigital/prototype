controllers = angular.module('controllers')
controllers.controller("ZipController", [ '$scope', '$routeParams', '$location', '$resource', 'flash',
  ($scope,$routeParams,$location,$resource,flash)->

    $scope.zip = $routeParams.id

    FarmersMarket = $resource('/farmers_markets/:id', { id: "@id", format: 'json' })
    FarmersMarket.query(zip: $scope.zip, (results)-> $scope.farmersMarkets = results)

    SocialSecurityBeneficiaries = $resource('/social_security_beneficiaries/:id', { id: "@id", format: 'json' })
    SocialSecurityBeneficiaries.get({id: $scope.zip},
      ( (socialSecurityBeneficiaries)-> $scope.socialSecurityBeneficiaries = socialSecurityBeneficiaries ),
      ( (httpResponse)->
        $scope.socialSecurityBeneficiaries = null
        flash.error   = "Sorry, Recipe Not Found!"
      )
    )
])