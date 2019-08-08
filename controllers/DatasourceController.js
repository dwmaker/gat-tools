'use strict';
// @CodeGeneratorOverwrite: enabled
const DatasourceControllerService = require("../services/DatasourceController.js");

let controller = {};
controller.listDatasources = function(req, res, next)
{
	let type = req.query.type;
	let applicationCode = req.query.applicationCode;
	DatasourceControllerService.listDatasources(type, applicationCode)
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