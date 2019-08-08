'use strict';
// @CodeGeneratorOverwrite: enabled
const ApplicationControllerService = require("../services/ApplicationController.js");

let controller = {};
controller.listApplications = function(req, res, next)
{
	
	ApplicationControllerService.listApplications()
	.then((data) =>
	{
		return res.status(200).send(data);
	})
	.catch((err) =>
	{
		return res.status(500).send(err);
	});
}
controller.listCenarios = function(req, res, next)
{
	
	ApplicationControllerService.listCenarios()
	.then((data) =>
	{
		return res.status(200).send(data);
	})
	.catch((err) =>
	{
		return res.status(500).send(err);
	});
}
controller.listEnvironments = function(req, res, next)
{
	
	ApplicationControllerService.listEnvironments()
	.then((data) =>
	{
		return res.status(200).send(data);
	})
	.catch((err) =>
	{
		return res.status(500).send(err);
	});
}

module.exports = controller;