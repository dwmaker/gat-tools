"use strict";
let securityschemas = {};
securityschemas.basicAuth = require("./basicAuth");
securityschemas.bearerAuth = require("./bearerAuth");
module.exports = securityschemas;