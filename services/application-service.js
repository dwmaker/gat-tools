"use strict";
var applicationData = require("../data/application-data.json")
var cenarioData = require("../data/cenario-data.json")
var environmentData = require("../data/environment-data.json")

let service = {};

service.listApplications = 
function()
{
	return new Promise((resolve, reject) =>
	{
		resolve(applicationData);
	});
};

service.listCenarios = 
function()
{
	return new Promise((resolve, reject) =>
	{
		resolve(cenarioData);
	});
};

service.listEnvironments = 
function()
{
	return new Promise((resolve, reject) =>
	{
		resolve(environmentData);
	});
};

module.exports = service;