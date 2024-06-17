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

import model.Decrypt;
import model.Users;
import payload.ResponseData;
import service.ForgotPasswordService;
import util.Email;
import util.EmailUtils;

@WebServlet(urlPatterns = "/resetPass")

public class ForgotPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();
	public ForgotPasswordController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
//		request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mail = request.getParameter("mail");
		String code = request.getParameter("code");
		String pass = Decrypt.SHA1(request.getParameter("pass"));
		HttpSession session = request.getSession();
		int randomNumber = (int) session.getAttribute("randomNumber");
		ResponseData data = new ResponseData();
		if (!String.valueOf(randomNumber).equals(code)) {
			String er = "Mã xác thực không đúng, vui lòng kiểm tra lại!";
			data.setSuccess(false);
			data.setDescription(er);
			data.setData("");
			String json = gson.toJson(data);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter p = response.getWriter();
			p.print(json);
			p.flush();
			//request.getRequestDispatcher("Login.jsp").forward(request, response); 
		}
		else
		{
			ForgotPasswordService fg = new ForgotPasswordService();
			fg.Edit_Pass(pass, mail);
			data.setSuccess(true);
			data.setDescription("Đổi mật khẩu thành công");
			data.setData("");
			String json = gson.toJson(data);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter p = response.getWriter();
			p.print(json);
			p.flush();
		}
		
	}
}
