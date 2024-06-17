package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.MySQLConnection;
import model.Roles;
import model.Users;

public class UsersRepository {
	public Users getAccount(String username, String password) {
		String sql = "select * from users where username = ? and password = ?";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1,username);
			st.setString(2,password);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				return new Users(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getString(6), rs.getString(7), rs.getDate(8), rs.getInt(9) );
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Users getUserDetail(int userId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from users where id = ?";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, userId);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				return new Users(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getString(6), rs.getString(7), rs.getDate(8), rs.getInt(9) );
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Users> searchUser(String fullname) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from users where fullname like ? and role_id = 1";
		List<Users> list = new ArrayList<>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, "%" + fullname + "%");
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Users u = new Users(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getString(6), rs.getString(7), rs.getDate(8), rs.getInt(9) );
				list.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int updateUserDetail(int userId, String fullname, String phone_number, String address) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "update users set fullname = ?, phone_number = ?, address = ? where id = ?";
		int isSuccess = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, fullname);
			st.setString(2, phone_number);
			st.setString(3, address);
			st.setInt(4, userId);
			isSuccess = st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public List<Users> getAllUsers() {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from users";
		List<Users> list = new ArrayList<>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Users u = new Users(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getString(6), rs.getString(7), rs.getDate(8), rs.getInt(9));
				list.add(u);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int updatePassword(int userId, String newPassword){
		Connection connection = MySQLConnection.getConnection();
		String sql = "update users set password = ? where id = ?";
		int isSuccess = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, newPassword);
			st.setInt(2, userId);
			isSuccess = st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public String getOldPassword(int userId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select password from users where id = ?";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, userId);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				return rs.getString("password"); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int updateRole(int userId, int roleId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "update users set role_id = ? where id = ?";
		int isSuccess = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, roleId);
			st.setInt(2, userId);
			isSuccess = st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public boolean checkUsernameExists(String username) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from users where username = ?";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, username);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean checkEmailExists(String email) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from users where email = ?";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public List<Roles> getListRoles(){
		Connection connection = MySQLConnection.getConnection();
		String sql =  "select * from roles";
		List<Roles> list = new ArrayList<Roles>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Roles roles = new Roles(rs.getInt("id"), rs.getString("role_name"));
				list.add(roles);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
