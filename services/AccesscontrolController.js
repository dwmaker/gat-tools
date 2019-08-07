'use strict';
const fs = require('fs');
const path = require('path');

let service = {};

service.listAccesscontrols = 
function(datasourceCode, type)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join("data", `accesscontrol-data-${datasourceCode}.json`), (err, data) => 
		{
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
				if (typeof type === 'string') json = json.filter((row)=>{ return (row.type == type)});
				return resolve(json);
			}
			catch(err)
			{
				return reject({"internal-error": data.toString()});
			}
		});
	});
};

module.exports = service;
