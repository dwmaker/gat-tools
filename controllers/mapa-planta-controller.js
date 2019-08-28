"use strict";
const { body, param, query } = require("express-validator");
const service = require("../services/mapa-planta-service.js");
const securityController = require("./security-controller.js")
const validationController = require("./validation-controller.js");
const {ResponseError} = require("../errors");
let controller = {};



controller.listMapaPlanta = 
[
	validationController([
		query("tp_mapa_in").toArray()
	]),
	securityController([{"basicAuth": ["browse:mapa-planta"]}]),	
	function(req, res, next)
	{
		let filter = 
		{
			tp_mapa_in: req.query.tp_mapa_in
		};

		service.listMapaPlanta(filter)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			return next(err);
		});
	}
];

controller.getMapaPlanta = 
[
	validationController([
		param("id").exists({checkNull: true, checkFalsy: true}).isNumeric().toInt()
	]), 
	securityController([
		{"basicAuth": ["read:mapa-planta"]}
	]),
	function(req, res, next)
	{
		let id = req.params.id;
		service.getMapaPlanta(id)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			if(err instanceof ResponseError) return res.status(err.status).json(err);
			return next(err);
		});
	},
];

controller.updateMapaPlanta = 
[
	validationController([
		param("id").exists({checkNull: true, checkFalsy: true}).toInt(),
		body("nome").exists({checkNull: true, checkFalsy: true}),
		body("descricao").optional({ checkFalsy: true }),
		body("nr_versao").optional({ checkFalsy: true }),
		body("cd_ambiente").exists({checkNull: true, checkFalsy: true}),
		body("tp_mapa").exists({checkNull: true, checkFalsy: true}).isIn(['T','M']),
		body("id_mapa_template").optional({ checkFalsy: true }).toInt(),
		body("tecnologias.*.*.conexao").exists({checkNull: true, checkFalsy: true}),
		body("tecnologias.*.*.usuarios.*").exists({checkNull: true, checkFalsy: true}),
	]), 
	securityController([
		{"basicAuth": ["edit:mapa-planta"]}
	]),
	function(req, res, next)
	{
		let id = Number(req.params.id);
		let object = req.body;
		let nmUsuarioAtual = req.user.username;
		let dtAtual = new Date();
		service.updateMapaPlanta(id, object, nmUsuarioAtual, dtAtual)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			if(err instanceof ResponseError) return res.status(err.status).json(err);
			return next(err);
		});
	},
];

controller.createMapaPlanta = 
[
	validationController([
		body("nome").exists({checkNull: true, checkFalsy: true}).isString(),
		body("descricao").optional({ checkFalsy: true }),
		body("nr_versao").optional({ checkFalsy: true }),
		body("cd_ambiente").exists({checkNull: true, checkFalsy: true}).isString(),
		body("tp_mapa").exists({checkNull: true, checkFalsy: true}).isString().isIn(['T','M']),
		body("id_mapa_template").optional({ checkFalsy: true }).isNumeric().toInt(),
		body("tecnologias.*.*.conexao").exists({checkNull: true, checkFalsy: true}),
		body("tecnologias.*.*.usuarios.*").exists({checkNull: true, checkFalsy: true}),
	]), 
	securityController([
		{"basicAuth": ["add:mapa-planta"]}
	]),
	function(req, res, next)
	{
		let object = req.body;
		let nmUsuarioAtual = req.user.username;
		let dtAtual = new Date();
		service.createMapaPlanta(object, nmUsuarioAtual, dtAtual)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			return next(err);
		});
	},
];


controller.deleteMapaPlanta = 
[
	validationController([
		param("id").exists({checkNull: true, checkFalsy: true}).toInt(),
	]), 
	securityController([
		{"basicAuth": ["delete:mapa-planta"]}
	]),
	function(req, res, next)
	{
		let id = req.params.id;
		let nmUsuarioAtual = req.user.username;
		let dtAtual = new Date();
		service.deleteMapaPlanta(id, nmUsuarioAtual, dtAtual)
		.then((data) =>
		{
			return res.status(200).send(data);
		})
		.catch((err) =>
		{
			if(err instanceof ResponseError) return res.status(err.status).json(err);
			return next(err);
		});
	},
];

module.exports = controller;