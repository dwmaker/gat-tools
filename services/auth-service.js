'use strict';
const passport = require("passport");
const BasicStrategy = require('passport-http').BasicStrategy;

let service = {};


let logins = [{username:"paulo", password:"teste"}]
let users  = [{username:"paulo", access:["read:datasource","write:datasource"]}]
let LoginDAO = 
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
		LoginDAO.get({ username: username })
		.then((login)=>
		{
			if (!login) { return callback(null, false); }
			if (login.password != password)
			{
				return callback('Invalid passow', false);
			}
			
			UserDAO.get({ username: login.username })
			.then((user)=>
			{
				return callback(null, user);
			})
			.catch((err)=>
			{
				return callback(err);
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