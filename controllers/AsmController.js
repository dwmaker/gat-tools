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
		return res.send(data);
	})
	.catch((err) =>
	{
		return next(err);
	});
}

module.exports = controller;