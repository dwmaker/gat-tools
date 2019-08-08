'use strict';
// @CodeGeneratorOverwrite: enabled
const AsmControllerService = require("../services/AsmController.js");

let controller = {};
controller.listAsmdisks = function(req, res, next)
{
	let datasourceCode = req.params.datasourceCode;
	
	AsmControllerService.listAsmdisks(datasourceCode)
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