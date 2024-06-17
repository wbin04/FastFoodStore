package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.Constant;

@WebServlet(urlPatterns = {Constant.URL_VNPAY_SUCCESS, Constant.URL_VNPAY_FAILED})
public class PaymentStatus extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String urlPath = req.getServletPath();
		HttpSession session = req.getSession(true);
		switch(urlPath) {
			case Constant.URL_VNPAY_SUCCESS:
				if(session.getAttribute("userId") != null)
					req.getRequestDispatcher("paymentSuccess.jsp").forward(req, resp);
				else resp.sendRedirect("home");
				break;
			case Constant.URL_VNPAY_FAILED:
				if(session.getAttribute("userId") != null)
					req.getRequestDispatcher("paymentFailed.jsp").forward(req, resp);
				else resp.sendRedirect("home");
				break;
		}
	}
}
