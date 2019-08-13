'use strict';
'use strict';
const fs = require('fs');
const path = require('path');

function CenarioDAO()
{
	this.list = 
	function(filter)
	{
		return new Promise((resolve, reject) =>
		{
			fs.readFile(path.join("data", `cenario-data.json`), {encoding: "utf8"}, (err, data) => 
			{
				if (err) return reject({mensagem: "Dados não encontrados", conteudo: null});
				try
				{
					let json = JSON.parse(data);
					if (typeof filter.applicationCode == "string") json = json.filter(cen =>cen.applicationCode == filter.applicationCode)
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

module.exports = CenarioDAO;
