--------------------------------------------------------
--  DDL for DB Link GA_SIT5_NETSMS_SAO.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT5_NETSMS_SAO.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISP03F)))';
