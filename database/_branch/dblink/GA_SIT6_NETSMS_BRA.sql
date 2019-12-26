--------------------------------------------------------
--  DDL for DB Link GA_SIT6_NETSMS_BRA.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT6_NETSMS_BRA.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.27)(PORT=1521))(CONNECT_DATA=(SID=SIT06)))';
