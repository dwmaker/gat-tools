--------------------------------------------------------
--  DDL for DB Link GA_SIT7_NETSMS_SOC.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_SIT7_NETSMS_SOC.NET"
   CONNECT TO "CORE" IDENTIFIED BY M4zzalli
   USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SOCSAMX1)))';
