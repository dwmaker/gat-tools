'use strict';
'use strict';
const fs = require('fs');
const path = require('path');

function NetsmsparameterDAO(datasourceCode)
{
	this.list = 
	function(filter)
	{
		return new Promise((resolve, reject) =>
		{
			fs.readFile(path.join("data", `netsms_parameter-data-${datasourceCode}.json`), {encoding: "latin1"}, (err, data) => 
			{
				if (err) return reject({mensagem: "Dados não encontrados", conteudo: null});
				try
				{
					let json = JSON.parse(data);
					if(typeof filter.type            == "string") json = json.filter(val => filter.type == val.type)
					if(typeof filter.applicationCode == "string") json = json.filter(val => filter.applicationCode == val.applicationCode)
					resolve(json);
				}
				catch(err)
				{
					reject({mensagem: "Dados Corrompidos", conteudo: data});
				}
			});
		});
	};
};

module.exports = NetsmsparameterDAO;
