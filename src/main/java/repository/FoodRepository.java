package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.MySQLConnection;
import model.Food;


public class FoodRepository {
	public List<Food> getAll(){
		List<Food> list = new ArrayList<>();
		String sql = "select * from food";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Food f = new Food(rs.getInt("id"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("image"), rs.getString("availability"), rs.getInt("cate_id"));
				list.add(f);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Food> searchByName(String key){
		List<Food> list = new ArrayList<>();
		String sql = "select f.id, f.title, f.description, f.image, f.cate_id, c.cate_name "
				+ "from food f join category c on f.cate_id = c.id "
				+"where f.title like ?";;
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, "%" + key + "%");
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Food f = new Food(rs.getInt("id"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("image"), rs.getString("availability"), rs.getInt("cate_id"));
				list.add(f);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Food> getByCatID(int id){
		if(id == 0) {
			return getAll();
		}else {
			List<Food> list = new ArrayList<>();
			String sql = "select *"
					+ "from food f join category c on f.cate_id = c.id "
					+"where c.id = ?;";
			Connection connection = MySQLConnection.getConnection();
			try {
				PreparedStatement st = connection.prepareStatement(sql);
				st.setInt(1, id);
				ResultSet rs = st.executeQuery();
				while(rs.next()) {
					Food f = new Food(rs.getInt("id"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("image"),  rs.getString("availability"), rs.getInt("cate_id"));
					list.add(f);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return list;
		}
		
	}
	
	public Food getFoodById(int id) {
		String sql = "select * from food where id = ?";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, id);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				return  new Food(
						rs.getInt("id"), 
						rs.getString("title"),
						rs.getString("description"), 
						rs.getInt("price"), 
						 rs.getString("image"),
						 rs.getString("availability"),
						rs.getInt("cate_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Food> getBestSellerFood(){
		List<Food> list = new ArrayList<>();
		String sql = "select *"
				+ "from food as f join (select food_id"
				+ "					from order_detail "
				+ "					group by food_id"
				+ "					order by sum(quantity) desc"
				+ "					LIMIT 4"
				+ "					) as od on f.id = od.food_id;";
				
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Food f = new Food(rs.getInt("id"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("image"),  rs.getString("availability"), rs.getInt("cate_id"));
				list.add(f);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int deleteFoodById(int id) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "delete from food f where f.id = ?";
		int isDelete = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, id);
			
			isDelete = st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isDelete;
	}
	
	public int insertFood(String title, String desc, int price, String image, String availability, int cateId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "insert into food(title, description, price, image, availability,  cate_id) values (?, ?, ?, ?, ?, ?)";
		int isSuccess = 0 ;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, title);
			st.setString(2, desc);
			st.setInt(3, price);
			st.setString(4, image);
			st.setString(5, availability);
			st.setInt(6, cateId);
			isSuccess = st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public List<Food> searchFood(String text){
		Connection connection = MySQLConnection.getConnection();
		String sql  = "select * from food where title like ?";
		List<Food> list = new ArrayList<>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, "%" + text + "%");
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Food f = new Food(
						rs.getInt("id"), 
						rs.getString("title"),
						rs.getString("description"), 
						rs.getInt("price"), 
						 rs.getString("image"),
						 rs.getString("availability"),
						rs.getInt("cate_id"));
				list.add(f);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int updateFoodDetail(int foodId, String title, String desc, int price, String image, int cateId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "update food set title = ?, description = ?, price = ?, image = ?, cate_id = ? where id = ?";
		int isSuccess = 0 ;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, title);
			st.setString(2, desc);
			st.setInt(3, price);
			st.setString(4, image);
			st.setInt(5, cateId);
			st.setInt(6, foodId);
			isSuccess = st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public int updateFoodAvailability(int foodId, String availability) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "update food set availability = ? where id = ?";
		int isSuccess = 0 ;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, availability);	
			st.setInt(2, foodId);
			isSuccess = st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	public List<Integer> getFoodIdsByUserId(int userId, int orderId) {
	    Connection connection = MySQLConnection.getConnection();
	    List<Integer> foodIds = new ArrayList<>();
	    String sql = "select od.food_id from orders o join order_detail od on o.id = od.order_id where o.user_id = ? && o.id = ?";
	    try {
	        PreparedStatement st = connection.prepareStatement(sql);
	        st.setInt(1, userId);
	        st.setInt(2, orderId);
	        ResultSet rs = st.executeQuery();
	        while(rs.next()) {
	            foodIds.add(rs.getInt("food_id"));
	        }
	    } catch(SQLException e) {
	        e.printStackTrace();
	    }
	    return foodIds;
	}
}
