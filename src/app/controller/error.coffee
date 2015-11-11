((window, app) -> 
    app.controller 'ErrorController', ['$scope', ($scope) ->
        # console.log $scope
    ]
)(window, window.WebControlApp)