--------------------------------------------------------
--  DDL for DB Link GA_PROD_NETSMS_ABC.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_PROD_NETSMS_ABC.NET"
   CONNECT TO "S_T6720353" IDENTIFIED BY t_6720353
   USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.195)(PORT=1521)))(CONNECT_DATA=(SID=abc)))';
