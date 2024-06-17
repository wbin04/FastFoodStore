package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.MySQLConnection;
import model.Decrypt;
import model.Users;
import service.RegisterService;


@WebServlet(urlPatterns = "/signup")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RegisterService registerService = new RegisterService();
    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection conn = MySQLConnection.getConnection();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String fullname = request.getParameter("fullname");
		String username = request.getParameter("user");
		String password = Decrypt.SHA1(request.getParameter("pass"));
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String phone_number = request.getParameter("phonenumber");
		
		Users users = new Users();
		users.setFullname(fullname);
		users.setUsername(username);
		users.setPassword(password);
		users.setEmail(email);
		users.setAddress(address);
		users.setPhoneNumber(phone_number);
		boolean check = registerService.InsertAccount(conn, users);
		
		if(check)
		{
			try {
				request.setAttribute("msgregister", "Register Success");
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

}
