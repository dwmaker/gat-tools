'use strict';
const DatasourceService = require("../services/DatasourceService.js");
const authService = require("../services/auth-service.js");
let controller = {};

controller.listDatasources = 
[
	function(req, res, next)
	{
		authService.basicAuth(req, res, next)
		.then((user)=>
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
		})
		.catch((err)=>
		{
			return res.status(401).send(err);
		});
	}
];

controller.getDatasource = 
[
	function(req, res, next)
	{
		authService.basicAuth(req, res, next)
		.then((user)=>
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
		})
		.catch((err)=>
		{
			return res.status(401).send(err);
		});
	},
]

controller.createDatasource = 
[
	function(req, res, next)
	{
		authService.basicAuth(req, res, next)
		.then((user)=>
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
		})
		.catch((err)=>
		{
			return res.status(401).send(err);
		});
	},
];

controller.deleteDatasource = 
[
	function(req, res, next)
	{
		authService.basicAuth(req, res, next)
		.then((user)=>
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
		})
		.catch((err)=>
		{
			console.log(err)
			return res.status(401).send(err);
		});
	},
];

controller.updateDatasource = 
[
	function(req, res, next)
	{
		authService.basicAuth(req, res, next)
		.then((user)=>
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
		})
		.catch((err)=>
		{
			return res.status(401).send(err);
		});
	},
];

module.exports = controller;