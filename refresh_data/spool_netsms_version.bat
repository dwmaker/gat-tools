@set NLS_LANG=.AL32UTF8
@CHCP 1252>nul
@set nls_lang=american_america.we8mswin1252
@set script=%~dp0.\%~n0.sql
@REM del "%~dp0.\..\data\netsms_version-data-*.json"

@REM @call :makefile "C:\gat\gat_tools\refresh_data\.\..\data\netsms_version-data-GA_SIT7_NETSMS_SUL.json"  "@C:\gat\gat_tools\refresh_data\spool_netsms_version.sql" 
sqlplus -s -l "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SULTOA)))"
@rem "@C:\gat\gat_tools\refresh_data\spool_netsms_version.sql"



@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_ABC.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.195)(PORT=1521)))(CONNECT_DATA=(SID=abc)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_SUL.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.193)(PORT=1521))(CONNECT_DATA=(SID=sul)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_SAO.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.84)(PORT=1521))(CONNECT_DATA=(SID=spo)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_BH.json"  "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.190)(PORT=1521))(CONNECT_DATA=(SID=bhpr)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_CTV.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=5.16.8.133)(Port=1528))(CONNECT_DATA=(SID=ctv)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_BRA.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.187)(PORT=1521))(CONNECT_DATA=(SID=db09)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_ISP.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.189)(PORT=1521))(CONNECT_DATA=(SID=isp)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_SOC.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.191)(PORT=1521))(CONNECT_DATA=(SID=db09s)))"

@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_ATLAS.json"      "FTAPP/FTAPP@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=HHATL01)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_SOC.json" "prod_jd/HHSOCN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsocn1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_SUL.json" "prod_jd/HHSULN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsuln1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_SAO.json" "prod_jd/HHSPON1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhspon1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_ISP.json" "prod_jd/HHISPN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SID=hhispn1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_BRA.json" "prod_jd/HHDB09N1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhdb09n1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_ABC.json" "prod_jd/HHBRIN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhbrin1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_BH.json"  "prod_jd/HHBHN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.165)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=hhbhn1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_CTV.json" "prod_jd/HHCTV01_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.162)(PORT=1525)))(CONNECT_DATA=(SERVICE_NAME=HHCTV01)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV1_NETSMS_BH.json"  "prod_jd/DBHHP_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBHHP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV1_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DCTV1HP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV1_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DISPHP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV1_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRIHP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV4_NETSMS_BH.json"  "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SID=DDBH13F)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV4_NETSMS_ABC.json" "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SID=DDABC13F)(SERVER=DEDICATED)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV4_NETSMS_SUL.json" "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SERVICE_NAME=DDSUL11F)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV4_NETSMS_ISP.json" "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=MUCISP01)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT1_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SBHHP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT1_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SISPHP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT1_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRIHP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT2_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBHSP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT2_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SISPSP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT2_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRISP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT3_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SISP3SP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT3_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRI3SP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT3_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBH3SP)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT3_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SCTV1MG)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIISP02F)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_BRA.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBRA03F)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_SUL.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISUL66F)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBHPV1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLE2)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_SUL.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISULPV1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLD1)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIABC02F)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_SOC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=BIGT)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBH03F)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_SAO.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISP03F)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT6_NETSMS_SUL.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.31)(PORT=1521))(CONNECT_DATA=(SID=SULST)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_SAO.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SPOSAMX)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_BRA.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRASAMX)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_BH.json"  "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BHSAMX)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=ISPSAMX)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=dbri1ctv)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRISAMX)))"
@REm @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_SUL.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SULTOA)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_SOC.json" "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SOCSAMX1)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT8_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBHSP)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT8_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRISP)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT8_NETSMS_BRA.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.166)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRASP1)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT8_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DISPSP)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_UAT_NETSMS_BH.json"   "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBH)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_UAT_NETSMS_ABC.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBRI)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_UAT_NETSMS_ISP.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVISP)))"
@REM @call :makefile "%~dp0.\..\data\netsms_version-data-GA_UAT_NETSMS_CTV.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATCTV)))"
pause
goto :sucesso

@echo SET SERVEROUTPUT ON FORMAT TRUNCATED;
@echo set trimspool on;
@echo set linesize 10000;
@echo SET feedback off;

:makefile
@echo * %~nx1 
@if exist "%~dp1~%~nx1" @del "%~dp1~%~nx1"
sqlplus -s -l %2 "@%~dpn0.sql" > "%~dp1~%~nx1"
@if errorlevel 1 @type "%~dp1~%~nx1"
@if exist "%~dpnx1" @del "%~dpnx1"
@ren "%~dp1~%~nx1" "%~nx1"
@goto :eof

:sucesso
@exit /b 0

:falha
@exit /b 1