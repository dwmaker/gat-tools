"use strict";
const service = require("../services/application-service.js");

let controller = {};
controller.listApplications = function(req, res, next)
{
	service.listApplications()
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
	
	service.listCenarios()
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
	service.listEnvironments()
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