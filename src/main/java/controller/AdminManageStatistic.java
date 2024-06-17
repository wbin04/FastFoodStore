package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Food;
import service.FoodService;

@WebServlet(urlPatterns = "/adminManageStatistic")
public class AdminManageStatistic extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession(true);
		if(session.getAttribute("roleAdmin") != null) {
			FoodService fd = new FoodService();
			List<Food> listBestSellerFood = fd.getBestSellerFood();
			req.setAttribute("listBestSellerFood", listBestSellerFood);
			req.getRequestDispatcher("adminManageStatistic.jsp").forward(req, resp);
		}else
			resp.sendRedirect("home");
		
	}
}
