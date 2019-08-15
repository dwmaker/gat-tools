"use strict";
const service = require("../services/asm-service.js");

let controller = {};
controller.listAsmdisks = 
[
	function(req, res)
	{
		let datasourceCode = req.params.datasourceCode;
		
		service.listAsmdisks(datasourceCode)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			return res.status(500).send(err);
		});
	},
];

module.exports = controller;