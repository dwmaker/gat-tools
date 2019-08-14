'use strict';
// @CodeGeneratorOverwrite: enabled
const express = require('express');
const morgan = require('morgan');
const DatasourceController = require("./controllers/DatasourceController.js");
const ApplicationController = require("./controllers/ApplicationController.js");
const NetsmsVersionController = require("./controllers/NetsmsVersionController.js");
const NetsmsParameterController = require("./controllers/NetsmsParameterController.js");
const Profile = require("./controllers/Profile.js");
const AccesscontrolController = require("./controllers/AccesscontrolController.js");
const AsmController = require("./controllers/AsmController.js");
const ReportNetsmsParameterController = require("./controllers/report-netsms-parameters-controller.js");
let router = express.Router();
router.use(morgan('dev'));
 
router.get("/datasources", DatasourceController.listDatasources );
router.get("/datasources/:datasourceCode", DatasourceController.getDatasource ); 
router.put("/datasources/:datasourceCode", DatasourceController.updateDatasource ); 
router.post("/datasources", DatasourceController.createDatasource );
router.delete("/datasources/:datasourceCode", DatasourceController.deleteDatasource ); 

router.get("/applications", ApplicationController.listApplications ); 
router.get("/cenarios", ApplicationController.listCenarios ); 
router.get("/environments", ApplicationController.listEnvironments ); 
router.get("/netsms-version/:datasourceCode", NetsmsVersionController.listNetsmsVersion ); 
router.get("/netsms-parameter/:datasourceCode", NetsmsParameterController.listNetsmsParameter ); 
router.get("/profile",  Profile.getProfile ); 
router.get("/accesscontrols/:datasourceCode", AccesscontrolController.listAccesscontrols ); 
router.get("/asm-disks/:datasourceCode", AsmController.listAsmdisks );
router.get("/report-netsms-parameters", ReportNetsmsParameterController.reportNetsmsParameters);

module.exports = router;