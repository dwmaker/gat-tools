

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DAOApp {
	
	private Connection _connection;
	
	public DAOApp(Connection connection) {
		this._connection = connection;
	}

	public String getDDL(Dblink dblink, String objectType, String owner, String objectName) throws SQLException, NoDataFoundException 
	{
		String saida="";
		
		PreparedStatement  ps3 = this._connection.prepareStatement(
		"select " + 
		"text " + 
		"from all_source@" + dblink.cd_conexao + " " + 
		"where "		+ 
		"owner = ? "+
		"and name = ? "+
		"and type = ? " + 
		"order by line asc"
		);
		ps3.setString(1, owner);
		ps3.setString(2, objectName);
		ps3.setString(3, objectType);
		ResultSet rs3 = ps3.executeQuery();
		int i=0;
		while(rs3.next()) {
			saida += rs3.getString(1);
			i++;
		}
		if (i==0) throw new NoDataFoundException();
		//saida += "\r\n/";
		return "create or replace " + saida;
	}
	
	public Dblink getDblink( String cd_conexao) throws SQLException, NoDataFoundException, TooManyRowsException 
	{
		PreparedStatement  ps1 = _connection.prepareStatement("select cd_conexao, cd_ambiente, cd_aplicacao, cd_cenario, username, ds_conexao from vw_conexao where cd_conexao = ?");
		ps1.setString(1, cd_conexao);
		ResultSet rs1 = ps1.executeQuery();
		if(!rs1.next()) throw new NoDataFoundException();
		Dblink cnx1 = new Dblink();
		cnx1.cd_conexao = rs1.getString(1);
		cnx1.cd_ambiente = rs1.getString(2);
		cnx1.cd_aplicacao = rs1.getString(3);
		cnx1.cd_cenario = rs1.getString(4);
		cnx1.username = rs1.getString(5);
		cnx1.ds_conexao = rs1.getString(6);
		if(rs1.next()) throw new TooManyRowsException();
		return cnx1;
	}
	
	public Dblink getDblink(String cd_ambiente, String cd_aplicacao, String cd_cenario) throws SQLException, NoDataFoundException, TooManyRowsException 
	{
		PreparedStatement  ps2 = this._connection.prepareStatement(
		"select " +
		"cd_conexao, " +
		"cd_ambiente, " +
		"cd_aplicacao, " +
		"cd_cenario, " +
		"username, " +
		"ds_conexao " +
		"from vw_conexao " +
		"where " +
		"cd_ambiente = ? " +
		"and ((cd_aplicacao = ?) or (cd_aplicacao is null and ? is null))" +
		"and ((cd_cenario = ?) or (cd_cenario is null and ? is null))"
		);
		ps2.setString(1, cd_ambiente);
		ps2.setString(2, cd_aplicacao);
		ps2.setString(3, cd_aplicacao);
		ps2.setString(4, cd_cenario);
		ps2.setString(5, cd_cenario);
		ResultSet rs2 = ps2.executeQuery();
		
		if(!rs2.next()) throw new NoDataFoundException();
		Dblink cnx2 = new Dblink();
		cnx2.cd_conexao   = rs2.getString(1);
		cnx2.cd_ambiente  = rs2.getString(2);
		cnx2.cd_aplicacao = rs2.getString(3);
		cnx2.cd_cenario   = rs2.getString(4);
		cnx2.username     = rs2.getString(5);
		cnx2.ds_conexao   = rs2.getString(6);
		if(rs2.next()) throw new TooManyRowsException();
		return cnx2;
	}

	public String[] getObjectTypes(Dblink dblink, String owner, String objectName) throws SQLException {
		  ArrayList<String> saida = new ArrayList<String>();
			
			PreparedStatement  ps3 = this._connection.prepareStatement(
			"select " + 
			"owner, " +
			"object_name, " +
			"object_type " +
			"from all_objects@" + dblink.cd_conexao + " " + 
			"where "		+ 
			"owner = ? "+
			"and object_name = ? "+
			"order by object_type asc"
			);
			ps3.setString(1, owner);
			ps3.setString(2, objectName);
			ResultSet rs3 = ps3.executeQuery();
			
			while(rs3.next()) {
				saida.add( rs3.getString(3));
			}
			//saida += "\r\n/";
			return saida.toArray(new String[0]);
		}
	
}
