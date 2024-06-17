package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import connection.MySQLConnection;
import model.Cart;
import model.Item;
import model.Items;
import model.Orders;

public class OrdersRepository {
	public int addOrder(int userId, int totalCost, String note, String status, String paymentMethod, String receiverName, String shipAddress, String phoneNumber, String promoId) {
		LocalDateTime curDate = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = curDate.format(formatter);
		Connection connection = MySQLConnection.getConnection();
		CartRepository cd = new CartRepository();
		Cart cart = cd.getCartByUserId(userId);
		int isSuccess = 0;
		List<Items> listItem = cd.getItemByCartId(cart.getId());// (Cart.getId)
		try {
			String sql = "";
			if(!promoId.equals("")) {
				 sql = "insert into orders(total_money, user_id, order_status, note, payment_method, receiver_name, ship_address, phone_number, created_date, promo_id) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			}else {
				sql = "insert into orders(total_money, user_id, order_status, note, payment_method, receiver_name, ship_address, phone_number, created_date) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			}
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, totalCost); 
			st.setInt(2, userId);
			st.setString(3, status); 
			st.setString(4, note); 
			st.setString(5, paymentMethod); 
			st.setString(6, receiverName); 
			st.setString(7, shipAddress); 
			st.setString(8, phoneNumber); 
			st.setString(9, formattedDateTime); 
			if(!promoId.equals("")) {
				st.setString(10, promoId); 
			}
			st.executeUpdate();
			String sql1 = "select * from orders order by id desc limit 1;";
			//lấy cái vừa thêm vào, vừa thêm nên id lớn nhất
			PreparedStatement st1 = connection.prepareStatement(sql1);
			ResultSet rs = st1.executeQuery();
			if(rs.next()) {
				int oid = rs.getInt(1);
					// thêm các món trong giỏ hàng vào đơn
				for(Items i : listItem)	{
					String sql2 = "insert into order_detail(order_id, food_id, quantity) values (?, ?, ?);";
					PreparedStatement st2 = connection.prepareStatement(sql2);
					st2.setInt(1, oid);
					st2.setInt(2, i.getFoodId());
					st2.setInt(3, i.getQuantity());
					isSuccess = st2.executeUpdate();
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	public List<Orders> getOrderByStatus(int type, int userId) {
		String status = "";
		switch(type) {
			case 1 : status = "Chờ xác nhận"; break;
			case 2 : status = "Đang vận chuyển"; break;
			case 3 : status = "Đã hoàn thành"; break;
			case 4 : status = "Đã huỷ"; break;
		}
		List<Orders> list = new ArrayList<>();
		String sql = "select * from orders where order_status = ? and user_id = ? ";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, status);
			st.setInt(2, userId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Orders o = new Orders(rs.getInt("id"), 
									rs.getString("created_date"), 
									rs.getInt("total_money"),
									rs.getString("order_status"),
									rs.getString("note"),
									rs.getString("payment_method"),
									rs.getString("receiver_name"),
									rs.getString("ship_address"),
									rs.getString("phone_number"),
									rs.getInt("user_id"),
									rs.getString("promo_id"));
				list.add(o);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Orders> adminGetOrderByStatus(int type) {
		String status = "";
		switch(type) {
			case 1 : status = "Chờ xác nhận"; break;
			case 2 : status = "Đang vận chuyển"; break;
			case 3 : status = "Đã hoàn thành"; break;
			case 4 : status = "Đã huỷ"; break;
		}
		List<Orders> list = new ArrayList<>();
		String sql = "select * from orders where order_status = ? ";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, status);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Orders o = new Orders(rs.getInt("id"), 
									rs.getString("created_date"), 
									rs.getInt("total_money"),
									rs.getString("order_status"),
									rs.getString("note"),
									rs.getString("payment_method"),
									rs.getString("receiver_name"),
									rs.getString("ship_address"),
									rs.getString("phone_number"),
									rs.getInt("user_id"),
									rs.getString("promo_id"));
				list.add(o);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Orders> getAllOrder(int userId) {
		List<Orders> list = new ArrayList<>();
		String sql = "select * from orders where user_id = ?";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, userId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Orders o = new Orders(rs.getInt("id"), 
									rs.getString("created_date"), 
									rs.getInt("total_money"),
									rs.getString("order_status"),
									rs.getString("note"),
									rs.getString("payment_method"),
									rs.getString("receiver_name"),
									rs.getString("ship_address"),
									rs.getString("phone_number"),
									rs.getInt("user_id"),
									rs.getString("promo_id"));
				list.add(o);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Orders> getAllOrder() {
		List<Orders> list = new ArrayList<>();
		String sql = "select * from orders";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Orders o = new Orders(rs.getInt("id"), 
									rs.getString("created_date"), 
									rs.getInt("total_money"),
									rs.getString("order_status"),
									rs.getString("note"),
									rs.getString("payment_method"),
									rs.getString("receiver_name"),
									rs.getString("ship_address"),
									rs.getString("phone_number"),
									rs.getInt("user_id"),
									rs.getString("promo_id"));
				list.add(o);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Item> getItemLine(int orderId){
		List<Item> listItem = new ArrayList<>();
		String sql = "select f.id, f.title, f.description, f.price, f.image, f.cate_id, od.quantity \r\n"
				+ "from order_detail od join food f on od.food_id = f.id\r\n"
				+ "where order_id = ?;";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, orderId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Item i = new Item(rs.getInt("id"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("image"), rs.getInt("cate_id"),rs.getInt("quantity"));
				listItem.add(i);
			}
		}catch(SQLException e1) {
			e1.printStackTrace();
		}
		return listItem;
	}
	
	public List<Orders> getOrdersByUserId(int userId){
		List<Orders> listOrder = new ArrayList<>();
		String sql = "select * from orders where user_id = ?";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, userId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Orders o = new Orders(rs.getInt("id"), 
						rs.getString("created_date"), 
						rs.getInt("total_money"),
						rs.getString("order_status"),
						rs.getString("note"),
						rs.getString("payment_method"),
						rs.getString("receiver_name"),
						rs.getString("ship_address"),
						rs.getString("phone_number"),
						rs.getInt("user_id"),
						rs.getString("promo_id"));
				listOrder.add(o);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return listOrder;
	}
	
	public Orders getOrdersByOrderId(int orderId){
		String sql = "select * from orders where id = ?";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, orderId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Orders o = new Orders(rs.getInt("id"), 
						rs.getString("created_date"), 
						rs.getInt("total_money"),
						rs.getString("order_status"),
						rs.getString("note"),
						rs.getString("payment_method"),
						rs.getString("receiver_name"),
						rs.getString("ship_address"),
						rs.getString("phone_number"),
						rs.getInt("user_id"),
						rs.getString("promo_id"));
				return o;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Orders getNewestOrder(){
		String sql = "select * from orders order by id desc limit 1;";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Orders o = new Orders(rs.getInt("id"), 
						rs.getString("created_date"), 
						rs.getInt("total_money"),
						rs.getString("order_status"),
						rs.getString("note"),
						rs.getString("payment_method"),
						rs.getString("receiver_name"),
						rs.getString("ship_address"),
						rs.getString("phone_number"),
						rs.getInt("user_id"),
						rs.getString("promo_id"));
				return o;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int changeOrderStatus(int orderId, String status) {
		String sql = "update orders set order_status = ? where id = ?";
		Connection connection = MySQLConnection.getConnection();
		int isSuccess = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, status);
			st.setInt(2, orderId);
			isSuccess = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public int changeOrderStatus(int orderId, String status, String note) {
		String sql = "update orders set order_status = ?, note = ? where id = ?";
		Connection connection = MySQLConnection.getConnection();
		int isSuccess = 0;
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, status);
			st.setString(2, note);
			st.setInt(3, orderId);
			isSuccess = st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	public Map<String, Integer> getLast7DaysRevenue(String date) {
		Map<String, Integer> hashMap = new HashMap<>();
		ArrayList<Integer> orderMoney = new ArrayList<>();
		String sql = "select DATE(created_date), sum(total_money)\r\n"
				+ "from orders \r\n"
				+ "where DATE(created_date) between DATE_SUB(?, INTERVAL 6 Day) and ?  and order_status = 'Đã hoàn thành'\r\n"
				+ "group by DATE(created_date)";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, date);
			st.setString(2, date);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				orderMoney.add(rs.getInt("sum(total_money)"));
				hashMap.put(rs.getString("DATE(created_date)"), rs.getInt("sum(total_money)"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return hashMap;
	}
	public int countFoodHasSold(String date) {
		int tong = 0;
		String sql = "select sum(od.quantity)\r\n"
				+ "from orders o join order_detail od on o.id =  od.order_id\r\n"
				+ "where DATE(o.created_date) = ? and o.order_status = 'Đã hoàn thành'\r\n"
				+ "group by DATE(o.created_date) ";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, date);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				tong = rs.getInt("sum(od.quantity)");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tong;
	}
	
	public int countUser(String date) {
		int tong = 0;
		String sql = "select count(user_id)\r\n"
				+ "from orders o\r\n"
				+ "where DATE(o.created_date) = ? and o.order_status = 'Đã hoàn thành'\r\n"
				+ "group by DATE(o.created_date) ";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, date);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				tong = rs.getInt("count(user_id)");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tong;
	}	
	
	public int countOrders(String date) {
		int tong = 0;
		String sql = "select count(id)\r\n"
				+ "from orders o\r\n"
				+ "where DATE(o.created_date) = ?  and o.order_status = 'Đã hoàn thành'\r\n"
				+ "group by DATE(o.created_date)";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, date);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				tong = rs.getInt("count(id)");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tong;
	}
	public int calTotalRevenue(String date) {
		int tong = 0;
		String sql = "select sum(total_money)\r\n"
				+ "from orders o\r\n"
				+ "where DATE(o.created_date) = ? and o.order_status = 'Đã hoàn thành'\r\n"
				+ "group by DATE(created_date)";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setString(1, date);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				tong = rs.getInt("sum(total_money)");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tong;
	}
	public List<Orders> SearchOrders(int key){
		Connection connection = MySQLConnection.getConnection();
		String sql  = "select * from orders where id = ?";
		List<Orders> list = new ArrayList<>();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, key);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Orders o = new Orders(rs.getInt("id"), 
						rs.getString("created_date"), 
						rs.getInt("total_money"),
						rs.getString("order_status"),
						rs.getString("note"),
						rs.getString("payment_method"),
						rs.getString("receiver_name"),
						rs.getString("ship_address"),
						rs.getString("phone_number"),
						rs.getInt("user_id"),
						rs.getString("promo_id"));
				list.add(o);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public String getEmailByOrderId(int orderId) {
		String email = null;
		Connection connection = MySQLConnection.getConnection();
		try {
			String sql = "SELECT users.email FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.id = ?";
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, orderId);
			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				email = rs.getString("email");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return email;
	}
	public int getDiscountByOrderId(int orderId) {
		Connection connection = MySQLConnection.getConnection();
		try {
			String sql = "select percent "
					+ "from orders o join promo p on o.promo_id = p.id "
					+ "where o.id = ?";
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, orderId);
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				return rs.getInt("percent");
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	public int[] getCurrentWeekRevenue() {
		int[] totalMoney = new int[7];
		for(int i = 0 ; i < 7 ; i++)
			totalMoney[i] = 0;
		String sql = "select DAYOFWEEK(created_date), sum(total_money) \r\n"
				+ "from orders \r\n"
				+ "where WEEK(created_date) = WEEK(CURDATE()) and order_status = 'Đã hoàn thành'\r\n"
				+ "group by DAYOFWEEK(created_date);";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				totalMoney[rs.getInt("DAYOFWEEK(created_date)") - 1 ] = rs.getInt("sum(total_money)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalMoney;
	}
	
	public int[] getLastWeekRevenue() {
		int[] totalMoney = new int[7];
		for(int i = 0 ; i < 7 ; i++)
			totalMoney[i] = 0;
		String sql = "select DAYOFWEEK(created_date), sum(total_money) \r\n"
				+ "from orders \r\n"
				+ "where  WEEK(created_date) = WEEK(DATE_SUB(CURDATE(), INTERVAL 1 WEEK)) and order_status = 'Đã hoàn thành'\r\n"
				+ "group by DAYOFWEEK(created_date);";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				totalMoney[rs.getInt("DAYOFWEEK(created_date)") - 1] = rs.getInt("sum(total_money)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalMoney;
	}
	
	public int[] getCurrentYearRevenue() {
		int[] totalMoney = new int[12];
		for(int i = 0 ; i < 12 ; i++)
			totalMoney[i] = 0;
		String sql = "select MONTH(created_date), sum(total_money)\r\n"
				+ "from orders\r\n"
				+ "where YEAR(created_date) = YEAR(curdate())\r\n"
				+ "group by MONTH(created_date);";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				totalMoney[rs.getInt("MONTH(created_date)")-1] = rs.getInt("sum(total_money)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalMoney;
	}
	
	public int[] getLastYearRevenue() {
		int[] totalMoney = new int[12];
		for(int i = 0 ; i < 12 ; i++)
			totalMoney[i] = 0;
		String sql = "select MONTH(created_date), sum(total_money)\r\n"
				+ "from orders\r\n"
				+ "where YEAR(created_date) = YEAR(DATE_SUB(CURDATE(), INTERVAL 1 YEAR))\r\n"
				+ "group by MONTH(created_date);";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				totalMoney[rs.getInt("MONTH(created_date)")-1] = rs.getInt("sum(total_money)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalMoney;
	}
	
}
