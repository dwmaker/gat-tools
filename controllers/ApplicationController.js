'use strict';
// @CodeGeneratorOverwrite: enabled
const ApplicationControllerService = require("../services/ApplicationController.js");

let controller = {};
controller.listApplications = function(req, res, next)
{
	
	ApplicationControllerService.listApplications()
	.then((data) =>
	{
		return res.send(data);
	})
	.catch((err) =>
	{
		return next(err);
	});
}
controller.listCenarios = function(req, res, next)
{
	
	ApplicationControllerService.listCenarios()
	.then((data) =>
	{
		return res.send(data);
	})
	.catch((err) =>
	{
		return next(err);
	});
}
controller.listEnvironments = function(req, res, next)
{
	
	ApplicationControllerService.listEnvironments()
	.then((data) =>
	{
		return res.send(data);
	})
	.catch((err) =>
	{
		return next(err);
	});
}

module.exports = controller;