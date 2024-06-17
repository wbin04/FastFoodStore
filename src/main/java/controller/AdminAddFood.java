package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Category;
import service.CategoryService;

@WebServlet(urlPatterns = "/adminAddFood")
public class AdminAddFood extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		CategoryService cateService = new CategoryService();
		List<Category> listCate = cateService.getAll();
		HttpSession session1 = req.getSession(true);
		if(session1.getAttribute("roleAdmin") != null) {
			req.setAttribute("listCate", listCate);
			req.getRequestDispatcher("adminAddFood.jsp").forward(req, resp);
		}else
			resp.sendRedirect("home");
		
	}
}
