package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Promo;
import service.PromoService;

@WebServlet(urlPatterns = "/adminEditVoucher")
public class AdminEditVoucher extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PromoService promoService = new PromoService();
		// TODO Auto-generated method stub
		HttpSession session1 = req.getSession(true);
		if(session1.getAttribute("roleAdmin") != null) {
			if(req.getParameter("id")!= null) {
				String promoId = req.getParameter("id");
				Promo p = promoService.getPromoById(promoId);
				req.setAttribute("promo", p);
			}
			req.getRequestDispatcher("adminEditVoucher.jsp").forward(req, resp);
		}else
			resp.sendRedirect("home");
	}
}
