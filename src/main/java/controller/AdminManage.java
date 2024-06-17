package controller;

import java.util.*;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Food;
import model.Orders;
import model.Promo;
import model.Roles;
import model.Users;
import service.FoodService;
import service.OrdersService;
import service.PromoService;
import service.UsersService;

@WebServlet(urlPatterns = {"/adminManageUser", "/adminManageFood", "/adminManageOrders", "/adminManagePromo"})
public class AdminManage extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String path = req.getServletPath();
		switch(path) {
			case "/adminManageUser":
				UsersService usersService = new UsersService();
				List<Users> listUser ;
				HttpSession session = req.getSession(true);
				if(session.getAttribute("roleAdmin") != null) {
					String key = req.getParameter("key");
					if (key != null && !key.isEmpty()) {
				        listUser = usersService.searchUser(key);
				    } else {
				    	listUser = usersService.getAllUsers();
				    }
					
					req.setAttribute("listUser", listUser);
					req.getRequestDispatcher("adminManageUser.jsp").forward(req, resp);
				}else
					resp.sendRedirect("home");
				break;
			case "/adminManageFood":
				FoodService foodService = new FoodService();
				List<Food> listFood;
				HttpSession session1 = req.getSession(true);
				if(session1.getAttribute("roleAdmin") != null) {
					String key1 = req.getParameter("key");
					if (key1 != null && !key1.isEmpty()) {
						listFood = foodService.searchFood(key1);
					}else {
				    	listFood = foodService.getAll();
				    }
					req.setAttribute("listFood", listFood);
					req.getRequestDispatcher("adminManageFood.jsp").forward(req, resp);
				}else
					resp.sendRedirect("home");
				break;
			case "/adminManageOrders":
				OrdersService ordersService = new OrdersService();
				List<Orders> listOrder;
				String type_raw = req.getParameter("type");
				String key_raw = req.getParameter("key");
				HttpSession session2 = req.getSession(true);
				if(session2.getAttribute("roleAdmin") != null) {
					if(key_raw != null && !key_raw.isEmpty()) {
						int key = Integer.parseInt(key_raw);
						listOrder = ordersService.SearchOrders(key);
					}
					else if (type_raw != null && !type_raw.isEmpty()) {
						int type = Integer.parseInt(req.getParameter("type"));
						listOrder = ordersService.adminGetOrderByStatus(type);	
						req.setAttribute("type", type);
					}else {
						int type = 0;
						listOrder = ordersService.getAllOrder();
						req.setAttribute("type", type);
					}
					/*
					 * String excelFilePath = "D:\\JSP-Project\\workspace\\order.xlsx"; new
					 * ExportToExcel().export(listOrder, excelFilePath);
					 */
					req.setAttribute("listOrder", listOrder);
					req.getRequestDispatcher("adminManageOrders.jsp").forward(req, resp);
				}else
					resp.sendRedirect("home");
				break;
			case "/adminManagePromo":
				PromoService promoService = new PromoService();
				List<Promo> listPromo;
				HttpSession session3 = req.getSession(true);
				if(session3.getAttribute("roleAdmin") != null) {
					String key = req.getParameter("key");
					if(key != null && !key.isEmpty()) {
						listPromo = promoService.getAllPromo();
					}else {
						listPromo = promoService.getAllPromo();
					}
					req.setAttribute("listPromo", listPromo);
					req.getRequestDispatcher("adminManagePromo.jsp").forward(req, resp);
				}else 
					resp.sendRedirect("home");
				break;
		}
	}
}
