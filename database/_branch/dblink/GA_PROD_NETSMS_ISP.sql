--------------------------------------------------------
--  DDL for DB Link GA_PROD_NETSMS_ISP.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_PROD_NETSMS_ISP.NET"
   CONNECT TO "NETBKPADM" IDENTIFIED BY VALUES '05F303B2ECB79F997F87AE73367E3E7EC6B0A5B22BDE6C5DC2'
   USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.189)(PORT=1521))(CONNECT_DATA=(SID=isp)))';
