((window, app, $) -> 
    app.controller 'FirewallController', ['$scope', 'FirewallService', ($scope, $firewall) ->
        $scope.http_port = true

        $firewall.getPorts (response) ->
            $scope.ports = response.data

        $scope.bindBootstrapSwitchChangeEvent = -> 
            angular.element '.bootstrapSwitch'
                .on 'switchChange.bootstrapSwitch', ->
                    $element = angular.element this
                    status = $element.bootstrapSwitch 'state'
                    data = $element.data()

                    port =
                        id: data.portId
                        description: data.portDescription
                        number: data.portNumber
                        status: $element.bootstrapSwitch 'state'

            return false
            
    ]
)(window, window.WebControlApp, $)