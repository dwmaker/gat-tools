--------------------------------------------------------
--  DDL for DB Link GA_DEV4_NETSMS_ISP.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_DEV4_NETSMS_ISP.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=MUCISP01)))';
