--------------------------------------------------------
--  DDL for DB Link GA_SIT4_NETSMS_SUL.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT4_NETSMS_SUL.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISUL66F)))';
