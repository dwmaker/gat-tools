"use strict";
/** @module accesscontrol-controller */
const service = require("../services/accesscontrol-service.js");

let controller = {};
controller.listAccesscontrols = 
[
	function(req, res, next)
	{
		let datasourceCode = req.params.datasourceCode;
		let type = req.query.type;
		
		service.listAccesscontrols(datasourceCode, type)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err)=>
		{
			return next(err);
		});
	},
];

controller.getMetadata = 
[
	function(req, res, next)
	{
		service.getMetadata()
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err)=>
		{
			return next(err);
		});
	},
];


module.exports = controller;