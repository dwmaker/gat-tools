'use strict';
// @CodeGeneratorOverwrite: enabled
const NetsmsVersionControllerService = require("../services/NetsmsVersionController.js");

let controller = {};
controller.listNetsmsVersion = function(req, res, next)
{
	let datasourceCode = req.params.datasourceCode;
	
	NetsmsVersionControllerService.listNetsmsVersion(datasourceCode)
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