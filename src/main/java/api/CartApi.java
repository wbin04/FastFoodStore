package api;

import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import common.Constant;
import model.Cart;
import model.Item;
import model.Items;
import payload.ResponseData;
import service.CartService;

@WebServlet(urlPatterns = {Constant.URL_ITEM_ADD, Constant.URL_ITEM_DELETE, Constant.URL_ITEM_CHANGEQUANTITY, Constant.URL_ITEM_UPDATE})
public class CartApi extends HttpServlet{
	private Gson gson = new Gson();
	private CartService cd = new CartService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String urlPath = req.getServletPath();
		switch(urlPath) {
			case Constant.URL_ITEM_UPDATE:
				updateCart(req, resp);
				break;
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String urlPath = req.getServletPath();
		switch(urlPath) {
			case Constant.URL_ITEM_ADD:
				addItemToCart(req, resp);
				break;
			case Constant.URL_ITEM_DELETE:
				deleteItemFromCart(req, resp);
				break;
			case Constant.URL_ITEM_CHANGEQUANTITY:
				changeItemQuantity(req, resp);
				break;
			
		}	
	}
	
	private void addItemToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		int foodId = Integer.parseInt(req.getParameter("foodId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		boolean isSuccess = false;
		HttpSession session = req.getSession(true);
		Cart cart = null;
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			cart = cd.getCartByUserId(userId);
			isSuccess = cd.addItem(cart.getId(), foodId, quantity) > 0 ? true : false;
			if(isSuccess == true) cd.updateTotalMoney(cart.getId());
		}
		ResponseData data= new ResponseData();
		data.setSuccess(isSuccess);
		data.setDescription("");
		data.setData("");
		String json = gson.toJson(data);
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
	private void deleteItemFromCart(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int foodId = Integer.parseInt(req.getParameter("foodId"));
		HttpSession session = req.getSession(true);
		Cart cart = null;
		boolean isSuccess = false;
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			cart = cd.getCartByUserId(userId);
			isSuccess = cd.delItemFromCart(cart.getId(), foodId) > 0 ? true : false;
			if(isSuccess == true) cd.updateTotalMoney(cart.getId());
		}
		ResponseData data= new ResponseData();
		data.setSuccess(isSuccess);
		data.setDescription("");
		data.setData("");
		String json = gson.toJson(data);
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
	private void changeItemQuantity(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int foodId = Integer.parseInt(req.getParameter("foodId"));
		String deli = req.getParameter("deli");
		boolean isSuccess = false;
		HttpSession session = req.getSession(true);
		Cart cart = null;
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			cart = cd.getCartByUserId(userId);
			isSuccess = cd.updateItemQuantity(cart.getId(), foodId, deli) > 0 ? true : false;
			List<Item> listItem = cd.getItemFood(cart.getId());
			for(Item i : listItem) {
				if(i.getQuantity() == 0) {
					cd.delItemFromCart(cart.getId(), foodId);
				}
			}
		}
		
		ResponseData data= new ResponseData();
		data.setSuccess(isSuccess);
		data.setDescription("");
		data.setData("");
		String json = gson.toJson(data);
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
	private void updateCart(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		HttpSession session = req.getSession(true);
		Cart cart = null;
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			cart = cd.getCartByUserId(userId);
		}
		List<Item> listItem = cd.getItemFood(cart.getId());
		String json = gson.toJson(listItem);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
}
