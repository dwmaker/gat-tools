'use strict';
const fs = require('fs');
const path = require('path');

let service = {};

service.listNetsmsVersion = 
function(datasourceCode)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join("data", 'netsms_version-data-' + datasourceCode +'.json'), {encoding: "latin1"}, (err, data) => 
		{
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
				if (typeof type === 'string') json = json.filter(row => row.type == type);
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


	
