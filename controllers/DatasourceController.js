'use strict';
const fs = require('fs');
const path = require('path');

module.exports = {};

module.exports.getDatasources =  (req, res, next) =>
{
	let param = 
	{
		"type": req.query.type, 
		"applicationCode": req.query.applicationCode
	};
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
				if(param.applicationCode) json=json.filter(
				(val)=>
				{
					return param.applicationCode == val.applicationCode
				})
				res.send(json);
			}
			catch(err)
			{
				next(err);
			}
		}
	});
};

