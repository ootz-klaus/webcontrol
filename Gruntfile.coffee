module.exports = (grunt) ->
    grunt.initConfig
        config:
            bowerrc:
                directory: 'bower_components'
            pkg: grunt.file.readJSON 'package.json'

            dir:
                dist: 'dist'
                dev: './.tmp'

        # @clean
        # Remove files and directories
        clean:
            dev: ['<%= config.dir.dev %>']
            dist: ['<%= config.dir.dist %>']

        # @jade
        # Process Jade template files
        jade:
            options:
                pretty: true

            # @jade:dev
            # Process templates for development environment
            dev:
                options:
                    data:
                        assets:
                            js: [
                                '<%= config.bowerrc.directory %>/angular/angular.min.js'
                                '<%= config.bowerrc.directory %>/angular-ui-router/release/angular-ui-router.min.js'

                                # Template scripts
                                '<%= config.bowerrc.directory %>/jquery/dist/jquery.min.js'
                                '<%= config.bowerrc.directory %>/bootstrap/dist/js/bootstrap.min.js'
                                '<%= config.bowerrc.directory %>/bootstrap-sidebar/dist/js/sidebar.js'

                                # Angular configurations
                                'app/config.js'
                                'app/app.js'

                                # Angular services files
                                'app/service/template.js'

                                # Angular controllers files
                                'app/controller/dashboard.js'
                            ]

                            css: [
                                # 'https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,200,200italic,300,300italic,400italic,600,600italic,700,900,700italic,900italic'
                                '<%= config.bowerrc.directory %>/font-awesome/css/font-awesome.min.css'
                                '<%= config.bowerrc.directory %>/bootstrap/dist/css/bootstrap.min.css'
                                '<%= config.bowerrc.directory %>/bootstrap-sidebar/dist/css/sidebar.css'
                                'assets/css/app.css'
                            ]
                files: [
                        expand: true
                        cwd: 'src/app/view/'
                        src: '**/*.jade'
                        dest: '<%= config.dir.dev %>/app/views/'
                        ext: '.html'
                    ,
                        src: 'src/index.jade'
                        dest: '<%= config.dir.dev %>/index.html'
                ]

        # @coffee
        # Coffe script sources to compile
        coffee:
            options:
                bare: true
            dev:
                expand: true
                cwd: 'src/'
                src: '**/*.coffee'
                dest: '<%= config.dir.dev %>/'
                ext: '.js'

        # @less
        # Process the less files
        less:
            options:
                paths: [
                    '<%= config.bowerrc.directory %>'
                ],
                ### modifyVars: {
                    theme: '<%= config.bootswatch.theme %>'
                }
                ###
            dev:
                files:
                    '<%= config.dir.dev %>/assets/css/app.css': 'src/assets/less/app.less'

        # @connect
        # Development server configuration
        connect:
            server:
                options:
                    port: 4000
                    base: ['<%= config.dir.dev %>', '<%= config.bowerrc.directory %>']
                    open: false
                    livereload: true
                    hostname: '*'
                    middleware: (connect) ->
                        liveReload = require 'connect-livereload'
                        serveStatic = require 'serve-static'
                        [
                            liveReload()
                            connect().use '/bower_components', serveStatic './bower_components'
                            serveStatic './.tmp'
                        ]
        # @watch
        # Watch changes on source files
        watch:
            config:
                files: ['Gruntfile.coffee']
                tasks: [
                    'jade:dev'
                    'coffee:dev'
                    'less:dev'
                ]
                options:
                    reload: true
            coffee:
                files: ['src/**/*.coffee']
                tasks: ['coffee:dev']
            jade:
                files: ['src/**/**.jade']
                tasks: ['jade:dev']
            less:
                files: ['src/**/**.less']
                tasks: ['less:dev']
            app:
                files: [
                    '<%= config.dir.dev %>/app/**/*.*'
                    '<%= config.dir.dev %>/assets/css/*.*'
                ]
                options:
                    livereload: true

        # @copy
        # Copy static sources
        copy:
            dev:
                files: [
                        expand: true
                        cwd: 'src/assets/font'
                        src: ['**']
                        dest: '<%= config.dir.dev %>/assets/font'
                    ,
                        expand: true
                        cwd: 'src/data'
                        src: '**'
                        dest: '<%= config.dir.dev %>/data'
                ]

    grunt.loadNpmTasks 'main-bower-files'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-less'
    # grunt.loadNpmTasks 'grunt-contrib-concat'

    grunt.registerTask 'dev', [
        'clean:dev'
        'copy:dev'
        'less:dev'
        'jade:dev'
        'coffee:dev'
        'connect'
        'watch'
    ]