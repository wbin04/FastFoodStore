package model;

public class RatingDetail {
	private int id;
	private String fullname;
	private String username;
	private String content;
	private double point;
	private int food_id;
	
	public RatingDetail() {}
	
	public RatingDetail(int id, String fullname, String username, String content, double point, int food_id) {
		this.id = id;
		this.fullname = fullname;
		this.username = username;
		this.content = content;
		this.point = point;
		this.food_id = food_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getFood_id() {
		return food_id;
	}

	public void setFood_id(int food_id) {
		this.food_id = food_id;
	}

	public double getPoint() {
		return point;
	}

	public void setPoint(double point) {
		this.point = point;
	}
	
	
}
