package api;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.Constant;
import model.RatingDetail;
import model.RatingFood;
import service.RatingService;

@WebServlet(urlPatterns = {Constant.URL_RATING_GET})
public class RatingApi extends HttpServlet{
	private Gson gson = new Gson();
	private RatingService rd = new RatingService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String urlPath = req.getServletPath();
		switch(urlPath) {
			case Constant.URL_RATING_GET:
				getRatingFood(req, resp);
				break;
		}
	}
	
	private void getRatingFood(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int foodId = Integer.parseInt(req.getParameter("foodId"));
		List<RatingDetail> listRating = rd.getAllRatingDetailByFoodId(foodId);
		String json = gson.toJson(listRating);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
}
