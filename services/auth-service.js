'use strict';
const passport = require("passport");
const BasicStrategy = require('passport-http').BasicStrategy;
const LoginDao = require("../dao/login-dao.js");
let service = {};

let logins = [{username:"paulo", password: "teste"}]
let users  = [{username:"paulo", access:[ "get:datasource", "write:datasource", "search:datasource", "delete:datasource" ]}]
let loginDAO = 
{
	get: (par) =>
	{
		return new Promise((resolve, reject)=>
		{
			let result = logins.filter(login => login.username == par.username);
			if(result.length==0) return reject("no data found")
			return resolve(result[0]);
		})
	}
}
let UserDAO = 
{
	get: (par) =>
	{
		return new Promise((resolve, reject)=>
		{
			let result = users.filter(users => users.username == par.username);
			if(result.length==0) return reject("no data found")
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
			
			UserDAO.get({ username: login.username })
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
			return callback(err);
		})
	}
));
service.passport = passport
module.exports = service;