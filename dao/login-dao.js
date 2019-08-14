'use strict';
const fs = require("fs");
const path = require("path");

function LoginDAO()
{
	let filename = path.join(__dirname, `../data/logins-data.json`);
	this.find = (param) =>
	{
		return new Promise((resolve, reject)=>
		{
			fs.readFile(filename, {encoding: "utf8"}, (err, data) => 
			{
				if (err)
				{
					//console.log(err)
					throw err;
					return reject("INTERNAL_ERROR");
				}
				try
				{
					let logins = JSON.parse(data);
					if(typeof param.username !== 'undefined') logins = logins.filter(login => login.username == param.username);
					if(logins.length==0) return reject("NO_DATA_FOUND");
					if(logins.length>1) return reject("TOO_MANY_ROWS")
					return resolve(logins[0]);
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




module.exports = LoginDAO;