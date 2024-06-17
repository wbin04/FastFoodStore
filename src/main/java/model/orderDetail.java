package model;

public class orderDetail {
	private int orderId;
	private int foodId;
	private int quantity;
	private int price;
	
	public orderDetail() {}
	public orderDetail(int orderId, int foodId, int quantity, int price) {
		this.orderId = orderId;
		this.foodId = foodId;
		this.quantity = quantity;
		this.price = price;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getFoodId() {
		return foodId;
	}
	public void setFoodId(int foodId) {
		this.foodId = foodId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
}
