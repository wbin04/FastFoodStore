package api;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeUtility;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import common.Constant;
import model.Cart;
import model.Item;
import model.Items;
import payload.ResponseData;
import service.CartService;
import service.OrdersService;
import util.Email;

@WebServlet(urlPatterns = {Constant.URL_ORDER_ADD, Constant.URL_ORDER_CHANGE_STATUS, Constant.URL_ORDER_GET, Constant.URL_ORDER_FILTER, Constant.URL_ORDER_VNPAYPAYMENT,
		Constant.URL_ORDER_GETCURRENTWEEK, Constant.URL_ORDER_GETCURRENTYEAR, Constant.URL_ORDER_GETLASTWEEK, Constant.URL_ORDER_GETLASTYEAR,  Constant.URL_ORDER_GETDISCOUNT})
public class OrderApi extends HttpServlet{
	private Gson gson = new Gson();
	private CartService cd = new CartService();
	private OrdersService od = new OrdersService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String urlPath = req.getServletPath();
		switch(urlPath) {
			case Constant.URL_ORDER_GET:
				try {
					getOrder(req, resp);
				} catch (IOException e) {
					e.printStackTrace();
				} catch (ParseException e) {
					e.printStackTrace();
				}
				break;
			case Constant.URL_ORDER_GETCURRENTWEEK:
				getCurrentWeekOrder(req, resp);
				break;
			case Constant.URL_ORDER_GETCURRENTYEAR:
				getCurrentYearOrder(req, resp);
				break;
			case Constant.URL_ORDER_GETLASTWEEK:
				getLastWeekOrder(req, resp);
				break;
			case Constant.URL_ORDER_GETLASTYEAR:
				getLastYearOrder(req, resp);
				break;
			case Constant.URL_ORDER_FILTER:
				getFilterDetail(req, resp);
				break;
			case Constant.URL_ORDER_VNPAYPAYMENT:
				//sendEmailPayment(req, resp, "VNPAY", "Đơn hàng của bạn đã được xác nhận và đang trong quá trình vận chuyển! ", 15000);
				addOrderVNPay(req, resp);
				break;
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String urlPath = req.getServletPath();
		switch(urlPath) {
			case Constant.URL_ORDER_ADD:
				addOrder(req, resp);
				sendEmailPayment(req, resp, "COD", "", 15000);
				break;
			/*
			 * case Constant.URL_ORDER_GETDISCOUNT: sendEmailPayment(req, resp, "VNPAY",
			 * "Đơn hàng của bạn đã được xác nhận và đang trong quá trình vận chuyển! ",
			 * 15000); break;
			 */	
			case Constant.URL_ORDER_CHANGE_STATUS:
				String status = req.getParameter("status");
				System.out.println(status + " HHHHH");
				if (status.equals("Đang vận chuyển")) {
					sendMailConfirmStatus(req, resp, "Đơn hàng của bạn đã được xác nhận và đang trong quá trình vận chuyển!");
					changeStatus(req, resp);
				} else {
					sendMailConfirmStatus(req, resp, "Đơn hàng của bạn đã hoàn thành! Cảm ơn đã sử dụng dịch vụ của chúng tôi!");
					changeStatus(req, resp);
				}
				break;
		}
	}
	
	private void addOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String note = req.getParameter("note");
		int totalCost = Integer.parseInt(req.getParameter("totalCost"));
		String paymentMethod = req.getParameter("paymentMethod");
		String receiverName = req.getParameter("receiverName");
		String shipAddress = req.getParameter("shipAddress");
		String phoneNumber = req.getParameter("phoneNumber");
		String idPromo = req.getParameter("idPromo");
		HttpSession session = req.getSession(true);
		Cart cart = null;
		boolean isSuccess = false;
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			cart = cd.getCartByUserId(userId);
			List<Items> listItem = cd.getItemByCartId(cart.getId());
			isSuccess = od.addOrder(userId, totalCost,  note, "Chờ xác nhận", paymentMethod, receiverName, shipAddress, phoneNumber , idPromo)> 0 ? true : false;
			for(Items i : listItem) {
				if(i.getCartId() == cart.getId()) {
					cd.delItemFromCart(cart.getId(), i.getFoodId());
				}
			}
			
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
	
	private void addOrderVNPay(HttpServletRequest req, HttpServletResponse resp) throws IOException{	
		HttpSession session = req.getSession(true);
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
		
		Cart cart = null;
		boolean isSuccess = false;
		
		if(session.getAttribute("userId") != null) {
			int userId = (Integer)session.getAttribute("userId");
			if(vnp_ResponseCode.equals("00")) {
				String note = req.getParameter("note");
				String paymentMethod = req.getParameter("paymentMethod");
				String receiverName = (String)session.getAttribute("NewReceiverName");
				String shipAddress = (String)session.getAttribute("NewShipAddress");
				String phoneNumber = (String)session.getAttribute("NewPhoneNumber");
				int totalCost = (Integer)session.getAttribute("TotalCost");
				String idPromo = (String)session.getAttribute("idPromo");
				cart = cd.getCartByUserId(userId);
				List<Items> listItem = cd.getItemByCartId(cart.getId());
				isSuccess = od.addOrder(userId, totalCost, note, "Đang vận chuyển", paymentMethod, receiverName, shipAddress, phoneNumber, idPromo)> 0 ? true : false;
				sendEmailPayment(req, resp, "VNPAY", "Đơn hàng của bạn đã được xác nhận và đang trong quá trình vận chuyển! ", 15000);
				for(Items i : listItem) {
					if(i.getCartId() == cart.getId()) {
						cd.delItemFromCart(cart.getId(), i.getFoodId());
					}
				}
				
				resp.sendRedirect("http://localhost:8080/FastFood/payment-success");
			}
			else {
				resp.sendRedirect("http://localhost:8080/FastFood/payment-failed");
			}
			session.removeAttribute("NewReceiverName");
			session.removeAttribute("NewShipAddress");
			session.removeAttribute("NewPhoneNumber");
			session.removeAttribute("TotalCost");
			session.removeAttribute("idPromo");
			
		}
	}
	
