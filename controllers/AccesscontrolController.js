'use strict';
// @CodeGeneratorOverwrite: enabled
const AccesscontrolControllerService = require("../services/AccesscontrolController.js");

let controller = {};
controller.listAccesscontrols = function(req, res, next)
{
	let datasourceCode = req.params.datasourceCode;
	let type = req.query.type;
	
	AccesscontrolControllerService.listAccesscontrols(datasourceCode, type)
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