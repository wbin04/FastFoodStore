package service;

import java.util.List;

import model.RatingDetail;
import model.RatingFood;
import repository.RatingRepository;

public class RatingService {
	private RatingRepository ratingRepository = new RatingRepository();
	public List<RatingFood> getAllRatingByFoodId(int foodId){
		return ratingRepository.getAllRatingByFoodId(foodId);
	}
	public List<RatingDetail> getAllRatingDetailByFoodId(int foodId){
		return ratingRepository.getAllRatingDetailByFoodId(foodId);
	}
	public void insertRating(int user_id, int food_id, String content, double point, int order_id) {
		ratingRepository.insertRating(user_id, food_id, content, point, order_id);
	}
	
	public boolean checkRating(int user_id, int order_id, int food_id) {
		return ratingRepository.checkRating(user_id, order_id, food_id);
	}
	public List<Integer> getRatedProducts(int userId, int orderId) {
		return ratingRepository.getRatedProducts(userId, orderId);
	}
	public int[] getArrStar(List<RatingDetail> listRatingDetail) {
		int arrStar[] = new int[7];
		for(RatingDetail rdt : listRatingDetail) {
			arrStar[5]++; // arrStar[5] là số lượng rating
			arrStar[6] += rdt.getPoint(); // arrStar[6] là số lượng sao 
			if(rdt.getPoint() == 1)
				arrStar[0]++;
			else if(rdt.getPoint() == 2)
				arrStar[1]++;
			else if(rdt.getPoint() == 3)
				arrStar[2]++;
			else if(rdt.getPoint() == 4)
				arrStar[3]++;
			else if(rdt.getPoint() == 5)
				arrStar[4]++;
		}
		return arrStar;
	}
	
}
