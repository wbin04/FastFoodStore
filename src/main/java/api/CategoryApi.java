package api;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.Constant;
import model.Category;
import service.CategoryService;

@WebServlet(urlPatterns = {Constant.URL_CATEGORY_GETREVENUE, Constant.URL_CATEGORY_GETCATENAME})
public class CategoryApi extends HttpServlet{
	private Gson gson = new Gson();
	private CategoryService cateService= new CategoryService();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String urlPath = req.getServletPath();
		switch(urlPath) {
			case Constant.URL_CATEGORY_GETREVENUE:
				getMonthRevenue(req, resp);
				break;
			case Constant.URL_CATEGORY_GETCATENAME:
				getAllCate(req, resp);
				break;
		}
	}
	
	private void getAllCate(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		List<Category> listCate = cateService.getAll();
		List<String> listCateName = new ArrayList<String>();
		for(Category c : listCate) {
			listCateName.add(c.getCateName());
		}
		String json = gson.toJson(listCateName);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
	
	private void getMonthRevenue(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int[] listCateRev = cateService.getCategoryRevenue();
		String json = gson.toJson(listCateRev);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
}
