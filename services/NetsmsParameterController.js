'use strict';
const fs = require('fs');
const path = require('path');

let service = {};

service.listNetsmsParameter = 
function(datasourceCode)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join("data", `netsms_parameter-data-${datasourceCode}.json`), {encoding: "latin1"}, (err, data) => 
		{
			if (err) reject(err);
			try
			{
				let json = JSON.parse(data);
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






	

	