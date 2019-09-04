--------------------------------------------------------
--  DDL for DB Link GA_SIT8_NETSMS_BRA.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT8_NETSMS_BRA.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.166)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRASP1)))';
