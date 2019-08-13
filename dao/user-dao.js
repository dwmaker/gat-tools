'use strict';

let users = 
[
	{displayName:"Paulo Ponciano", userId: 500, access:[ "get:datasource", "write:datasource", "search:datasource", "delete:datasource" ]}
]

let UserDAO = {};

UserDAO.get = (par) =>
{
	return new Promise((resolve, reject)=>
	{
		let result = users.filter(users => users.userId == par.userId);
		if(result.length==0) return reject("no data found");
		if(result.length>1) return reject("too many rows")
		return resolve(result[0]);
	})
}


module.exports = UserDAO;