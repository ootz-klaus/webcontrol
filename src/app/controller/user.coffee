((window, app) -> 
    app.controller 'UserController', ['$scope', ($scope) ->
        # console.log $scope
    ]
)(window, window.WebControlApp)