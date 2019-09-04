--------------------------------------------------------
--  DDL for DB Link GA_CERT_NETSMS_CTV.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_CERT_NETSMS_CTV.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.162)(PORT=1525)))(CONNECT_DATA=(SERVICE_NAME=HHCTV01)))';
