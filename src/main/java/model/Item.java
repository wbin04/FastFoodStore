package model;

public class Item {
	private int id;
	private String title;
	private String description;
	private int price;
	private String image;
	private int cateId;
	private int quantity;
	
	
	public Item() {}
	public Item(int id, String title, String description, int price, String image, int cateId, int quantity) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.price = price;
		this.image = image;
		this.cateId = cateId;
		this.quantity = quantity;
		
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getCateId() {
		return cateId;
	}
	public void setCateId(int cateId) {
		this.cateId = cateId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

}
