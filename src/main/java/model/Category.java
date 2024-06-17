package model;

public class Category {
	private int id;
	private String cateName;
	private String image;
	
	public Category() {}
	public Category(int id, String cateName, String image) {
		this.id = id;
		this.cateName = cateName;
		this.image = image;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
