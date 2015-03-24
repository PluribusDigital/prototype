var controllers = angular.module('controllers');

controllers.controller("KioskController", ['$scope', '$interval', function ($scope, $interval) {
    $scope.slides = ['1', '2'];
    $scope.current = '1';
    $scope.index = 0;

    $scope.sweep = 0;
    $scope.maxSweep = 20;

    $scope.tick = $interval(function () {
        $scope.sweep += 1;
        if ($scope.sweep >= $scope.maxSweep) {
            $scope.rotateSlide();
            $scope.sweep = 0;
        }
    }, 1000);

    $scope.rotateSlide = function () {
        $scope.index += 1;
        if ($scope.index >= $scope.slides.length)
            $scope.index = 0;

        $scope.current = $scope.slides[$scope.index];
    }

    $scope.$on('$destroy', function () {
        $scope.releaseTimer($scope.tick);
    });

    $scope.releaseTimer = function (timer) {
        if (angular.isDefined(timer)) {
            $interval.cancel(timer);
            $scope.timer = undefined;
        }
    }
}]);
