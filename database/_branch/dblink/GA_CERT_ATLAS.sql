--------------------------------------------------------
--  DDL for DB Link GA_CERT_ATLAS.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_CERT_ATLAS.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=HHATL01)))';
