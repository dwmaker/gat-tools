'use strict';
const fs = require('fs');
const path = require('path');

function DatasourceDAO()
{
	this.list = 
	function(param)
	{
		return new Promise((resolve, reject) =>
		{
			fs.readFile(path.join("data", `datasource-data.json`), {encoding: "utf8"}, (err, data) => 
			{
				if (err) return reject(err);
				try
				{
					let json = JSON.parse(data);
					if(typeof param.type            == "string") json = json.filter(val => param.type == val.type)
					if(typeof param.applicationCode == "string") json = json.filter(val => param.applicationCode == val.applicationCode)
					resolve(json);
				}
				catch(err)
				{
					reject(err);
				}
			});
		});
	};
};

module.exports = DatasourceDAO;
