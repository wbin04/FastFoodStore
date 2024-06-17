package controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Cart;
import model.Item;
import model.Promo;
import model.Users;
import service.CartService;
import service.OrdersService;
import service.PromoService;
import service.UsersService;

@WebServlet(urlPatterns = "/checkout")
public class CheckOutServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		CartService cartService = new CartService();
		PromoService promoService = new PromoService();
		HttpSession session = req.getSession(true);
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			UsersService userDAO = new UsersService();
			Users users = userDAO.getUserDetail(userId);
			req.setAttribute("users", users);
			Cart cart = cartService.getCartByUserId(userId);
			List<Item> listItem = cartService.getItemFood(cart.getId());
			req.setAttribute("listItem", listItem);
			cartService.updateTotalMoney(cart.getId());
			int soLuong = cartService.getCartTotalQuantity(cart.getId());
			req.setAttribute("cartSize", soLuong);
			List<Promo> listPromo = promoService.getAvailablePromo();
			req.setAttribute("listPromo", listPromo);
			
			if(soLuong == 0) {
				resp.sendRedirect("home");
			}
			else req.getRequestDispatcher("payment.jsp").forward(req,resp);
			
		}
		else resp.sendRedirect("home");
		
	}
}
