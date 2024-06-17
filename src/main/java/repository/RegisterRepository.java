package repository;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import connection.MySQLConnection;
import model.Users;

public class RegisterRepository {
	public boolean InsertAccount(Connection conn, Users users) {
		LocalDateTime curDate = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String date = curDate.format(formatter);
		PreparedStatement ptmt = null;
		String sql = "INSERT INTO users(fullname, username, password, email, address, phone_number, created_date, role_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try
		{
			ptmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			String fullname = users.getFullname();
			String username = users.getUsername();
			String password = users.getPassword();
			String email = users.getEmail();
			String address = users.getAddress();
			String phone_number = users.getPhoneNumber();
			ptmt.setString(1, fullname);
			ptmt.setString(2, username);
			ptmt.setString(3, password);
			ptmt.setString(4, email);
			ptmt.setString(5, address);
			ptmt.setString(6, phone_number);
			ptmt.setString(7, date);
			ptmt.setInt(8, 1);
			
			int check = ptmt.executeUpdate();
			if(check != 0)
			{
				/* System.out.println(users.getUsername() + " " + users.getEmail()); */
				ResultSet rs = ptmt.getGeneratedKeys();
				if(rs.next())
				{
					int userId = rs.getInt(1);
					ptmt = conn.prepareStatement("INSERT INTO cart(total_money, user_id) VALUES (?, ?)");
					ptmt.setInt(1, 0);
					ptmt.setInt(2, userId);
					ptmt.executeUpdate();
				}
				return true;
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean checkUser(String username) {
	    Connection connection = MySQLConnection.getConnection();
	    String sql = "SELECT * FROM users WHERE username = ?";
	    try {
	        PreparedStatement st = connection.prepareStatement(sql);
	        st.setString(1, username);
	        ResultSet rs = st.executeQuery();
	        if(rs.next()) {
	            return false;
	        }
	    } catch(SQLException e) {
	        e.printStackTrace();
	    }
	    return true; 
	}
}
