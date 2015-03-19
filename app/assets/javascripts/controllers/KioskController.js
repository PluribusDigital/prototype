var controllers = angular.module('controllers');

controllers.controller("KioskController", ['$scope', '$routeParams', '$location', '$resource', '$http',
  function ($scope, $routeParams, $location, $resource, $http) {
      /************************************************************************************************
      * Route Parameters & Defaults
      */
      $scope.wmataArrivals = [];
      $scope.wmataStationNames = [];

      /************************************************************************************************
      * WMATA Alerts
      */
      var WmataArrival = $resource('/wmata/arrivals', {
        format: 'json'
      });
      WmataArrival.query({
        station_codes: 'C05,K01'
      }, function(results) {
        $scope.wmataArrivals = results;
        $scope.wmataStationNames = U.uniqueValuesForKey(results,"LocationName")
      });

      /************************************************************************************************
      * Methods
      */

  }
]);
