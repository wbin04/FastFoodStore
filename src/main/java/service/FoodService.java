package service;

import java.util.List;

import model.Food;
import repository.FoodRepository;

public class FoodService {
	private FoodRepository foodRepository = new FoodRepository();
	public List<Food> getAll(){
		return foodRepository.getAll();
	}
	
	public List<Food> searchByName(String key){
		return foodRepository.searchByName(key);
	}
	
	public List<Food> getByCatID(int id){
		return foodRepository.getByCatID(id);
	}
	
	public Food getFoodById(int id) {
		return foodRepository.getFoodById(id);
	}
	
	public List<Food> getBestSellerFood(){
		return foodRepository.getBestSellerFood();
	}
	
	public int deleteFoodById(int id) {
		return foodRepository.deleteFoodById(id);
	}
	
	public int insertFood(String title, String desc, int price, String image, String availability, int cateId) {
		return foodRepository.insertFood(title, desc, price, image, availability, cateId);
	}
	
	public List<Food> searchFood(String text){
		return foodRepository.searchFood(text);
	}
	
	public int updateFoodDetail(int foodId, String title, String desc, int price, String image, int cateId) {
		return foodRepository.updateFoodDetail(foodId, title, desc, price, image, cateId);
	}
	
	public int updateFoodAvailability(int foodId, String availability) {
		return foodRepository.updateFoodAvailability(foodId, availability);
	}
	
	public List<Integer> getFoodIdsByUserId(int userId, int orderId) {
		return foodRepository.getFoodIdsByUserId(userId, orderId);
	}
	
}
