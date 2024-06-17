package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/adminAddVoucher")
public class AdminAddVoucher extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session1 = req.getSession(true);
		if(session1.getAttribute("roleAdmin") != null) {
			req.getRequestDispatcher("adminAddVoucher.jsp").forward(req, resp);
		}else
			resp.sendRedirect("home");
	}
}
