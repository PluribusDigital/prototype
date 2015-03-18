var controllers = angular.module('controllers');

controllers.controller("ZipController", ['$scope', '$routeParams', '$location', '$resource', '$http', 'flash',
    'ChartInitializer', 'MapInitializer',
  function ($scope, $routeParams, $location, $resource, $http, flash, ChartInitializer, MapInitializer) {
      //google.load("visualization", "1", { packages: ["corechart"] });
      //google.setOnLoadCallback($scope.drawChart);

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
          $scope.socialSecurityBeneficiaries = socialSecurityBeneficiaries;
          ChartInitializer.initialized.then($scope.drawChart)
      }), (function (httpResponse) {
          $scope.socialSecurityBeneficiaries = null;
          return flash.error = "Sorry, Recipe Not Found!";
      }));

      /************************************************************************************************
      * Map
      */
      $scope.home = { lat: 38, lng: -77 };
      $scope.areaName = '';
      $scope.map = null;

      $scope.geocodeResultPostalCode = function (data, status, headers, config) {
          // If there are results, extract the latitude and longitude of the zip code's center
          if (data.results.length > 0) {
              var a = data.results[0].geometry.location;
              $scope.home = a;

              if ($scope.map) {
                  $scope.map.setCenter($scope.home);
                  $scope.homeMarker.setPosition($scope.home);
                  $scope.homeMarker.setMap($scope.map);
              }

              // Name of the zip code (mmm Hack-i-licious)
              var full = data.results[0].formatted_address
              $scope.areaName = full.replace($scope.zip, '').replace(' , USA', '')

          }
          else {
              alert('Could not locate zip code: ' + $scope.zip);
          }
      };

      $scope.drawMap = function () {
          $scope.mapOptions = {
              center: $scope.home,
              zoom: 13,
              disableDefaultUI: true
          },

          // Setup the map & home marker
          $scope.map = new google.maps.Map(document.getElementById('map-canvas'), $scope.mapOptions);
          $scope.homeMarker = new google.maps.Marker({
              position: { lat: $scope.home.lat, lng: $scope.home.lng },
              map: $scope.map
          });
      };

      /************************************************************************************************
      * Chart
      */

      $scope.drawChart = function () {

          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Beneficiaries');
          data.addColumn('number', 'Count');

          var fields = ['Children', 'Disabled workers', 'Retired workers', 'Spouses', 'Widow(er)s and parents']
          for (var i = 0; i < fields.length; i++) {
              var k = fields[i];
              var v = parseInt($scope.socialSecurityBeneficiaries[k]);
              data.addRow([k, v]);
          }

          var options = {
          };

          var pieDiv = document.getElementById('piechart');
          var chart = new google.visualization.PieChart(pieDiv);

          chart.draw(data, options);
      }

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

      MapInitializer.initialized.then($scope.drawMap)
  }
]);
