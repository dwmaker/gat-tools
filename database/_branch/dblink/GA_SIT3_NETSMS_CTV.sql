--------------------------------------------------------
--  DDL for DB Link GA_SIT3_NETSMS_CTV.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT3_NETSMS_CTV.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SCTV1MG)))';
