--------------------------------------------------------
--  DDL for DB Link GA_SIT1_NETSMS_BH.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT1_NETSMS_BH.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SID=SBHHP)))';
