'use strict';
let logins = [{username:"paulo", password: "teste"}]

function DAO(connection)
{
	this.connection = connection;
	this.get = (par) =>
	{
		return new Promise((resolve, reject)=>
		{
			let result = logins.filter(login => login.username == par.username);
			if(result.length==0) return reject("no data found")
			return resolve(result[0]);
		})
	}
};

module.exports = DAO;

