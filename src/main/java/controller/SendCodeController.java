package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import payload.ResponseData;
import service.UsersService;
import util.Email;

@WebServlet(urlPatterns = "/sendcode")
/**
 * Servlet implementation class SendCodeController
 */
public class SendCodeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
      private UsersService userDAO = new UsersService();
      private Gson gson = new Gson();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendCodeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("Login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("mail");
		
		HttpSession session = req.getSession(true);
		boolean isSuccess = false;
		isSuccess = userDAO.checkEmailExists(email);
		ResponseData data= new ResponseData();
		if(isSuccess == false) {
			data.setSuccess(isSuccess);
			data.setDescription("Email này không chính xác");
			data.setData("");
		}
		else {
			Random rand = new Random();
			int randomNumber = rand.nextInt(900001) + 100000;
			Email.sendEmail(email, "MA XAC THUC DOI MAT KHAU - FASTFOOD SHOP", randomNumber + "");
		    session.setAttribute("randomNumber", randomNumber);
		    data.setSuccess(isSuccess);
			data.setDescription("Email được gửi thành công");
			data.setData("");
			//req.getRequestDispatcher("Login.jsp").forward(req, resp);
		}
		String json = gson.toJson(data);
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
}
