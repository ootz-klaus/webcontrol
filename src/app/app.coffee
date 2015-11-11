WebControlApp = ((angular) -> 
    app = angular.module 'WebControlApp', ['ui.router', 'frapontillo.bootstrap-switch']

    app.config ($stateProvider, $urlRouterProvider, $locationProvider, $provide) ->
        # $locationProvider.html5Mode true
        $urlRouterProvider.otherwise '/not-found'

        # Not found page
        $stateProvider
            .state 'not-found', 
                url: '/not-found'
                templateUrl: 'app/view/error/not-found.html'
                onEnter: ($rootScope) ->
                    $rootScope.title = 'Página não encontrada'

        # Home/dashboard page
        $stateProvider
            .state 'dashboard',
                url: '/'
                templateUrl: 'app/view/dashboard/index.html'
                controller: 'DashboardController'
                onEnter: ($rootScope) ->
                    $rootScope.title = 'Dashboard'

        # Firewall page
        $stateProvider
            .state 'firewall',
                url: '/firewall'
                templateUrl: 'app/view/firewall/index.html'
                controller: 'FirewallController'
                onEnter: ($rootScope) ->
                    $rootScope.title = 'Firewall'

        # Users pages
        $stateProvider
            .state 'users',
                url: '/users'
                templateUrl: 'app/view/user/index.html'
                controller: 'UserController'
                onEnter: ($rootScope) ->
                    $rootScope.title = 'Usuários'
            .state 'users.add',
                url: '/add'
                templateUrl: 'app/view/user/form.html'
                controller: 'UserController.index'
                onEnter: ($rootScope) ->
                    $rootScope.title = 'Criar novo'

        $provide.factory 'FirewallService', ['$http', ($http) ->
            new FirewallService $http
        ]

    app.run ($rootScope, $state) ->
        # Deny access to Dashboard page until that finishes
        $rootScope.$on '$stateChangeStart', (event, toState) ->
            if toState.name is 'dashboard'
                event.preventDefault()
                $state.go 'firewall'


    return app
)(angular)