--------------------------------------------------------
--  DDL for DB Link GA_DEV4_NETSMS_SUL.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_DEV4_NETSMS_SUL.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SERVICE_NAME=DDSUL11F)))';
