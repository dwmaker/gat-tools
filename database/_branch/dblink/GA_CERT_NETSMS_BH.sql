--------------------------------------------------------
--  DDL for DB Link GA_CERT_NETSMS_BH.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_CERT_NETSMS_BH.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.165)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=hhbhn1)))';
