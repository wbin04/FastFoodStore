package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Users;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			// TODO Auto-generated method stub
		HttpSession session = req.getSession(true);
		if(session.getAttribute("account") != null)
		{
			session.removeAttribute("account");
			session.removeAttribute("userId");
			if(session.getAttribute("roleAdmin") != null)
				session.removeAttribute("roleAdmin");
		}
		resp.sendRedirect("home");
		}
}
