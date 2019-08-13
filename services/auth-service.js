'use strict';
const passport = require("passport");
const BasicStrategy = require('passport-http').BasicStrategy;
const loginDAO = require("../dao/login-dao.js");
const userDAO = require("../dao/user-dao.js");
let service = {};

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
			
			userDAO.get({ userId: login.userId })
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