package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	private int id;
	private int totalMoney;
	private int user_id;
	
	public Cart() {}
	
	public Cart(int id, int totalMoney, int user_id) {
		this.id = id;
		this.totalMoney = totalMoney;
		this.user_id = user_id;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public void setTotalMoney(int totalMoney) {
		this.totalMoney = totalMoney;
	}
	public int getTotalMoney() {
		return totalMoney;
	}
	
	
	
}
