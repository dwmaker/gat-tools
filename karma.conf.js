// Karma configuration
// Generated on Sat Aug 31 2019 21:52:17 GMT-0300 (GMT-03:00)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine'],


    // list of files / patterns to load in the browser
    files: [
		'node_modules/jquery/dist/jquery.min.js',
		'node_modules/ui-bootstrap4/js/bootstrap.min.js',
		'node_modules/angular/angular.min.js',
		'node_modules/angular-route/angular-route.min.js',
		'node_modules/angular-base64/angular-base64.min.js',
		'node_modules/angular-cookies/angular-cookies.min.js',
		'node_modules/angular-locale-pt-br/angular-locale_pt-br.js',
		'node_modules/alasql/dist/alasql.min.js',
		'node_modules/xlsx/dist/xlsx.full.min.js',
		
		'node_modules/ui-bootstrap4/dist/ui-bootstrap-tpls.js',
		'node_modules/ui-bootstrap4/dist/ui-bootstrap.js',
	
		'node_modules/angular-mocks/angular-mocks.js',
		"public/app.module.js",
		"public/app.routes.js",
		"public/components/**/*.js",
		"public/components/**/*.spec.js",
    ],


    // list of files / patterns to exclude
    exclude: [
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
    },


    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false,

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity
  })
}
