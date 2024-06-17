package model;

import java.util.Date;

public class Orders {
	private int id;
	private String createdDate;
	private int totalMoney;
	private String orderStatus;
	private String note;
	private String paymentMethod;
	private String receiverName;
	private String shipAddress;
	private String phoneNumber;
	private int userId;
	private String promoId;
	
	public Orders() {
		// TODO Auto-generated constructor stub
	}
	public Orders(int id, String createdDate, int totalMoney, String orderStatus, String note, String paymentMethod, String receiverName, String shipAddress, String phoneNumber, int userId, String promo_id) {
		this.id = id;
		this.createdDate = createdDate;
		this.totalMoney = totalMoney;
		this.orderStatus = orderStatus;
		this.note = note;
		this.userId = userId;
		this.paymentMethod = paymentMethod;
		this.receiverName = receiverName;
		this.shipAddress = shipAddress;
		this.phoneNumber = phoneNumber;
		this.promoId = promo_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public int getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(int totalMoney) {
		this.totalMoney = totalMoney;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public String getShipAddress() {
		return shipAddress;
	}
	public void setShipAddress(String shipAddress) {
		this.shipAddress = shipAddress;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getPromoId() {
		return promoId;
	}
	public void setPromoId(String promo_id) {
		this.promoId = promo_id;
	}
	
}
