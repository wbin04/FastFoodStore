package repository;

import java.util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.MySQLConnection;
import model.Cart;
import model.Food;
import model.Item;
import model.Items;

public class CartRepository {
	public List<Items> getItemByCartId(int cartId){
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from item where cart_id = ?";
		List<Items> list = new ArrayList<>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, cartId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Items i = new Items( rs.getInt("cart_id"), rs.getInt("food_id"), rs.getInt("quantity"));
				list.add(i);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Cart getCartByUserId(int userId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from cart where user_id = ?";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, userId);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				Cart cart = new Cart(rs.getInt("id"), rs.getInt("total_money"), rs.getInt("user_id"));
				return cart;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Items getItemByFoodId(int cartId, int foodId) {
		List<Items> listItem = getItemByCartId(cartId);
		for(Items i : listItem) {
			if(i.getFoodId() == foodId) {
				return i;
			}
		}
		return null;
	}
	
	public int addItem(int cartId, int foodId, int quantity) {
		Connection connection = MySQLConnection.getConnection();
		int isSuccess = 0;
		if(getItemByFoodId(cartId, foodId) != null) {
			Items i = getItemByFoodId(cartId, foodId);
			i.setQuantity(i.getQuantity() + quantity);
			String sql = "update item set quantity = ? where cart_id = ? and food_id = ?";
			try {
				PreparedStatement st = connection.prepareStatement(sql);
				st.setInt(1, i.getQuantity());
				st.setInt(2, cartId);
				st.setInt(3, foodId);
				isSuccess = st.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}else {
			String sql = "insert into item(cart_id, food_id, quantity) values (?, ?, ?)";
			
			try {
				PreparedStatement st = connection.prepareStatement(sql);
				st.setInt(1, cartId);
				st.setInt(2, foodId);
				st.setInt(3, quantity);
				isSuccess = st.executeUpdate();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return isSuccess;
	}
	
	public List<Item> getItemFood(int cartId){
		Connection connection = MySQLConnection.getConnection();
		String sql = "select  f.id, f.title, f.description, f.price, f.image, f.cate_id, i.quantity\r\n"
				+ "from item i join food f on i.food_id = f.id\r\n"
				+ "where i.cart_id = ?;";
		List<Item> list = new ArrayList<>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, cartId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Item i = new Item(rs.getInt("id"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("image"), rs.getInt("cate_id"),rs.getInt("quantity"));
				list.add(i);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int delItemFromCart(int cartId, int foodId) {
		Connection connection = MySQLConnection.getConnection();
		int isSuccess = 0;
		Items i = getItemByFoodId(cartId, foodId);
		String sql = "delete from item where cart_id = ? and food_id = ?";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, cartId);
			st.setInt(2, foodId);
			isSuccess = st.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	public int updateItemQuantity(int cartId, int foodId, String deli) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "update item set quantity = ? where cart_id = ? and food_id = ?";
		int isSuccess = 0;
		Items i = getItemByFoodId(cartId, foodId);
		if(deli.equals("minus")) {
			i.setQuantity(i.getQuantity() - 1);
		}else if(deli.equals("plus"))
			i.setQuantity(i.getQuantity() + 1);
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, i.getQuantity());
			st.setInt(2, cartId);
			st.setInt(3, foodId);
			isSuccess = st.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public Cart getCart(int cartId) {
		Connection connection = MySQLConnection.getConnection();
		String sql = "select * from cart where id = ?";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				return new Cart(rs.getInt("id"), rs.getInt("total_money"), rs.getInt("user_id"));
			}
		}catch(SQLException e1) {
			e1.printStackTrace();
		}
		return null;
	}
	
	public int updateTotalMoney(int tong, int cartId) {	
		int isSuccess = 0;
		Connection connection = MySQLConnection.getConnection();
		String sql = "UPDATE cart set total_money = ? where id = ?;";
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, tong);
			st.setInt(2, cartId);
			isSuccess = st.executeUpdate();
		}catch(SQLException e1) {
			e1.printStackTrace();
		}
		return isSuccess;
	}
}
