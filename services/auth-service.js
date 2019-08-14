'use strict';
const passport = require("passport");
const BasicStrategy = require('passport-http').BasicStrategy;
const LoginDAO = require("../dao/login-dao.js");
const UserDAO = require("../dao/user-dao.js");
let service = {};
let loginDAO = new LoginDAO();
let userDAO = new UserDAO();

passport.use('basicAuth', new BasicStrategy(
	function(username, password, callback) 
	{
		loginDAO.find({ username: username })
		.then((login)=>
		{
			if (!login) 
			{
				return callback('INVALID_USER_ENTRY', undefined); 
			}	
			if (login.password != password)
			{
				return callback('INVALID_CREDENTIALS', undefined);
			}
			userDAO.find({ id: login.userId })
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
			if(err == "NO_DATA_FOUND")
			{
				return callback("INVALID_CREDENTIALS", undefined);
			}
			else
			{
				return callback(err, undefined);
			}
		})
	}
));

service.basicAuth = function (req)
{
	return new Promise((resolve, reject) =>
	{
		passport.authenticate('basicAuth', { session: false }, function(error, user, info)
		{
			if(error) return reject(error);
			if(typeof user != 'object') return reject("UNAUTHORIZED");
			return resolve(user);
		})(req)
	})
};

module.exports = service;