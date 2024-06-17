package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import connection.MySQLConnection;
import model.Promo;

public class PromoRepository {
	public List<Promo> getAllPromo() {
		Connection connection = MySQLConnection.getConnection();
		List<Promo> list = new ArrayList<>();
		String sql = "select * from promo";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				list.add(new Promo(rs.getString("id"),
									rs.getInt("percent"),
									rs.getString("start_date"),
									rs.getString("end_date"),
									rs.getDouble("minimum_pay")));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Promo> getAvailablePromo(){
		Connection connection = MySQLConnection.getConnection();
		List<Promo> list = new ArrayList<>();
		String sql = "select * \r\n"
				+ "from promo\r\n"
				+ "where CURDATE() between start_date and end_date";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				list.add(new Promo(rs.getString("id"),
									rs.getInt("percent"),
									rs.getString("start_date"),
									rs.getString("end_date"),
									rs.getDouble("minimum_pay")));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Promo> getSoonPromo(){
		Connection connection = MySQLConnection.getConnection();
		List<Promo> list = new ArrayList<>();
		String sql = "select * \r\n"
				+ "from promo\r\n"
				+ "where CURDATE() < start_date";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				list.add(new Promo(rs.getString("id"),
									rs.getInt("percent"),
									rs.getString("start_date"),
									rs.getString("end_date"),
									rs.getDouble("minimum_pay")));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Promo getPromoById(String promoId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from promo where id = ?";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, promoId);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				return new Promo(rs.getString("id"),
									rs.getInt("percent"),
									rs.getString("start_date"),
									rs.getString("end_date"),
									rs.getDouble("minimum_pay"));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int addPromo(String id, int discount, double minimumPay, String startDate, String endDate) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "insert into promo(id, percent, minimum_pay, start_date, end_date) values(?, ?, ?, ?, ?)";
		int isSuccess = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, id);
			st.setInt(2, discount);
			st.setDouble(3, minimumPay);
			st.setString(4, startDate);
			st.setString(5, endDate);
			isSuccess = st.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public int editPromo(String promoId, int discount, double minimumPay, String startDate, String endDate) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "update promo set percent = ?, minimum_pay = ?, start_date = ?, end_date = ? where id = ?";
		int isSuccess = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, discount);
			st.setDouble(2, minimumPay);
			st.setString(3, startDate);
			st.setString(4, endDate);
			st.setString(5, promoId);
			isSuccess = st.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	public int deletePromo(String promoId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "delete from promo where id = ?";
		System.out.println(promoId);
		int isSuccess = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, promoId);
			isSuccess = st.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
}
