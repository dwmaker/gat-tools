import java.sql.Connection;  
import java.sql.DriverManager;
import java.sql.Statement;

import java.util.Map;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

public class Main
{  
	public static void main(String args[]) throws Exception
	{
		String c_default_password = "M4zzalli";
		
		Map<String, String> env = System.getenv();
		String gatdb_cnx = env.get("GATDB_CNX");
		String gatdb_usr = env.get("GATDB_USR");
		String gatdb_pwd = env.get("GATDB_PWD");

		CommandLine line = parseargs( args );
		String owner = line.getOptionValue("owner");
		String name = line.getOptionValue("name");
		String dblink = line.getOptionValue("dblink");
		String type = line.getOptionValue("type");

		System.out.println("Abrindo Conexao GATDB");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection gatdb_connection = DriverManager.getConnection("jdbc:oracle:thin:@" + gatdb_cnx, gatdb_usr, gatdb_pwd);
		
		DAOApp daoapp = new DAOApp(gatdb_connection);
		System.out.println("Buscando DBLink do Ambiente");
		Dblink cnx1 = daoapp.getDblink(dblink);
		
		System.out.println("Buscando DBLink de Produção");
		Dblink cnx2 = daoapp.getDblink("PROD", cnx1.cd_aplicacao, cnx1.cd_cenario);
		
		System.out.println("Extraindo DDL de Produção");
		String ddl = daoapp.getDDL(cnx2, type,  owner,  name);

		System.out.println("Fechando Conexao GATDB");
		gatdb_connection.close();
		
		System.out.println("Abrindo Conexão do Ambiente");
		Connection envdb_connection = DriverManager.getConnection("jdbc:oracle:thin:@" + cnx1.ds_conexao, cnx1.username, c_default_password );
		
		System.out.println("Alterando Schema da Conexão");
		Statement stmt1 = envdb_connection.createStatement();
		stmt1.executeUpdate("ALTER SESSION SET CURRENT_SCHEMA = "+owner+"");
		
		System.out.println("Aplicando DDL no ambiente");
		Statement stmt2 = envdb_connection.createStatement();
		stmt2.executeUpdate(ddl);		
		
		System.out.println("Fechando Conexao do Ambiente");
		envdb_connection.close();
		System.out.println("Finalizado com sucesso");		
	}

	private static CommandLine parseargs(String[] args) throws ParseException 
	{
		Options options = new Options();
		options.addOption(Option.builder("dblink").required(true).hasArg().desc("Target DBLink Name").build());
		options.addOption(Option.builder("owner").required(true).hasArg().desc("Object Owner").build());
		options.addOption(Option.builder("name").required(true).hasArg().desc("Object Name").build());
		options.addOption(Option.builder("type").required(true).hasArg().desc("Object Type").build());
		
		CommandLineParser parser = new DefaultParser();
		try 
		{
			CommandLine line = parser.parse( options, args );
			return line;
		}
		catch( ParseException e)
		{
			HelpFormatter formatter = new HelpFormatter();
			formatter.printHelp( "replicadorddl.bat", options );
			throw e;
		}
	}  
	
}


