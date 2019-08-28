"use strict";
const service = require("../services/netsms-parameter-service.js");

let controller = {};
controller.listNetsmsParameter = function(req, res, next)
{
	let datasourceCode = req.params.datasourceCode;
	
	service.listNetsmsParameter(datasourceCode)
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