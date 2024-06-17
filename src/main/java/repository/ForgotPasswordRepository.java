package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.MySQLConnection;
import model.Users;

public class ForgotPasswordRepository {

	public void Edit_Pass(String pass, String mail)
	{
		String sql = "UPDATE users SET password = ? WHERE email = ?";
		Connection con = MySQLConnection.getConnection();
		try {
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, pass);
			st.setString(2, mail);
			st.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
}
