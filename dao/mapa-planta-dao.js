'use strict';
const fs = require('fs');
const path = require('path');
const oracledb = require('oracledb');
const {NO_DATA_FOUND, INTERNAL_SERVER_ERROR} = require("../errors");

function Dao(connection)
{
	this.connection = connection;
	
	this.list = async function(filtro)
	{
		let statement = "";
		let parameters =
		{
			cursor: { dir: oracledb.BIND_OUT, type: oracledb.CURSOR}
		};
		let iPar=0;
		function param(val)
		{
			iPar++;
			parameters["inject" + iPar] = { dir: oracledb.BIND_IN, type:(val instanceof Date)?oracledb.DATE:(typeof val === "number")?oracledb.NUMBER:oracledb.STRING, val: val}
			return ":"+"inject" +iPar;
		};
		let options =
		{
			outFormat: oracledb.OUT_FORMAT_OBJECT 
		};
		statement += `DECLARE \n`;
		statement += `obj_filtro core.pkg_mapa.rec_filtro; \n`;
		statement += `BEGIN \n`;
		if(Array.isArray(filtro.tp_mapa_in))
		{
			for(let i in filtro.tp_mapa_in)
			{
				statement += `obj_filtro.tp_mapa_in(obj_filtro.tp_mapa_in.count) := ${param(filtro.tp_mapa_in[i])};`;
			}
		}
		statement += `:cursor := core.pkg_mapa.lst_mapa(obj_filtro); \n`;
		statement += `end; \n`
		let result;
		try
		{
			result = await connection.execute(statement, parameters, options);
		}
		catch(e)
		{
			throw new INTERNAL_SERVER_ERROR({statement:statement, parameters:parameters, options:options, message: e.message})
		}
		
		let saida = await result.outBinds.cursor.getRows(100);
		return saida;
	};
	
	this.merge = async function(id, object, nmUsuarioAtual, dtAtual)
	{
		let statement = "";
		let parameters =
		{
			object_str: { dir: oracledb.BIND_OUT, type:oracledb.STRING , maxSize:4000},
			id: { dir: oracledb.BIND_INOUT, type:oracledb.NUMBER, val: id}
		};
		let iPar=0;
		function param(val)
		{
			iPar++;
			parameters["inject" + iPar] = { dir: oracledb.BIND_IN, type:(val instanceof Date)?oracledb.DATE:(typeof val === "number")?oracledb.NUMBER:oracledb.STRING, val: val}
			return ":"+"inject" +iPar;
		}
		statement += `DECLARE \n`;
		statement += `object CORE.pkg_mapa.rec_mapa; \n`;
		statement += `BEGIN \n`;
		statement += `object.nome := ${param(object.nome)}; \n`;
		statement += `object.descricao := ${param(object.descricao)}; \n`;
		statement += `object.nr_versao := ${param(object.nr_versao)}; \n`;
		statement += `object.cd_ambiente := ${param(object.cd_ambiente)}; \n`;
		statement += `object.tp_mapa := ${param(object.tp_mapa)}; \n`;
		statement += `object.id_mapa_template := ${param(object.id_mapa_template)}; \n`;
		for (var cd_tecnologia in object.tecnologias)
		{
			let par_cd_tecnologia = param(cd_tecnologia)
			for (var cd_servidor in object.tecnologias[cd_tecnologia])
			{
				let par_cd_servidor = param(cd_servidor)
				let par_conexao = param(object.tecnologias[cd_tecnologia][cd_servidor].conexao)
				statement += `object.tecnologias(${par_cd_tecnologia})(${par_cd_servidor}).conexao := ${par_conexao}; \n`;
				for (var nm_usuario in object.tecnologias[cd_tecnologia][cd_servidor].usuarios)
				{
					let par_nm_usuario = param(nm_usuario);
					let par_senha = param(object.tecnologias[cd_tecnologia][cd_servidor].usuarios[nm_usuario]);
					statement += `object.tecnologias(${par_cd_tecnologia})(${par_cd_servidor}).usuarios(${par_nm_usuario}) := ${par_senha}; \n`;
				}
			}
		}
		statement += `CORE.pkg_mapa.mrg_mapa(:id, object, ${param(nmUsuarioAtual)}, ${param(dtAtual)}); \n`;
		statement += `:object_str := CORE.pkg_mapa.to_json(object); \n`;
		statement += `end; \n`;
		let result;
		result = await connection.execute(statement, parameters);
		id = result.outBinds.id;
		object = JSON.parse(result.outBinds.object_str);
		return {id, object};
	};
	
	this.get = async function(id)
	{
		let statement = "";
		let parameters =
		{
			object_str: { dir: oracledb.BIND_OUT, type:oracledb.STRING , maxSize:4000}
		};
		let options = {};
		let iPar=0;
		function param(val)
		{
			iPar++;
			parameters["inject" + iPar] = { dir: oracledb.BIND_IN, type:(val instanceof Date)?oracledb.DATE:(typeof val === "number")?oracledb.NUMBER:oracledb.STRING, val: val}
			return ":"+"inject" +iPar;
		}
		statement += `DECLARE \n`;
		statement += `object CORE.pkg_mapa.rec_mapa; \n`;
		statement += `BEGIN \n`;
		statement += `object := CORE.pkg_mapa.get_mapa(${param(id)}); \n`;
		statement += `:object_str := CORE.pkg_mapa.to_json(object); \n`;
		statement += `end; \n`
		let result;
		try
		{
			result	= await connection.execute(statement, parameters);
		}
		catch(err)
		{
			if(err.errorNum == 1403) throw new NO_DATA_FOUND({sqlErrorNum: err.errorNum, sqlMessage: err.message, sqlOffset: err.offset, sqlStatement: statement, sqlParameters: parameters, sqlOptions: options});
			throw err;
		}
		let object = JSON.parse(result.outBinds.object_str);
		return object;
	};
	
	this.delete = async function(id, nmUsuarioAtual, dtAtual)
	{
		let statement = "";
		let parameters = {};
		let iPar=0;
		function param(val)
		{
			iPar++;
			parameters["inject" + iPar] = { dir: oracledb.BIND_IN, type:(val instanceof Date)?oracledb.DATE:(typeof val === "number")?oracledb.NUMBER:oracledb.STRING, val: val}
			return ":"+"inject" +iPar;
		}
		statement += `BEGIN \n`;
		statement += `CORE.pkg_mapa.del_mapa(${param(id)}, ${param(nmUsuarioAtual)}, ${param(dtAtual)}); \n`;
		statement += `end; \n`
		let result;
		result	= await connection.execute(statement, parameters);
		return {id};
	};
};
module.exports = Dao;
