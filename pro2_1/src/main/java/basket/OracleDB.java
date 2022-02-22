package basket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OracleDB {

	public static Connection getConnection() throws Exception { 
		Class.forName("oracle.jdbc.driver.OracleDriver"); 
		String url = "jdbc:oracle:thin:@masternull.iptime.org:1521:orcl";
		String user ="team02";
		String pw = "team02";
		Connection conn = DriverManager.getConnection(url,user,pw);  
		return conn;
		   }
	}

