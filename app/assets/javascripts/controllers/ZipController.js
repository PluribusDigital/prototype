var controllers = angular.module('controllers');

controllers.controller("ZipController", [
  '$scope', '$routeParams', '$location', '$resource', 'flash', function ($scope, $routeParams, $location, $resource, flash) {
      var FarmersMarket, SocialSecurityBeneficiaries;
      FarmersMarket = $resource('/farmers_markets/:id', {
          id: "@id",
          format: 'json'
      });
      SocialSecurityBeneficiaries = $resource('/social_security_beneficiaries/:id', {
          id: "@id",
          format: 'json'
      });
      $scope.zip = $routeParams.id;
      FarmersMarket.query({
          zip: $scope.zip
      }, function (results) {
          return $scope.farmersMarkets = results;
      });
      SocialSecurityBeneficiaries.get({
          id: $scope.zip
      }, (function (socialSecurityBeneficiaries) {
          return $scope.socialSecurityBeneficiaries = socialSecurityBeneficiaries;
      }), (function (httpResponse) {
          $scope.socialSecurityBeneficiaries = null;
          return flash.error = "Sorry, Recipe Not Found!";
      }));
      return $scope.gotoZip = function (zip) {
          return $location.path("/zip/" + zip);
      };
  }
]);
