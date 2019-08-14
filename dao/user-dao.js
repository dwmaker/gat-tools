'use strict';
const fs = require("fs");
const path = require("path");

function UserDAO()
{
	let filename = path.join(__dirname, `../data/users-data.json`);
	this.find = (par) =>
	{
		return new Promise((resolve, reject)=>
		{
			fs.readFile(filename, {encoding: "utf8"}, (err, data) => 
			{
				if (err)
				{
					console.log(err)
					return reject({mensagem: "Dados não encontrados", conteudo: null});
				}
				try
				{
					let users = JSON.parse(data);
					if(typeof par.id != 'undefined') users = users.filter(item => item.id == par.id);
					if(users.length==0) return reject("no data found");
					if(users.length>1) return reject("too many rows")
					return resolve(users[0]);
				}
				catch(err)
				{
					console.log(err)
					reject({mensagem: "Dados Corrompidos", conteudo: data});
				}
			});
		});
	};
};

module.exports = UserDAO;