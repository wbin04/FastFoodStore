package model;

import java.util.Date;

public class Users {
	private int id;
	private String fullname;
	private String username;
	private String password;
	private String email;
	private String address;
	private String phoneNumber;
	private Date createdDate;
	private int roleId;
	
	public Users() {
	}
	
	public Users(int id, String fullname, String username, String password, String email, String address, String phoneNumber, Date createdDate, int roleId) {
		this.id = id;
		this.fullname = fullname;
		this.username = username;
		this.password= password;
		this.email = email;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.createdDate = createdDate;
		this.roleId = roleId;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	
}
