"use strict";
const fs = require('fs');
const path = require('path');

let service = {};

service.listAsmdisks = 
function(datasourceCode)
{
	return new Promise((resolve, reject) =>
	{
		fs.readFile(path.join("data", 'asmdisk-data-' + datasourceCode + '.json'), {encoding: "latin1"}, (err, data) => 
		{
			if (err) return reject(new INTERNAL_SERVER_ERROR({internalError: err}));
			try
			{
				let json = JSON.parse(data);
				resolve(json);
			}
			catch(err)
			{
				reject(new INTERNAL_SERVER_ERROR({internalError: err}));
			}
		});
	});
};

module.exports = service;




	
