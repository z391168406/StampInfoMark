//用来连接数据库，得到一个数据库连接
package version1.model;
import java.sql.*;

public class ConnDB {
	public Connection ct=null;
	public Connection getConn(){
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			ct= DriverManager
					.getConnection("jdbc:mysql://localhost:3306/stamp-db?user=root&password=123456&useUnicode=true&characterEncoding=GBK");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ct;
	}
	
}
