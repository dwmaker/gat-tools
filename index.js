'use strict';
const express = require('express');
const fs = require('fs');
const swaggerUiExpress = require('swagger-ui-express');
const jsyaml = require('js-yaml');
const http = require('http');
const bodyParser = require('body-parser');
const authService = require("./services/auth-service.js");
const apiRouter = require('./api-router.js');

// swaggerRouter configuration
var spec = fs.readFileSync(`${__dirname}/swagger.yaml`, 'utf8');
var swaggerDoc = jsyaml.safeLoad(spec);

var app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(bodyParser.json({strict: false}));
app.use(authService.passport.initialize());

app.use('/',    express.static(`${__dirname}/public`));
app.use('/lib', express.static(`${__dirname}/node_modules/alasql/dist`));
app.use('/lib', express.static(`${__dirname}/node_modules/xlsx/dist`));
app.use('/lib', express.static(`${__dirname}/node_modules/jquery/dist`));
app.use('/lib', express.static(`${__dirname}/node_modules/bootstrap/dist`));
app.use('/lib', express.static(`${__dirname}/node_modules/angular`));
app.use('/lib', express.static(`${__dirname}/node_modules/@fortawesome/fontawesome-free`));
app.use('/lib', express.static(`${__dirname}/node_modules/angular-route`));
app.use('/uib', express.static(`${__dirname}/node_modules/ui-bootstrap4`));
app.use('/api-docs', swaggerUiExpress.serve, swaggerUiExpress.setup(swaggerDoc));
app.use('/api/v1', apiRouter);


var server = http.createServer(app);
var serverPort = 3000;
server.listen(serverPort, 
function() 
{
	console.log('Your server is listening on port %d (http://localhost:%d)', serverPort, serverPort);
	console.log('Swagger-ui is available on http://localhost:%d/api-docs', serverPort);
});
