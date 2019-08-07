'use strict';
const fs = require('fs');
const path = require('path');

let service = {};

service.listDatasources = 
function(type, applicationCode)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join("data", `datasource-data-${type}.json`), (err, data) => 
		{
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
				if(typeof applicationCode == "string") json = json.filter(val => applicationCode == val.applicationCode)
				resolve(json);
			}
			catch(err)
			{
				reject(err);
			}
		});
	});
};

module.exports = service;
