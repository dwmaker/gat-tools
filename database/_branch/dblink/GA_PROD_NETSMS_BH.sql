--------------------------------------------------------
--  DDL for DB Link GA_PROD_NETSMS_BH.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_PROD_NETSMS_BH.NET"
   CONNECT TO "S_T6720353" IDENTIFIED BY t_6720353
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.190)(PORT=1521))(CONNECT_DATA=(SID=bhpr)))';
