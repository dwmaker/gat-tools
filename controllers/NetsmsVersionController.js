'use strict';
const fs = require('fs');
const path = require('path');

module.exports = {};

module.exports.getNetsmsVersion =  (req, res, next) =>
{
	let param = {"datasourceCode": req.query.datasourceCode, "type": req.query.type};
	fs.readFile(path.join("data", 'netsms_version-data-' + param.datasourceCode +'.json'), (err, data) => 
	{
		if (err)
		{
			console.error(err)
			return res.status(404).send({"internal-error": err.toString()});
		}
		else
		{
			let json;
			try
			{
				json = JSON.parse(data);
				if (typeof param.type === 'string') json = json.filter((row)=>{ return (row.type == param.type)});
				return res.status(200).send(json);
			}
			catch(err)
			{
				return res.status(500).send({"internal-error": data.toString()});
			}
		}
	});
};
