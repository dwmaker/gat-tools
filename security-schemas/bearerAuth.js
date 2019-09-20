"use strict";
// const passport = require("passport");
const BearerStrategy = require('passport-http-bearer').Strategy;
const jwt = require('jwt-simple');
const SECRET = "M1-53cr3t-P@ssw0rd";
// const {UNAUTHORIZED, INVALID_CREDENTIALS, INVALID_USER_ENTRY, NO_DATA_FOUND} = require("../errors");
// const LoginDAO = require("../dao/login-dao.js");
// const UserDAO = require("../dao/user-dao.js");
let schema = {};

schema.strategy = 
new BearerStrategy((token, done) => {
	try {
		const { username } = jwt.decode(token, SECRET);
		if (username === "admin") {
			done(null, username);
			return;
		}
		done(null, false);
	} catch (error) {
		done(null, false);
	}
});

module.exports = schema;