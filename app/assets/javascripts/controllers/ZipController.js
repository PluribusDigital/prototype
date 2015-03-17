var controllers = angular.module('controllers');

controllers.controller("ZipController", ['$scope', '$routeParams', '$location', '$resource', '$http', 'flash',
  function ($scope, $routeParams, $location, $resource, $http, flash) {
      /************************************************************************************************
      * Route Parameters
      */
      $scope.zip = $routeParams.id;

      /************************************************************************************************
      * Farmer's Market
      */
      var FarmersMarket = $resource('/farmers_markets/:id', {
          id: "@id",
          format: 'json'
      });
      FarmersMarket.query({
          zip: $scope.zip
      }, function (results) {
          return $scope.farmersMarkets = results;
      });

      /************************************************************************************************
      * SocialSecurityBeneficiaries
      */
      var SocialSecurityBeneficiaries = $resource('/social_security_beneficiaries/:id', {
          id: "@id",
          format: 'json'
      });
      SocialSecurityBeneficiaries.get({
          id: $scope.zip
      }, (function (socialSecurityBeneficiaries) {
          return $scope.socialSecurityBeneficiaries = socialSecurityBeneficiaries;
      }), (function (httpResponse) {
          $scope.socialSecurityBeneficiaries = null;
          return flash.error = "Sorry, Recipe Not Found!";
      }));

      /************************************************************************************************
      * Map
      */
      $scope.home = { lat: 38, lng: -77 };
      $scope.areaName = '';

      $scope.mapOptions = {
          center: $scope.home,
          zoom: 13,
          disableDefaultUI : true
      },

      // Setup the map & home marker
      $scope.map = new google.maps.Map(document.getElementById('map-canvas'), $scope.mapOptions);
      $scope.homeMarker = new google.maps.Marker({
          position: { lat: $scope.home.lat, lng: $scope.home.lng },
          //map: $scope.map
      });

      $scope.geocodeResultPostalCode = function (data, status, headers, config) {
          // If there are results, extract the latitude and longitude of the zip code's center
          if (data.results.length > 0) {
              var a = data.results[0].geometry.location;
              $scope.home = a;

              $scope.map.setCenter($scope.home);
              $scope.homeMarker.setPosition($scope.home);
              $scope.homeMarker.setMap($scope.map);

              // Name of the zip code (mmm Hack-i-licious)
              var full = data.results[0].formatted_address
              $scope.areaName = full.replace($scope.zip, '').replace(' , USA', '')

          }
          else {
              alert('Could not locate zip code: ' + $scope.zip);
          }
      };

      /************************************************************************************************
      * Methods
      */
      $scope.gotoZip = function (zip) {
          return $location.path("/zip/" + zip);
      };

      /************************************************************************************************
      * Initialize
      */
      $http.get('https://maps.googleapis.com/maps/api/geocode/json', {
          params: { components: 'postal_code:' + $scope.zip },
      }).success($scope.geocodeResultPostalCode)
        .error(function (data) { alert('doh'); });
  }
]);
