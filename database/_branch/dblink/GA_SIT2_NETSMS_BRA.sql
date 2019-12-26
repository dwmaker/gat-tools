--------------------------------------------------------
--  DDL for DB Link GA_SIT2_NETSMS_BRA.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT2_NETSMS_BRA.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1521))(CONNECT_DATA=(SID=SIT02)))';
