var controllers = angular.module('controllers');

controllers.controller("WmataController", ['$scope', '$resource', 'TimelineInitializer',
function ($scope, $resource, TimelineInitializer) {
    /************************************************************************************************
    * Route Parameters & Defaults
    */
    $scope.wmataArrivals = [];
    $scope.colorMap = {
        'BL': 'blue',
        'OR': 'orange',
        'SV': 'silver'
    }

    /************************************************************************************************
    * WMATA Alerts
    */
    var WmataArrival = $resource('/wmata/arrivals', {
        format: 'json'
    });
    WmataArrival.query({
        station_codes: 'C05,K01'
    }, function (results) {
        $scope.transformArrivalData(results);
    });

    /************************************************************************************************
    * Methods
    */
    $scope.transformArrivalData = function (data) {
        var destinations = [];

        for (var i = 0; i < data.length; i++) {
            if (data[i].DestinationCode == null)
                continue;

            var direction = (data[i].Group == "2") ? "->VA" : "->DC"

            // Build a timeline element
            var d = [
                data[i].LocationName + direction,
                data[i].DestinationName,
                $scope.colorMap[data[i].Line],
                new Date(),
                new Date()
            ];

            // Handle "boarding"
            var minutes = parseInt(data[i].Min);
            if (isNaN(minutes))
                minutes = 0;

            // Add minutes to the current time
            d[3].setMinutes(d[3].getMinutes() + minutes);
            d[4].setMinutes(d[4].getMinutes() + minutes + 1);

            // Push to the collection
            $scope.wmataArrivals.push(d);
        }

        TimelineInitializer.initialized.then($scope.drawTimeline)
    };

    $scope.drawTimeline = function () {
        var dataTable = new google.visualization.DataTable();
        dataTable.addColumn({ type: 'string', id: 'Station' });
        dataTable.addColumn({ type: 'string', id: 'Name' });
        dataTable.addColumn({ type: 'string', role: 'style' });
        dataTable.addColumn({ type: 'date', id: 'Start' });
        dataTable.addColumn({ type: 'date', id: 'End' });
        dataTable.addRows($scope.wmataArrivals);

        // use a DataView to hide the 'Line' column from the Timeline
        var view = new google.visualization.DataView(dataTable);
        view.setColumns([0, 1, 2, 3, 4]);

        var container = document.getElementById('timeline');
        var chart = new google.visualization.Timeline(container);

        chart.draw(view);
    };
}
]);
