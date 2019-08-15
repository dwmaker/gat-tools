"use strict";
const fs = require('fs');
const path = require('path');

let service = {};

service.listDatasources = 
function(type, applicationCode)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join(__dirname, `../data/datasource-data.json`), {encoding: "utf8"}, (err, data) => 
		{
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
				if(typeof type            == "string") json = json.filter(val => type == val.type)
				if(typeof applicationCode == "string") json = json.filter(val => applicationCode == val.applicationCode)
				return resolve(json);
			}
			catch(err)
			{
				return reject(err);
			}
		});
	});
};

service.getDatasource =
function(code)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join(__dirname, `../data/datasource-data.json`), {encoding: "utf8"}, (err, data) => 
		{
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
				if(typeof code == "string") json = json.filter(val => code == val.code);
				if(json.length==0) reject('NO_DATA_FOUND');
				if(json.length>1) reject('TOO_MANY_ROWS');
				resolve(json[0]);
			}
			catch(err)
			{
				reject(err);
			}
		});
	});
};

service.deleteDatasource =
function(code)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join(__dirname, `../data/datasource-data.json`), {encoding: "utf8"}, (err, data) => 
		{
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
				let ix = json.map(ds=>ds.code).indexOf(code);
				if(ix < 0) return reject('NO_DATA_FOUND');
				json.splice(ix,1);
				fs.writeFile(path.join(__dirname, `../data/datasource-data.json`), JSON.stringify(json,null,4), {encoding: "utf8"}, (err, data) => 
				{
					if (err) return reject(err);
					return resolve();
				})
			}
			catch(err)
			{
				reject(err);
			}
		});
	});
};


service.updateDatasource =
function(code, datasource)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join(__dirname, `../data/datasource-data.json`), {encoding: "utf8"}, (err, data) => 
		{
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
				let ix = json.map(ds=>ds.code).indexOf(code);
				if(ix < 0) return reject('NO_DATA_FOUND');
				json[ix] = datasource;
				fs.writeFile(path.join(__dirname, `../data/datasource-data.json`), JSON.stringify(json,null,4), {encoding: "utf8"}, (err, data) => 
				{
					if (err) return reject(err);
					return resolve();
				})
			}
			catch(err)
			{
				reject(err);
			}
		});
	});
};

service.createDatasource =
function(datasource)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join(__dirname, `../data/datasource-data.json`), {encoding: "utf8"}, (err, data) => 
		{
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
				json.push(datasource);
				fs.writeFile(path.join(__dirname, `../data/datasource-data.json`), JSON.stringify(json,null,4), {encoding: "utf8"}, (err, data) => 
				{
					if (err) return reject(err);
					return resolve(datasource);
				})
			}
			catch(err)
			{
				reject(err);
			}
		});
	});
};

module.exports = service;
