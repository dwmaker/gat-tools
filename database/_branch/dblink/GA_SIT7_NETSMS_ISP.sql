--------------------------------------------------------
--  DDL for DB Link GA_SIT7_NETSMS_ISP.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT7_NETSMS_ISP.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=ISPSAMX)))';
