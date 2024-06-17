package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Cart;
import model.Item;
import model.Orders;
import model.Users;
import service.OrdersService;
import service.UsersService;

@WebServlet(urlPatterns = "/accountManage")
public class AccountManage extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession(true);
		int userId = 0;
		if(session.getAttribute("userId") != null) {
			userId = (Integer)session.getAttribute("userId");
			UsersService userService = new UsersService();
			Users users = userService.getUserDetail(userId);
			req.setAttribute("users", users);
			req.getRequestDispatcher("accountManage.jsp").forward(req,resp);
		}
		else {
			resp.sendRedirect("login");
		}
		
	}
}