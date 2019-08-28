"use strict";
const passport = require("passport");
const BasicStrategy = require('passport-http').BasicStrategy;
const {UNAUTHORIZED, INVALID_CREDENTIALS, INVALID_USER_ENTRY, NO_DATA_FOUND} = require("../errors");
const LoginDAO = require("../dao/login-dao.js");
const UserDAO = require("../dao/user-dao.js");
let schema = {};



schema.strategy = 
new BasicStrategy(
	function(username, password, callback) 
	{
		let loginDAO = new LoginDAO();
		let userDAO = new UserDAO();
		loginDAO.find({ username: username })
		.then((login)=>
		{
			
			if (!login) 
			{
				return callback(new INVALID_USER_ENTRY(), undefined); 
			}	
			if (login.password != password)
			{
				
				return callback(new INVALID_CREDENTIALS(), undefined);
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
			
			if(err instanceof NO_DATA_FOUND)
			{
				return callback(new INVALID_CREDENTIALS({err}), undefined);
			}
			else
			{
				return callback(err, undefined);
			}
		})
	}
);

schema.authenticate = function (req)
{
	return new Promise((resolve, reject) =>
	{
		passport.authenticate('basicAuth', { session: false }, function(error, user, info)
		{
			if(error) return reject(error);
			if(typeof user != 'object') return reject(new UNAUTHORIZED());
			return resolve(user);
		})(req)
	})
};

module.exports = schema;