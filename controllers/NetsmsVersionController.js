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
		return res.status(200).send(data);
	})
	.catch((err) =>
	{
		return res.status(500).send(err);
	});
}

module.exports = controller;