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
import model.RatingDetail;
import model.RatingFood;
import service.RatingService;

@WebServlet(urlPatterns = "/ManageRatingFood")
public class AdminManageRatingFood extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(true);
		if(session.getAttribute("roleAdmin") != null) {
			RatingService rd = new RatingService();
			int foodId = Integer.parseInt(req.getParameter("foodId"));
			List<RatingDetail> listRatingDetail = rd.getAllRatingDetailByFoodId(foodId);
			req.setAttribute("listRatingDetail", listRatingDetail);
			int arrStar[] = rd.getArrStar(listRatingDetail);
			req.setAttribute("idFood", foodId);
			req.setAttribute("arr1Star", arrStar[0]);
			req.setAttribute("arr2Star", arrStar[1]);
			req.setAttribute("arr3Star", arrStar[2]);
			req.setAttribute("arr4Star", arrStar[3]);
			req.setAttribute("arr5Star", arrStar[4]);
			req.setAttribute("ratingQuantity", arrStar[5]);
			req.setAttribute("totalStar", arrStar[6]);
			req.getRequestDispatcher("adminManageRatingFood.jsp").forward(req, resp);
		}
		else resp.sendRedirect("home");
	}
}
