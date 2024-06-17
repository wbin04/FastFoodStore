package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Decrypt;
import model.Users;
import service.UsersService;

@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(true);
		if(session.getAttribute("account") != null) {
			resp.sendRedirect("home");
		}
		else
			req.getRequestDispatcher("Login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String u = req.getParameter("user");
		String p_mh = Decrypt.SHA1(req.getParameter("pass"));
		String p_cmh = req.getParameter("pass");
		String r = req.getParameter("rem");
		UsersService usd = new UsersService();
		Users us = usd.getAccount(u, p_mh);
		if (us == null) {
			String er = "Tài khoản hoặc mật khẩu sai!";
			req.setAttribute("error", er);
			req.getRequestDispatcher("Login.jsp").forward(req, resp);
		} else {
			HttpSession session = req.getSession(true);
			session.setAttribute("account", us.getFullname());
			session.setAttribute("userId", us.getId());
			session.setAttribute("email", us.getEmail()); 
			Cookie cu = new Cookie("user", u);
			Cookie cp = new Cookie("pass", p_cmh);
			Cookie cr = new Cookie("rem", r);
			if(r == null)
			{
				cu.setMaxAge(0);
				cp.setMaxAge(0);
				cr.setMaxAge(0);
			}
			else
			{
				cu.setMaxAge(24*60*60);
				cp.setMaxAge(24*60*60);
				cr.setMaxAge(24*60*60);
			}
			resp.addCookie(cu);
			resp.addCookie(cp);
			resp.addCookie(cr);
			if(us.getRoleId() == 1)
				resp.sendRedirect("home");
			else if(us.getRoleId() == 2) {
				session.setAttribute("roleAdmin", 2);
				resp.sendRedirect("adminManageUser");
			}
				
		}
	}
}