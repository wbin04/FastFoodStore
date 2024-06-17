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
import payload.ResponseData;
import service.FoodService;

@WebServlet(urlPatterns = {Constant.URL_FOOD_ADD, Constant.URL_FOOD_DELETE, Constant.URL_FOOD_UPDATE, Constant.URL_FOOD_UPDATEAVAILABILITY})
public class FoodApi extends HttpServlet{
	private FoodService foodService = new FoodService();
	private Gson gson = new Gson();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession(true);
		if(session.getAttribute("roleAdmin") != null) {
			String urlPath = req.getServletPath();
			switch(urlPath) {
				case Constant.URL_FOOD_ADD:
					addFood(req, resp);
					break;
				case Constant.URL_FOOD_DELETE:
					deleteFood(req, resp);
					break;
				case Constant.URL_FOOD_UPDATE:
					updateFood(req, resp);
					break;
				case Constant.URL_FOOD_UPDATEAVAILABILITY:
					updateFoodAvailability(req, resp);
					break;
			}
		}
		else resp.sendRedirect("home");
	}
	
	private void addFood(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String title = req.getParameter("title");
		String desc = req.getParameter("desc");
		int price = Integer.parseInt(req.getParameter("price"));
		int cateId = Integer.parseInt(req.getParameter("cate"));
		String img = req.getParameter("img");
		boolean isSuccess = foodService.insertFood(title, desc, price, img, "Còn hàng", cateId) > 0 ? true : false;
		
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
	
	private void deleteFood(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int idFood = Integer.parseInt(req.getParameter("foodId"));
		boolean isSuccess = foodService.deleteFoodById(idFood) > 0 ? true : false;
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
	
	private void updateFood(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int foodId = Integer.parseInt(req.getParameter("foodId"));
		String title = req.getParameter("title");
		String desc = req.getParameter("desc");
		int price = Integer.parseInt(req.getParameter("price"));
		int cateId = Integer.parseInt(req.getParameter("cate"));
		String image = req.getParameter("image");
		boolean isSuccess = foodService.updateFoodDetail(foodId, title, desc, price, image, cateId) > 0 ? true : false;
		
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
	
	private void updateFoodAvailability(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int foodId = Integer.parseInt(req.getParameter("foodId"));
		String availability = req.getParameter("availability");
		boolean isSuccess = foodService.updateFoodAvailability(foodId, availability) > 0 ? true : false;
		
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
}
