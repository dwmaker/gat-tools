'use strict';
// @CodeGeneratorOverwrite: enabled
const NetsmsParameterControllerService = require("../services/NetsmsParameterController.js");

let controller = {};
controller.listNetsmsParameter = function(req, res, next)
{
	let datasourceCode = req.params.datasourceCode;
	
	NetsmsParameterControllerService.listNetsmsParameter(datasourceCode)
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