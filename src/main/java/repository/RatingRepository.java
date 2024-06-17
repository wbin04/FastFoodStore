package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import connection.MySQLConnection;
import model.RatingDetail;
import model.RatingFood;


public class RatingRepository {
	public List<RatingFood> getAllRatingByFoodId(int foodId){
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from rating_food where food_id = ?";
		List<RatingFood> list = new ArrayList<>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, foodId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				RatingFood rating = new RatingFood(rs.getInt("id"), rs.getString("content"), rs.getInt("user_id"), rs.getInt("food_id"), rs.getInt("order_id"));
				list.add(rating);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<RatingDetail> getAllRatingDetailByFoodId(int foodId){
		Connection connection = MySQLConnection.getConnection();
		String sql = "select u.id, u.fullname, u.username, rf.content, rf.point, rf.food_id, rf.order_id \r\n"
				+ "from users u join rating_food rf on u.id = rf.user_id \r\n"
				+ "where rf.food_id = ?";
		List<RatingDetail> list = new ArrayList<>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, foodId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				RatingDetail rating = new RatingDetail(rs.getInt("id"), rs.getString("fullname"), rs.getString("username"), rs.getString("content"), rs.getDouble("point"), rs.getInt("food_id"));
				list.add(rating);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public void insertRating(int user_id, int food_id, String content, double point, int order_id) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "INSERT INTO rating_food(user_id, food_id, content, point, order_id) VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			/*for (Integer food_id : food_ids) {*/
				st.setInt(1, user_id);
				st.setInt(2, food_id);
				st.setString(3, content);
				st.setDouble(4, point);
				st.setInt(5, order_id);
				st.executeUpdate();
				/* } */
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean checkRating(int user_id, int order_id, int food_id) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "SELECT COUNT(*) FROM rating_food WHERE user_id = ? AND order_id = ? AND food_id = ?";
		boolean check = false;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, user_id);
			st.setInt(2, order_id);
			st.setInt(3, food_id);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				check = rs.getInt(1) > 0;
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return check;
	}
	
	public List<Integer> getRatedProducts(int userId, int orderId) {
	    Connection connection = MySQLConnection.getConnection();
	    String sql = "SELECT DISTINCT food_id FROM rating_food WHERE user_id = ? AND order_id = ?";
	    List<Integer> ratedProducts = new ArrayList<>();
	    try {
	        PreparedStatement st = connection.prepareStatement(sql);
	        st.setInt(1, userId);
	        st.setInt(2, orderId);
	        ResultSet rs = st.executeQuery();
	        while (rs.next()) {
	            ratedProducts.add(rs.getInt("food_id"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return ratedProducts;
	}
}
