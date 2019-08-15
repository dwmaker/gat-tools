"use strict";
const DatasourceService = require("../services/datasource-service.js");
const securityController = require("./security-controller.js")
let controller = {};

controller.listDatasources = 
[
	securityController([{"basicAuth": ["browse:datasource"]}]),
	function(req, res, next)
	{
		let type = req.query.type;
		let applicationCode = req.query.applicationCode;
		
		DatasourceService.listDatasources(type, applicationCode)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			return res.status(500).send(err);
		});
	}
];

controller.getDatasource = 
[
	securityController([{"basicAuth": ["read:datasource"]}]),
	function(req, res, next)
	{
		let datasourceCode = req.params.datasourceCode;
		DatasourceService.getDatasource(datasourceCode)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			return res.status(500).send(err);
		});
	},
]

controller.createDatasource = 
[
	securityController([{"basicAuth": ["add:datasource"]}]),
	function(req, res, next)
	{
		let datasource = req.body;
		DatasourceService.createDatasource(datasource)
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

controller.deleteDatasource = 
[
	securityController([{"basicAuth": ["delete:datasource"]}]),
	function(req, res, next)
	{
		let datasourceCode = req.params.datasourceCode;
		DatasourceService.deleteDatasource(datasourceCode)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			console.error(err);
			return res.status(500).send(err);
		});
	},
];

controller.updateDatasource = 
[
	securityController([{"basicAuth": ["edit:datasource"]}]),
	function(req, res, next)
	{
		let code = req.params.datasourceCode;
		let datasource = req.body;
		DatasourceService.updateDatasource(code, datasource)
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