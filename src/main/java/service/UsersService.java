package service;

import java.util.List;

import model.Roles;
import model.Users;
import repository.UsersRepository;

public class UsersService {
	private UsersRepository usersRepository = new UsersRepository();
	public Users getAccount(String username, String password) {
		return usersRepository.getAccount(username, password);
	}
	public Users getUserDetail(int userId) {
		return usersRepository.getUserDetail(userId);
	}
	public List<Users> searchUser(String fullname) {
		return usersRepository.searchUser(fullname);
	}
	public int updateUserDetail(int userId, String fullname, String phone_number, String address) {
		return usersRepository.updateUserDetail(userId, fullname, phone_number, address);
	}
	public List<Users> getAllUsers() {
		return usersRepository.getAllUsers();
	}
	public int updatePassword(int userId, String newPassword){
		return usersRepository.updatePassword(userId, newPassword);
	}
	public String getOldPassword(int userId) {
		return usersRepository.getOldPassword(userId);
	}
	public int updateRole(int userId, int roleId) {
		return usersRepository.updateRole(userId, roleId);
	}
	public boolean checkUsernameExists(String username) {
		return usersRepository.checkUsernameExists(username);
	}
	public boolean checkEmailExists(String email) {
		return usersRepository.checkEmailExists(email);
	}
	public List<Roles> getListRoles(){
		return usersRepository.getListRoles();
	}

}
