'use strict';
const fs = require('fs');
const path = require('path');

module.exports = {};

module.exports.getDatasources =  (req, res, next) =>
{
	let param = {"type": req.query.type};
	fs.readFile(path.join("data", 'datasource-data-'+param.type+'.json'), (err, data) => 
	{
		if (err)
		{
			next(err);
		}
		else
		{
			try
			{
				let json = JSON.parse(data);
				res.send(json);
			}
			catch(err)
			{
				next(err);
			}
		}
	});
};

module.exports.getAsmdisks = (req, res, next) =>
{
	let param = {};
	param.datasourceCode = req.query.datasourceCode;

	fs.readFile(path.join("data", 'asmdisk-data-' + param.datasourceCode + '.json'), (err, data) => 
	{
		if (err)
		{
			next(err);
		}
		else
		{
			try
			{
				let json = JSON.parse(data);
				res.send(json);
			}
			catch(err)
			{
				next(err);
			}
		}
	});
};

