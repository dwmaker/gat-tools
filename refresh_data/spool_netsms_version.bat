@CHCP 1252>nul
@set script=%~dp0.\%~n0.sql

del "%~dp0.\..\data\netsms_version-data-*.json"

@REM @call :makefile "C:\gat\gat_tools\refresh_data\.\..\data\netsms_version-data-GA_SIT7_NETSMS_SUL.json"  "@C:\gat\gat_tools\refresh_data\spool_netsms_version.sql" 
@REM sqlplus -s -l "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SULTOA)))"
@rem "@C:\gat\gat_tools\refresh_data\spool_netsms_version.sql"



@call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_ABC.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.195)(PORT=1521)))(CONNECT_DATA=(SID=abc)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_SUL.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.193)(PORT=1521))(CONNECT_DATA=(SID=sul)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_SAO.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.84)(PORT=1521))(CONNECT_DATA=(SID=spo)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_BH.json"  "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.190)(PORT=1521))(CONNECT_DATA=(SID=bhpr)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_CTV.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=5.16.8.133)(Port=1528))(CONNECT_DATA=(SID=ctv)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_BRA.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.187)(PORT=1521))(CONNECT_DATA=(SID=db09)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_ISP.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.189)(PORT=1521))(CONNECT_DATA=(SID=isp)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_PROD_NETSMS_SOC.json" "S_T6720353/t_6720353@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.191)(PORT=1521))(CONNECT_DATA=(SID=db09s)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_ATLAS.json"      "FTAPP/FTAPP@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=HHATL01)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_SOC.json" "prod_jd/HHSOCN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsocn1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_SUL.json" "prod_jd/HHSULN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsuln1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_SAO.json" "prod_jd/HHSPON1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhspon1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_ISP.json" "prod_jd/HHISPN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SID=hhispn1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_BRA.json" "prod_jd/HHDB09N1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhdb09n1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_ABC.json" "prod_jd/HHBRIN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhbrin1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_BH.json"  "prod_jd/HHBHN1_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.165)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=hhbhn1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_CERT_NETSMS_CTV.json" "prod_jd/HHCTV01_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.162)(PORT=1525)))(CONNECT_DATA=(SERVICE_NAME=HHCTV01)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV1_NETSMS_BH.json"  "prod_jd/DBHHP_XPTO_PROD_JD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBHHP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV1_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DCTV1HP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV1_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DISPHP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV1_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRIHP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV4_NETSMS_BH.json"  "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SID=DDBH13F)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV4_NETSMS_ABC.json" "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SID=DDABC13F)(SERVER=DEDICATED)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV4_NETSMS_SUL.json" "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SERVICE_NAME=DDSUL11F)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_DEV4_NETSMS_ISP.json" "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=MUCISP01)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT1_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SBHHP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT1_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SISPHP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT1_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRIHP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT2_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBHSP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT2_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SISPSP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT2_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRISP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT3_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SISP3SP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT3_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRI3SP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT3_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBH3SP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT3_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SCTV1MG)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIISP02F)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_BRA.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBRA03F)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_SUL.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISUL66F)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBHPV1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT4_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLE2)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_SUL.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISULPV1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLD1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIABC02F)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_SOC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=BIGT)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBH03F)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT5_NETSMS_SAO.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISP03F)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT6_NETSMS_SUL.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.31)(PORT=1521))(CONNECT_DATA=(SID=SULST)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_SAO.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SPOSAMX)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_BRA.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRASAMX)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_BH.json"  "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BHSAMX)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=ISPSAMX)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_CTV.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=dbri1ctv)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRISAMX)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_SUL.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SULTOA)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT7_NETSMS_SOC.json" "prod_jd/prod_jd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SOCSAMX1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT8_NETSMS_BH.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBHSP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT8_NETSMS_ABC.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRISP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT8_NETSMS_BRA.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.166)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRASP1)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_SIT8_NETSMS_ISP.json" "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DISPSP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_UAT_NETSMS_BH.json"   "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBH)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_UAT_NETSMS_ABC.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBRI)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_UAT_NETSMS_ISP.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVISP)))"
@call :makefile "%~dp0.\..\data\netsms_version-data-GA_UAT_NETSMS_CTV.json"  "prod_jd/f0brika@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATCTV)))"
@goto :sucesso

:makefile
@echo * %~nx1 
@if exist "%~dp1~%~nx1" @del "%~dp1~%~nx1"
@sqlplus -s -l %2 "@%~dpn0.sql" > "%~dp1~%~nx1"
@if errorlevel 1 @type "%~dp1~%~nx1"
@if exist "%~dpnx1" @del "%~dpnx1"
@ren "%~dp1~%~nx1" "%~nx1"
@goto :eof

:sucesso
@exit /b 0

:falha
@exit /b 1