'use strict';
// @CodeGeneratorOverwrite: enabled
const express = require('express');
const morgan = require('morgan');
const DatasourceController = require("./controllers/DatasourceController.js");
const ApplicationController = require("./controllers/ApplicationController.js");
const NetsmsVersionController = require("./controllers/NetsmsVersionController.js");
const NetsmsParameterController = require("./controllers/NetsmsParameterController.js");
const Authentication = require("./controllers/Authentication.js");
const AccesscontrolController = require("./controllers/AccesscontrolController.js");
const AsmController = require("./controllers/AsmController.js");
const ReportNetsmsParameterController = require("./controllers/report-netsms-parameters-controller.js");
let router = express.Router();
router.use(morgan('dev'));
 
router.get("/datasources", Authentication.basicAuth(["search:datasource"]), DatasourceController.listDatasources ); 
router.get("/applications", ApplicationController.listApplications ); 
router.get("/netsms-version/:datasourceCode", NetsmsVersionController.listNetsmsVersion ); 
router.get("/netsms-parameter/:datasourceCode", NetsmsParameterController.listNetsmsParameter ); 
router.get("/cenarios", ApplicationController.listCenarios ); 
router.get("/profile", Authentication.basicAuth([]), Authentication.getProfile ); 
router.get("/environments", ApplicationController.listEnvironments ); 
router.get("/accesscontrols/:datasourceCode", AccesscontrolController.listAccesscontrols ); 
router.get("/asm-disks/:datasourceCode", AsmController.listAsmdisks );
router.get("/report-netsms-parameters", ReportNetsmsParameterController.reportNetsmsParameters);

module.exports = router;