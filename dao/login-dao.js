'use strict';
let logins = 
[
	{username:"paulo", password: "teste", userId: 500},
	{username:"paulo.ponciano@spread.com.br", password: "teste", userId: 500}
];

let loginDAO = {};

loginDAO.get = function(par)
{
	return new Promise((resolve, reject)=>
	{
		let result = logins.filter(login => login.username == par.username);
		if(result.length==0) return reject("no data found")
		return resolve(result[0]);
	})
}

module.exports = loginDAO;