	private void changeStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String status = req.getParameter("status");
		int orderId = Integer.parseInt(req.getParameter("orderId"));
		String note = req.getParameter("note");
		HttpSession session = req.getSession(true);
		boolean isSuccess = false;
		if(session.getAttribute("userId") != null) {
			isSuccess = od.changeOrderStatus(orderId, status, note) > 0 ? true : false;
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
	
	private void getOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException, ParseException {
		String date = req.getParameter("date");
		System.out.println(date);
		Map<String, Integer> orderMoney = od.getLast7DaysRevenue(date); 
		String json = gson.toJson(orderMoney);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
	
	private void getCurrentWeekOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int[] curWeek = od.getCurrentWeekRevenue();
		String json = gson.toJson(curWeek);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
	private void getLastWeekOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int[] lastWeek = od.getLastWeekRevenue();
		String json = gson.toJson(lastWeek);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
	private void getCurrentYearOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int[] curYear = od.getCurrentYearRevenue();
		String json = gson.toJson(curYear);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
	private void getLastYearOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		int[] lastYear = od.getLastYearRevenue();
		String json = gson.toJson(lastYear);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
	    out.print(json);
	    out.flush();
	}
	private void getFilterDetail(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		String date = req.getParameter("date");
		int[] listFil = new int[4];
		listFil[0] = od.countFoodHasSold(date);
		listFil[1] = od.countUser(date);
		listFil[2] = od.countOrders(date);
		listFil[3] = od.calTotalRevenue(date);
		String json = gson.toJson(listFil);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter p = resp.getWriter();
		p.print(json);
		p.flush();
	}
	public void sendEmailPayment(HttpServletRequest req, HttpServletResponse resp, String paymentMethod, String txt,
			double baseTotal) throws IOException {
		HttpSession session = req.getSession(true);
		String email = (String) session.getAttribute("email");
		Cart cart = null;
		if (session.getAttribute("userId") != null) {
			int userId = (Integer) session.getAttribute("userId");
			cart = cd.getCartByUserId(userId);
		}
		// List<Item> listItem = cd.getItemFood(cart.getId());
		List<Item> listItem = od.getItemLine(od.getNewestOrder().getId());
		double billTotal = baseTotal;

		String itemsOrdered = "";
		for (Item i : listItem) {
			itemsOrdered += String.valueOf(i.getQuantity()) + "x " + String.valueOf(i.getTitle()) + "  |  ";
			billTotal += i.getQuantity() * i.getPrice();
		}
		int totalCost = od.getNewestOrder().getTotalMoney();
		String discountStr = req.getParameter("discount");
		System.out.println(discountStr);
		double promo = 0;
		if (discountStr != null && !discountStr.isEmpty()) {
			try {
				promo = Double.parseDouble(discountStr);
			} catch (NumberFormatException e) {
				promo = 0;
				System.err.println("Invalid discount value: " + discountStr);
			}
		}
		double billlast = billTotal - promo;
		System.out.println("promo: " + promo);
		
		String result = String.valueOf(totalCost) + " VND";
		String subject = "THÔNG BÁO XÁC NHẬN THÔNG TIN ĐẶT HÀNG - FASTFOOD STORE";
		String message = "<p>Cảm ơn bạn đã đặt hàng. Dưới đây là thông tin về đơn hàng của bạn:</p>" + "<p>"
				+ itemsOrdered.replace("\n", "<br>") + "</p>" + "<p>Tổng tiền phải thanh toán bằng phương thức " + paymentMethod
				+ ": " + result + "</p>" + "<p>" + txt + "Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi! Chúc bạn một ngày tốt lành!</p>";
				try {
					subject = MimeUtility.encodeText(subject, "UTF-8", "B");
				} catch (Exception e) {
					e.printStackTrace();
				}
		// System.out.println(subject);	
		Email.sendEmail(email, subject, message);
	}

	public void sendMailConfirmStatus(HttpServletRequest req, HttpServletResponse resp, String mgs) throws IOException {
		HttpSession session = req.getSession(true);
		int orderId = Integer.parseInt(req.getParameter("orderId"));
		String email = od.getEmailByOrderId(orderId);
		if (session.getAttribute("userId") != null) {
			int userId = (Integer) session.getAttribute("userId");
			List<Item> listItem = od.getItemLine(orderId);
			double orderTotal = 15000;
			String itemsOrdered = "";
			for (Item i : listItem) {
				itemsOrdered += String.valueOf(i.getQuantity()) + "x " + String.valueOf(i.getTitle()) + "  |  ";
				orderTotal += i.getQuantity() * i.getPrice();
			}
			int totalCost = od.getOrdersByOrderId(orderId).getTotalMoney();
			String result = String.valueOf(totalCost) + " VND";
			String subject = "THÔNG BÁO TRẠNG THÁI ĐƠN HÀNG - FASTFOOD STORE";
			String message = "<p>Thông tin đơn hàng:</p>" + "<p>" + itemsOrdered.replace("\n", "<br>") + "</p>"
					+ "<p>Tổng tiền: " + result + "</p>" + "<p> " + mgs + " Chúc bạn một ngày tốt lành!</p>";

			try {
				subject = MimeUtility.encodeText(subject, "UTF-8", "B");
			} catch (Exception e) {
				e.printStackTrace();
			}
			// System.out.println(subject);
			Email.sendEmail(email, subject, message);
		}
	}
}
