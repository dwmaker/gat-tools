--------------------------------------------------------
--  DDL for DB Link GA_UAT_NETSMS_ABC.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_UAT_NETSMS_ABC.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBRI)))';
