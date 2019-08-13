'use strict';
'use strict';
const fs = require('fs');
const path = require('path');

function EnvironmentDAO()
{
	this.list = 
	function(filter)
	{
		return new Promise((resolve, reject) =>
		{
			fs.readFile(path.join("data", `environment-data.json`), {encoding: "utf8"}, (err, data) => 
			{
				if (err) return reject({mensagem: "Dados não encontrados", conteudo: null});
				try
				{
					let json = JSON.parse(data);
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

module.exports = EnvironmentDAO;
