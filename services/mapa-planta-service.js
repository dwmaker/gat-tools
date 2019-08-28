'use strict';

const oracledb = require('oracledb');
const dbConfig = require('../dbconfig.json');

let service = {};
const MapaPlantaDao = require("../dao/mapa-planta-dao.js");

service.listMapaPlanta = 
async function(filter)
{
	let connection = await oracledb.getConnection(dbConfig);
	let mapaPlantaDao = new MapaPlantaDao(connection);
	try
	{
		let res = await mapaPlantaDao.list(filter);
		await connection.close();
		return res;
	}
	catch(err)
	{
		await connection.close();
		throw err;
	}
};

service.getMapaPlanta =
async function(id)
{
	let connection = await oracledb.getConnection(dbConfig);
	let mapaPlantaDao = new MapaPlantaDao(connection);
	try
	{
		let res = await mapaPlantaDao.get(id);
		await connection.close();
		return res;
	}
	catch(err)
	{
		await connection.close();
		throw err;
	}
};

service.deleteMapaPlanta =
async function(id, nmUsuarioAtual, dtAtual)
{
	let connection = await oracledb.getConnection(dbConfig);
	let mapaPlantaDao = new MapaPlantaDao(connection);
	try
	{
		let res = await mapaPlantaDao.delete(id, nmUsuarioAtual, dtAtual);
		await connection.commit();
		await connection.close();
		return res;
	}
	catch(err)
	{
		await connection.close();
		throw err;
	}
};


service.updateMapaPlanta =
async function(id, object, nmUsuarioAtual, dtAtual)
{
	let connection = await oracledb.getConnection(dbConfig);
	let mapaPlantaDao = new MapaPlantaDao(connection);
	try
	{
		let res = await mapaPlantaDao.merge(id, object, nmUsuarioAtual, dtAtual);
		await connection.commit();
		await connection.close();
		return res;
	}
	catch(err)
	{
		await connection.close();
		throw err;
	}
};

service.createMapaPlanta =
async function(object, nmUsuarioAtual, dtAtual)
{
	let connection = await oracledb.getConnection(dbConfig);
	let mapaPlantaDao = new MapaPlantaDao(connection);
	try
	{
		let res = await mapaPlantaDao.merge(null, object, nmUsuarioAtual, dtAtual);
		await connection.commit();
		await connection.close();
		return res;
	}
	catch(err)
	{
		await connection.close();
		throw err;
	}
};

module.exports = service;
