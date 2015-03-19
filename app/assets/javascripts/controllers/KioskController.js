var controllers = angular.module('controllers');

controllers.controller("KioskController", ['$scope', '$routeParams', '$location', '$resource', '$http',
  function ($scope, $routeParams, $location, $resource, $http) {
      /************************************************************************************************
      * Route Parameters & Defaults
      */
      $scope.wmataArrivals = [];

      /************************************************************************************************
      * WMATA Alerts
      */
      var WmataArrival = $resource('', {
        format: 'json'
      });
      WmataArrival.query({
        StationCodes: 'C05',
        api_key:      configData.wmataApiKey
      }, function(results) {
        console.log(results);
        return $scope.wmataArrivals = results;
      });

      
      // var FarmersMarket = $resource('/farmers_markets/:id', {
      //     id: "@id",
      //     format: 'json'
      // });
      // FarmersMarket.query({
      //     zip: $scope.zip
      // }, function (results) {
      //     return $scope.farmersMarkets = results;
      // });

      /************************************************************************************************
      * Methods
      */
      // $scope.gotoZip = function (zip) {
      //     return $location.path("/zip/" + zip);
      // };

      /***********
      * Initialize
      */
      // $http.get('https://maps.googleapis.com/maps/api/geocode/json', {
      //     params: { components: 'postal_code:' + $scope.zip },
      // }).success($scope.geocodeResultPostalCode)
      //   .error(function (data) { alert('doh'); });
  }
]);
