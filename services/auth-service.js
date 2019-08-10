'use strict';
const passport = require("passport");
const BasicStrategy = require('passport-http').BasicStrategy;
const loginDAO = require("../dao/login-dao.js");
let service = {};

let users = [{displayName:"Paulo Ponciano", userId: 500, access:[ "get:datasource", "write:datasource", "search:datasource", "delete:datasource" ]}]

let UserDAO = 
{
	get: (par) =>
	{
		return new Promise((resolve, reject)=>
		{
			let result = users.filter(users => users.userId == par.userId);
			if(result.length==0) return reject("no data found");
			if(result.length>1) return reject("too many rows")
			return resolve(result[0]);
		})
	}
}

passport.use(new BasicStrategy(
	function(username, password, callback) 
	{
		loginDAO.get({ username: username })
		.then((login)=>
		{
			if (!login) { return callback('Invalid Credentials', undefined); }
			if (login.password != password)
			{
				return callback('Invalid password', undefined);
			}
			
			UserDAO.get({ userId: login.userId })
			.then((user)=>
			{
				return callback(undefined, user);
			})
			.catch((err)=>
			{
				return callback(err, undefined);
			})
		})
		.catch((err)=>
		{
			return callback(err, undefined);
		})
	}
));
service.passport = passport
module.exports = service;