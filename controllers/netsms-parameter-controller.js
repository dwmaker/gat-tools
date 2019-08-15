"use strict";
const NetsmsParameterService = require("../services/netsms-parameter-service.js");

let controller = {};
controller.listNetsmsParameter = function(req, res, next)
{
	let datasourceCode = req.params.datasourceCode;
	
	NetsmsParameterService.listNetsmsParameter(datasourceCode)
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