@call "%~dp0.\config.bat"
@pushd "%~dp0.\replicadorddl\bin"
 

@rem set classpath=%classpath%;%~dp0.\replicadorddl\lib\commons-cli-1.4.jar;%~dp0.\replicadorddl\lib\ojdbc14.jar;
@REM java Main -dblink "GA_SIT2_NETSMS_BH.NET" -owner "PROD_JD" -name "FCSMS_RETORNA_ENDERECO"
@java -cp "%~dp0.\replicadorddl\lib\commons-cli-1.4.jar;%~dp0.\replicadorddl\lib\ojdbc14.jar;" Main %*
@popd