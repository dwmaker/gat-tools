--------------------------------------------------------
--  DDL for DB Link GA_SIT1_NETSMS_ISP.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT1_NETSMS_ISP.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SISPHP)))';
