'use strict';
const express = require('express');
const fs = require('fs');
const swaggerUiExpress = require('swagger-ui-express');
const jsyaml = require('js-yaml');
const http = require('http');
const bodyParser = require('body-parser');
const apiRouter = require('./api-router.js');
var app = express();

// swaggerRouter configuration
var spec = fs.readFileSync(`${__dirname}/swagger.yaml`, 'utf8');
var swaggerDoc = jsyaml.safeLoad(spec);
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
app.use('/uib', express.static(`${__dirname}/node_modules/ui-bootstrap4`));
app.use('/api-docs', swaggerUiExpress.serve, swaggerUiExpress.setup(swaggerDoc));
app.use('/api/v1', apiRouter);
//////////////////////////////////////

let logins = [{username:"paulo", password:"teste", verifyPassword: function verifyPassword(password){return password==this.password}}]
let LoginDAO = 
{

	findOne: (par, callback) =>
	{
		return new Promise((resolve, reject)=>
		{
			let result = logins.filter(login=>login.username==par.username);
			if(result.length==0) return reject("no data found")
			return resolve(result[0]);
		})
		
	}
}
const passport = require("passport");
const LocalStrategy = require('passport-local').Strategy;
app.use(passport.initialize())
passport.use(new LocalStrategy(
	function(username, password, callback) 
	{
		LoginDAO.findOne({ username: username })
		.then((login)=>
		{
			if (!login) { return callback(null, false); }
			if (!login.verifyPassword(password)) 
			{
				return callback('Invalid passow', false);
			}
			return callback(null, login);
		})
		.catch((err)=>
		{
			return callback(err);
		})		
	}
));

app.post('/login', function(req, res, next) 
{
	console.log(req.params);
	passport.authenticate('local', 
	function(err, login, info) 
	{
		if (err) 
		{
			return res.send({msg: err.toString()}); 
		}
		if (!login) 
		{
			return res.send({msg: "login is blank"}); 
		}
		req.logIn(login, function(err) 
		{
			if (err) { return next(err); }
			return res.send({login: login}); 
			
		});
	})(req, res, next);
});
/////////////////////////////////////////

var server = http.createServer(app);
var serverPort = 3000;
server.listen(serverPort, 
function() 
{
	console.log('Your server is listening on port %d (http://localhost:%d)', serverPort, serverPort);
	console.log('Swagger-ui is available on http://localhost:%d/api-docs', serverPort);
});
