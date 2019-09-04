--------------------------------------------------------
--  DDL for DB Link GA_CERT_NETSMS_ISP.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_CERT_NETSMS_ISP.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SID=hhispn1)))';
