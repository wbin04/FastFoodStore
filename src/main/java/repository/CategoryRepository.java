package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import connection.MySQLConnection;
import model.Category;

public class CategoryRepository {
	public List<Category> getAll(){
		List<Category> list = new ArrayList<>();
		String sql = "select * from category";
		Connection connection = MySQLConnection.getConnection();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setCateName(rs.getString("cate_name"));
				c.setImage(rs.getString("image"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	public int[] getCategoryRevenue() {
		List<Category> list = getAll();
		int size = list.size();
		int[] listCateRev = new int[size];
		for(int i = 0;  i < size; i++)
			listCateRev[i] = 0;
		Connection connection = MySQLConnection.getConnection();
		String sql = "WITH FoodRevenue AS(\r\n"
				+ "	select od.food_id, sum(od.quantity) as total_quantity, sum(od.quantity * f.price) as total_revenue, f.cate_id\r\n"
				+ "    from (orders o join order_detail od on o.id = od.order_id)\r\n"
				+ "		join food f on od.food_id = f.id\r\n"
				+ "	where o.order_status = 'Đã hoàn thành' and MONTH(o.created_date) = MONTH(CURDATE())\r\n"
				+ "    group by od.food_id\r\n"
				+ ")\r\n"
				+ "\r\n"
				+ "select fr.cate_id, sum(total_revenue)\r\n"
				+ "from FoodRevenue fr join category c on fr.cate_id = c.id\r\n"
				+ "group by fr.cate_id\r\n"
				+ "order by fr.cate_id asc;\r\n";
				
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				listCateRev[rs.getInt("cate_id") - 1 ] = rs.getInt("sum(total_revenue)");
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return listCateRev;
	}
}
