((window) ->
    class FirewallService
        constructor: (@http) ->
        getPorts: (successCallback, errorCallback) ->
            $request = @http
                url: '/data/ports.json'
                method: 'GET'

            if errorCallback 
                $request.then successCallback
            else
                $request.then successCallback, errorCallback

    window.FirewallService = FirewallService;
)(window)