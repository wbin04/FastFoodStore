package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Category;
import model.Food;
import model.Item;
import model.Orders;
import model.Roles;
import model.Users;
import service.CategoryService;
import service.FoodService;
import service.OrdersService;
import service.UsersService;

@WebServlet(urlPatterns = {"/ManageUserDetail", "/ManageFoodDetail", "/ManageOrdersDetail"})
public class AdminManageDetail extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		HttpSession session = req.getSession(true);
		if(session.getAttribute("roleAdmin") != null) {
			switch(path) {
			case "/ManageUserDetail":
				UsersService usersService = new UsersService();
				String id_raw = req.getParameter("id");
				int userId;
				if(id_raw != null) {
					userId = Integer.parseInt(id_raw);
					Users user = usersService.getUserDetail(userId);
					req.setAttribute("user", user);
					List<Roles> listRoles = usersService.getListRoles();
					req.setAttribute("listRole", listRoles);
					req.getRequestDispatcher("adminManageUserDetail.jsp").forward(req, resp);
				}
				break;
			case "/ManageFoodDetail":
				FoodService foodService = new FoodService();
				CategoryService cateDAO = new CategoryService();
				String id_raw2 = req.getParameter("id");
				int foodId;
				if(id_raw2 != null) {
					foodId = Integer.parseInt(id_raw2);
					Food food = foodService.getFoodById(foodId);
					List<Category> listCate = cateDAO.getAll();
					req.setAttribute("listCate", listCate);
					req.setAttribute("food", food);
					
					req.getRequestDispatcher("adminManageFoodDetail.jsp").forward(req, resp);
				}
				break;
			case "/ManageOrdersDetail":
				OrdersService ordersService = new OrdersService();
				String id_raw3 = req.getParameter("id");
				int orderId;
				if(id_raw3 != null) {
					orderId = Integer.parseInt(id_raw3);
					Orders o = ordersService.getOrdersByOrderId(orderId);
					int type = Integer.parseInt(req.getParameter("type"));
					req.setAttribute("type", type);
					List<Item> listItem = ordersService.getItemLine(orderId);
					UsersService usersDAO1 = new UsersService();
					Users user1 = usersDAO1.getUserDetail(o.getUserId());
					req.setAttribute("user", user1);
					req.setAttribute("listItem", listItem);
					req.setAttribute("order", o);
					int discountAmount = ordersService.getDiscountByOrderId(orderId);
					req.setAttribute("discountAmount", discountAmount);
					req.getRequestDispatcher("adminManageOrdersDetail.jsp").forward(req, resp);
				}
				break;
			}
		}else
			resp.sendRedirect("home");
	}
}
