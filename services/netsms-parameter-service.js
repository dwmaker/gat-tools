"use strict";
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
			if (err) return reject(err.toString());
			try
			{
				return resolve(JSON.parse(data));
			}
			catch(err)
			{
				return reject({"internal-error": data.toString()});
			};
			
		});
	});
};

module.exports = service;






	

	