package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.*;

import model.Cart;
import model.Food;
import model.Item;
import service.CartService;
import service.FoodService;

@WebServlet(urlPatterns = "/home")
public class HomeServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FoodService fd = new FoodService();
		CartService cartService = new CartService();
		List<Food> listBestSellerFood = fd.getBestSellerFood();

		HttpSession session = req.getSession(true);
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			Cart cart = cartService.getCartByUserId(userId);
			List<Item> listItem = cartService.getItemFood(cart.getId());
			req.setAttribute("listItem", listItem);
			int soLuong = cartService.getCartTotalQuantity(cart.getId());
			req.setAttribute("cartSize", soLuong);
		}
		req.setAttribute("listBestSellerFood", listBestSellerFood);
		req.getRequestDispatcher("home1.jsp").forward(req, resp);
	}	
}
