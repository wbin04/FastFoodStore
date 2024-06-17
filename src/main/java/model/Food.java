package model;

public class Food {
	private int id;
	private String title;
	private String description;
	private int price;
	private String image;
	private String availability;
	private int cateId;
	
	public Food() {}
	public Food(int id, String title, String description, int price, String image, String availability, int cateId) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.price = price;
		this.image = image;
		this.availability = availability;
		this.cateId = cateId;
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
	public int getCateId() {
		return cateId;
	}
	public void setCateId(int cateId) {
		this.cateId = cateId;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getAvailability() {
		return availability;
	}
	public void setAvailability(String availability) {
		this.availability = availability;
	}
	
}
