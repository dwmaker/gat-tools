--------------------------------------------------------
--  DDL for DB Link GA_SIT7_NETSMS_CTV.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT7_NETSMS_CTV.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=dbri1ctv)))';
