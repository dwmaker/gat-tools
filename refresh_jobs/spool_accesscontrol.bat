@CHCP 1252>nul

del "%~dp0.\..\data\accesscontrol-metadata.json"
del "%~dp0.\..\data\accesscontrol-data-*.json"

@call :makemetadata "%~dp0.\..\data\accesscontrol-metadata.json" "dbanovosms/themask@ddad10g.world"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_ATLAS.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=HHATL01)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_NETSMS_SOC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsocn1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_NETSMS_SUL.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhsuln1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_NETSMS_SAO.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhspon1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.25)(PORT=1521))(CONNECT_DATA=(SID=hhispn1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_NETSMS_BRA.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhdb09n1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=hhbrin1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.165)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=hhbhn1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_CERT_NETSMS_CTV.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.16.8.162)(PORT=1525)))(CONNECT_DATA=(SERVICE_NAME=HHCTV01)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_DEV1_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBHHP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_DEV1_NETSMS_CTV.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DCTV1HP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_DEV1_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DISPHP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_DEV1_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRIHP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_DEV4_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SID=DDBH13F)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_DEV4_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SID=DDABC13F)(SERVER=DEDICATED)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_DEV4_NETSMS_SUL.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.14)(PORT=1523)))(CONNECT_DATA=(SERVICE_NAME=DDSUL11F)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_DEV4_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=MUCISP01)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT1_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRIHP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT1_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SBHHP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT1_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.28)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SISPHP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT2_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBHSP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT2_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SISPSP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT2_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRISP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT3_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SISP3SP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT3_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBRI3SP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT3_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SBH3SP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT3_NETSMS_CTV.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SID=SCTV1MG)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT4_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIISP02F)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT4_NETSMS_BRA.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBRA03F)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT4_NETSMS_SUL.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISUL66F)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT4_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBHPV1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT4_NETSMS_CTV.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLE2)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT5_NETSMS_SUL.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISULPV1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT5_NETSMS_CTV.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=TICTVLD1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT5_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIABC02F)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT5_NETSMS_SOC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=BIGT)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT5_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TIBH03F)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT5_NETSMS_SAO.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.208)(PORT=1523))(CONNECT_DATA=(SID=TISP03F)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT6_NETSMS_SUL.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.31)(PORT=1521))(CONNECT_DATA=(SID=SULST)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT7_NETSMS_SAO.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SPOSAMX)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT7_NETSMS_BRA.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRASAMX)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT7_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BHSAMX)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT7_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=ISPSAMX)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT7_NETSMS_CTV.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=dbri1ctv)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT7_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=BRISAMX)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT7_NETSMS_SUL.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=5.17.8.25)(PORT=1523))(CONNECT_DATA=(SID=SULTOA)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT7_NETSMS_SOC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=RACNET-CLTFT01.dcing.corp)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=SOCSAMX1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT8_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBHSP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT8_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRISP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT8_NETSMS_BRA.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.64.166)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DBRASP1)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_SIT8_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=DISPSP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_UAT_NETSMS_BH.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBH)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_UAT_NETSMS_ABC.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVBRI)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_UAT_NETSMS_ISP.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATVISP)))"
@call :makefile "%~dp0.\..\data\accesscontrol-data-GA_UAT_NETSMS_CTV.json" "consulta_dicionario/consulta@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.28.20.78)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=UATCTV)))"
@goto :sucesso

:makefile
@echo * %~nx1 
@if exist "%~dp1~%~nx1" @del "%~dp1~%~nx1"
@sqlplus -s -l %2 "@%~dp0.\spool_accesscontrol.sql" > "%~dp1~%~nx1"
@if errorlevel 1 @type "%~dp1~%~nx1"
@if exist "%~dpnx1" @del "%~dpnx1"
@ren "%~dp1~%~nx1" "%~nx1"
@goto :eof


:makemetadata
@echo * %~nx1 
@if exist "%~dp1~%~nx1" @del "%~dp1~%~nx1"
@sqlplus -s -l %2 "@%~dp0.\spool_accesscontrol_metadata.sql" > "%~dp1~%~nx1"
@if errorlevel 1 @type "%~dp1~%~nx1"
@if exist "%~dpnx1" @del "%~dpnx1"
@ren "%~dp1~%~nx1" "%~nx1"
@goto :eof

:sucesso
@exit /b 0

:falha
@exit /b 1