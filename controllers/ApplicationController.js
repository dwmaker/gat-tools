'use strict';
var oracledb = require('oracledb');
var applicationData = require("../data/application-data.json")
var cenarioData = require("../data/cenario-data.json")
var environmentData = require("../data/environment-data.json")
let controller = 
{
	getApplications: (req, res, next) =>
	{
		(async function ()
		{
			return applicationData;
		})()
		.then((arr) => 
		{
			res.send(arr);
		})
		.catch(next);	
	},
	getCenarios: (req, res, next) =>
	{
		(async function ()
		{
			return cenarioData;
		})({applicationCode: req.query.applicationCode})
		.then((arr) => 
		{
			res.send(arr);
		})
		.catch(next);	
	},
	getEnvironments: (req, res, next) =>
	{
		(async function ()
		{
			return environmentData;
		})({})
		.then((arr) => 
		{
			res.send(arr);
		})
		.catch(next);	
	}
	
};
module.exports = controller;