--------------------------------------------------------
--  DDL for DB Link GA_PROD_NETSMS_CTV.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_PROD_NETSMS_CTV.NET"
   CONNECT TO "S_T6720353" IDENTIFIED BY t_6720353
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=5.16.8.133)(Port=1528))(CONNECT_DATA=(SID=ctv)))';
