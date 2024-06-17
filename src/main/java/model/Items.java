package model;

public class Items {
	
	private int quantity;
	private int cartId;
	private int foodId;
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public int getFoodId() {
		return foodId;
	}
	public void setFoodId(int foodId) {
		this.foodId = foodId;
	}
	public Items() {
		
	}
	public Items( int cartId, int foodId, int quantity) {
		this.quantity = quantity;
		this.cartId = cartId;
		this.foodId = foodId;
	}
	
	
}
