--------------------------------------------------------
--  DDL for DB Link GA_PROD_NETSMS_BRA.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_PROD_NETSMS_BRA.NET"
   CONNECT TO "S_T6720353" IDENTIFIED BY t_6720353
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.187)(PORT=1521))(CONNECT_DATA=(SID=db09)))';
