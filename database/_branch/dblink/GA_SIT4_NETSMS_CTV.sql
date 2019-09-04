--------------------------------------------------------
--  DDL for DB Link GA_SIT4_NETSMS_CTV.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT4_NETSMS_CTV.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLE2)))';
