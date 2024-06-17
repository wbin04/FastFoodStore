package api;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import common.Constant;
import model.Decrypt;
import payload.ResponseData;
import service.UsersService;


@WebServlet(urlPatterns = {Constant.URL_USER_UPDATE, Constant.URL_USER_CHANGEPASS, Constant.URL_USER_GETEMAIL, Constant.URL_USER_GETUSERNAME, Constant.URL_USER_UPDATEROLE})
public class UserApi extends HttpServlet{
	private Gson gson = new Gson();
	private UsersService userService= new UsersService();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String urlPath = req.getServletPath();
		switch(urlPath) {
			case Constant.URL_USER_UPDATE:
				changeUserDetail(req, resp);
				break;
			case Constant.URL_USER_CHANGEPASS:
				changePassword(req, resp);
				break;
			case Constant.URL_USER_GETEMAIL:
				checkEmail(req, resp);
				break;
			case Constant.URL_USER_GETUSERNAME:
				checkUsername(req, resp);
				break;
			case Constant.URL_USER_UPDATEROLE:
				changeRole(req, resp);
				break;
		}
	}
	
	private void changeUserDetail(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String fullname = req.getParameter("fullname");
		String phoneNumber = req.getParameter("phoneNumber");
		String address = req.getParameter("address");
		HttpSession session = req.getSession(true);
		boolean isSuccess = false;
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			isSuccess = userService.updateUserDetail(userId, fullname, phoneNumber, address) > 0 ? true : false;
		}
		ResponseData data= new ResponseData();
		data.setSuccess(isSuccess);
		data.setDescription("");
		data.setData("");
		String json = gson.toJson(data);
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
	
	private void changePassword(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		HttpSession session = req.getSession(true);
		String oldPassword = Decrypt.SHA1(req.getParameter("oldPassword"));
		String newPassword = req.getParameter("newPassword");
		String newPasswordAgain = req.getParameter("newPasswordAgain");
		String newPassword_mh = Decrypt.SHA1(req.getParameter("newPassword"));
		
		boolean isSuccess = false;
		ResponseData data= new ResponseData();
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			if(!userService.getOldPassword(userId).equals(oldPassword)) {
				data.setSuccess(false);
				data.setDescription("Sai mật khẩu");
				data.setData("");
			}else {
				isSuccess = userService.updatePassword(userId, newPassword_mh) > 0 ? true : false;
				System.out.println("OK");
				data.setSuccess(isSuccess);
				data.setDescription("");
				data.setData("");
			}
		}
		String json = gson.toJson(data);
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
	
	private void changeRole(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		HttpSession session = req.getSession(true);
		int userId = Integer.parseInt(req.getParameter("userId"));
		int roleId = Integer.parseInt(req.getParameter("roleId"));
		boolean isSuccess = false;
		ResponseData data= new ResponseData();
		if(session.getAttribute("roleAdmin") != null) {
			isSuccess = userService.updateRole(userId, roleId) > 0 ? true : false;
			data.setSuccess(isSuccess);
			data.setDescription("");
			data.setData("");
		}
		String json = gson.toJson(data);
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
	
	private void checkUsername(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		HttpSession session = req.getSession(true);
		String username = req.getParameter("username");
		boolean isSuccess = false;
		ResponseData data= new ResponseData();
		if(userService.checkUsernameExists(username)) {
			System.out.println("username existed");
			data.setSuccess(false);
			data.setDescription("Tài khoản đã tồn tại");
			data.setData("");
		}else {
			data.setSuccess(true);
			data.setDescription("");
			data.setData("");
		}
		String json = gson.toJson(data);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
	
	private void checkEmail(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		HttpSession session = req.getSession(true);
		String email = req.getParameter("email");
		boolean isSuccess = false;
		ResponseData data= new ResponseData();
		if(userService.checkEmailExists(email)) {
			System.out.println("Email existed");
			data.setSuccess(false);
			data.setDescription("Email đã tồn tại");
			data.setData("");
		}else {
			data.setSuccess(true);
			data.setDescription("");
			data.setData("");
		}
		String json = gson.toJson(data);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
}
