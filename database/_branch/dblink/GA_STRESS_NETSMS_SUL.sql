--------------------------------------------------------
--  DDL for DB Link GA_SIT6_NETSMS_SUL.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_STRESS_NETSMS_SUL.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.31)(PORT=1521))(CONNECT_DATA=(SID=SULST)))';
