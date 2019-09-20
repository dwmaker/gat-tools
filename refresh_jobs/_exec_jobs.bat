@for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do @set datetime=%%I

@echo %~dp0..\logs\refresh_job_%datetime:~0,14%.log
@echo [INIT_JOB] - %DATE% %TIME% >>"%~dp0..\logs\refresh_job_%datetime:~0,14%.log"
call :executar  1>>"%~dp0..\logs\refresh_job_%datetime:~0,14%.log"

@IF %ERRORLEVEL% EQU 0 (
echo [END_SUCESS] - %DATE% %TIME% 1>>"%~dp0..\logs\refresh_job_%datetime:~0,14%.log"
type "%~dp0..\logs\refresh_job_%datetime:~0,14%.log"
exit /b 0
) else (
echo [END_FAILURE] - %DATE% %TIME% 1>>"%~dp0..\logs\refresh_job_%datetime:~0,14%.log"
type "%~dp0..\logs\refresh_job_%datetime:~0,14%.log"
exit /b 1
)


:executar


@REM -----------------------------------------------------
@echo [STEP:ETL_SN_PARAMETRO.BAT] - %DATE% %TIME%
@call "%~dp0.\etl_sn_parametro.bat"           
@IF %ERRORLEVEL% NEQ 0 exit /b 1

@echo [STEP:ETL_SN_PARAMETRO_ENDPOINT.BAT] - %DATE% %TIME%
@call "%~dp0.\etl_sn_parametro_endpoint.bat"  
@IF %ERRORLEVEL% NEQ 0 exit /b 1

@echo [STEP:SPOOL_REPORT_SN_PARAMETRO.BAT] - %DATE% %TIME%
@call "%~dp0.\spool_report_sn_parametro.bat"  
@IF %ERRORLEVEL% NEQ 0 exit /b 1

@REM -----------------------------------------------------

@echo [STEP:SPOOL_ACCESSCONTROL.BAT] - %DATE% %TIME%
@call "%~dp0.\spool_accesscontrol.bat"        
@IF %ERRORLEVEL% NEQ 0 exit /b 1

@echo [STEP:SPOOL_LOG_ACESSO_DATA.BAT] - %DATE% %TIME%
@call "%~dp0.\spool_log_acesso_data.bat"      
@IF %ERRORLEVEL% NEQ 0 exit /b 1

@echo [STEP:SPOOL_REPORT_SN_VERSAO.BAT] - %DATE% %TIME%
@call "%~dp0.\spool_report_sn_versao.bat"     
@IF %ERRORLEVEL% NEQ 0 exit /b 1

@echo [STEP:ETL_CORE.BAT] - %DATE% %TIME%
@call "%~dp0.\etl_core.bat"
@IF %ERRORLEVEL% NEQ 0 exit /b 1
@REM -----------------------------------------------------
@echo [STEP:SPOOL_DISK_SERVICE.BAT] - %DATE% %TIME%
@call "%~dp0.\spool_disk_service.bat"         
@IF %ERRORLEVEL% NEQ 0 exit /b 1



@goto :eof