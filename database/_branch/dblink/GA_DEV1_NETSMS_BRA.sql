--------------------------------------------------------
--  DDL for DB Link GA_DEV1_NETSMS_BRA.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_DEV1_NETSMS_BRA.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.157)(PORT=1521))(CONNECT_DATA=(service_name=dev01)))';
