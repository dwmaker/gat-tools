--------------------------------------------------------
--  DDL for DB Link GA_PROD_NETSMS_CTV.NET
--------------------------------------------------------

  CREATE DATABASE LINK "GA_PROD_NETSMS_CTV.NET"
   CONNECT TO "NETDBA" IDENTIFIED BY VALUES '056384D8729E1770DCE09872A5010D76DEEB04031477677850'
   USING '(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(host = 5.16.8.133)(PORT = 1528))(CONNECT_DATA = (SID = CTV)))';