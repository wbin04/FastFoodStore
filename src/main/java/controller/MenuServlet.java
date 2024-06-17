package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.Cart;
import model.Category;
import model.Food;
import model.Item;
import model.Items;
import service.CartService;
import service.CategoryService;
import service.FoodService;

import java.io.IOException;
import java.util.*;

@WebServlet(urlPatterns = "/menu")
public class MenuServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		CategoryService cdb = new CategoryService();
		List<Category> listCate = cdb.getAll();
		req.setAttribute("listCate", listCate);
		CartService cartService = new CartService();
		FoodService fd = new FoodService();
		HttpSession session = req.getSession(true);
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			Cart cart = cartService.getCartByUserId(userId);
			List<Item> listItem = cartService.getItemFood(cart.getId());
			req.setAttribute("listItem", listItem);
			cartService.updateTotalMoney(cart.getId());
			int soLuong = cartService.getCartTotalQuantity(cart.getId());
			req.setAttribute("cartSize", soLuong);
		}
		
		String text = req.getParameter("key");
        List<Food> listFood;
        if (text != null && !text.isEmpty()) {
            listFood = fd.searchFood(text);
        }else {
            String id_raw = req.getParameter("id");
            int id;
            if (id_raw == null) {
                id = 0;
            } else {
                id = Integer.parseInt(id_raw);
            }
            listFood = fd.getByCatID(id);
        }
        req.setAttribute("listFood", listFood);
		req.getRequestDispatcher("menu1.jsp").forward(req, resp);
	}
}
