'use strict';
const express = require('express');
const fs = require('fs');
const swaggerUiExpress = require('swagger-ui-express');
const oasTools = require('oas-tools');
const jsyaml = require('js-yaml');
const http = require('http');
const bodyParser = require('body-parser');

var app = express();
var serverPort = 3000;

// swaggerRouter configuration
var spec = fs.readFileSync(`${__dirname}/api/swagger.yaml`, 'utf8');
var swaggerDoc = jsyaml.safeLoad(spec);
var options = 
{
	controllers: `${__dirname}/controllers`,
	checkControllers: true,
	loglevel: 'info',
	strict: false,
	router: true,
	validator: true,
	docs: 
	{
		apiDocs: '/docs',
		apiDocsPrefix: '',
		swaggerUiPrefix: ''
	},
	oasSecurity: true,
	securityFile: {},
	oasAuth: true,
	grantsFile: {},
	ignoreUnknownFormats: false
	
};
oasTools.configure(options);

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(bodyParser.json({strict: false}));
app.use('/',    express.static(`${__dirname}/public`));
app.use('/lib', express.static(`${__dirname}/node_modules/alasql/dist`));
app.use('/lib', express.static(`${__dirname}/node_modules/xlsx/dist`));
app.use('/lib', express.static(`${__dirname}/node_modules/jquery/dist`));
app.use('/lib', express.static(`${__dirname}/node_modules/bootstrap/dist`));
app.use('/lib', express.static(`${__dirname}/node_modules/angular`));
app.use('/lib', express.static(`${__dirname}/node_modules/@fortawesome/fontawesome-free`));
app.use('/lib', express.static(`${__dirname}/node_modules/angular-route`));
app.use('/api-docs', swaggerUiExpress.serve, swaggerUiExpress.setup(swaggerDoc));


oasTools.initialize(swaggerDoc, app, 
() =>
{
	var server = http.createServer(app);
	server.listen(serverPort, 
	function() 
	{
		console.log('Your server is listening on port %d (http://localhost:%d)', serverPort, serverPort);
		console.log('Swagger-ui is available on http://localhost:%d/api-docs', serverPort);
	});
});
