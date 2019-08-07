'use strict';
// @CodeGeneratorOverwrite: enabled
const express = require('express');
const DatasourceController = require("./controllers/DatasourceController.js");
const ApplicationController = require("./controllers/ApplicationController.js");
const NetsmsVersionController = require("./controllers/NetsmsVersionController.js");
const NetsmsParameterController = require("./controllers/NetsmsParameterController.js");
const AccesscontrolController = require("./controllers/AccesscontrolController.js");
const AsmController = require("./controllers/AsmController.js");
let router = express.Router();

 
router.get("/datasources", DatasourceController.listDatasources ); 
router.get("/applications", ApplicationController.listApplications ); 
router.get("/netsms-version/:datasourceCode", NetsmsVersionController.listNetsmsVersion ); 
router.get("/netsms-parameter/:datasourceCode", NetsmsParameterController.listNetsmsParameter ); 
router.get("/cenarios", ApplicationController.listCenarios ); 
router.get("/environments", ApplicationController.listEnvironments ); 
router.get("/accesscontrols/:datasourceCode", AccesscontrolController.listAccesscontrols ); 
router.get("/asm-disks/:datasourceCode", AsmController.listAsmdisks );




module.exports = router;