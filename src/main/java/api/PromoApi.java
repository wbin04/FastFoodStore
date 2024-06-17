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
import payload.ResponseData;
import service.PromoService;

@WebServlet(urlPatterns = {Constant.URL_PROMO_ADD, Constant.URL_PROMO_DELETE, Constant.URL_PROMO_EDIT})
public class PromoApi extends HttpServlet{
	private Gson gson = new Gson();
	private PromoService promoService = new PromoService();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String urlPath = req.getServletPath();
		switch(urlPath) {
			case Constant.URL_PROMO_ADD:
				addPromo(req, resp);
				break;
			case Constant.URL_PROMO_DELETE:
				deletePromo(req, resp);
				break;
			case Constant.URL_PROMO_EDIT:
				EditPromo(req, resp);
				break;
		}
	}
	
	private void addPromo(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String id = req.getParameter("id");
		int discount = Integer.parseInt(req.getParameter("discount"));
		double minimumPay = Double.parseDouble(req.getParameter("minimumPay"));
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		
		HttpSession session = req.getSession(true);
		if(session.getAttribute("roleAdmin") != null) {
			boolean isSuccess = promoService.addPromo(id, discount, minimumPay, startDate, endDate) > 0 ? true: false;
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
	}
	
	private void deletePromo(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String promoId = req.getParameter("promoId");

		HttpSession session = req.getSession(true);
		if(session.getAttribute("roleAdmin") != null) {
			boolean isSuccess = promoService.deletePromo(promoId) > 0 ? true: false;
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
	}
	private void EditPromo(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String promoId = req.getParameter("id");
		int discount = Integer.parseInt(req.getParameter("discount"));
		double minimumPay = Double.parseDouble(req.getParameter("minimumPay"));
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");

		HttpSession session = req.getSession(true);
		if(session.getAttribute("roleAdmin") != null) {
			boolean isSuccess = promoService.editPromo(promoId, discount, minimumPay, startDate, endDate) > 0 ? true: false;
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
	}
}
