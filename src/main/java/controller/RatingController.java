package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CartService;
import service.FoodService;
import service.RatingService;

@WebServlet(urlPatterns = "/ratingf")
public class RatingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RatingService rt = new RatingService();
    public RatingController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession(true);
		RatingService rt = new RatingService();

		if (session.getAttribute("userId") != null) {

			String[] selectedProducts = request.getParameterValues("selectedProducts[]");
			int order_id = Integer.parseInt(request.getParameter("orderId"));
			List<Integer> selectedProductIds = new ArrayList<>();
			if (selectedProducts != null) {
				for (String i : selectedProducts) {
					selectedProductIds.add(Integer.parseInt(i));
				}
			}

			int userId = (Integer) session.getAttribute("userId");
			String content = request.getParameter("content");
			double rating = 5.0;
			if (request.getParameter("rating") != null) {
				rating = Double.parseDouble(request.getParameter("rating"));
			}

			for (Integer productId : selectedProductIds) {
				if (!rt.checkRating(userId, order_id, productId)) {
					rt.insertRating(userId, productId, content, rating, order_id);
				}
			}
			
			System.out.println(selectedProductIds);
			System.out.println(rating + " " + userId + " " + content);
		}
	}
}
