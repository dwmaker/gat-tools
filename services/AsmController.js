'use strict';
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
			if (err) return reject(err);
			try
			{
				let json = JSON.parse(data);
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




	
