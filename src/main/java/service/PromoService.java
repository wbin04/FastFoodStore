package service;

import java.util.List;

import model.Promo;
import repository.PromoRepository;

public class PromoService {
	private PromoRepository promoRepository = new PromoRepository();
	public List<Promo> getAllPromo() {
		return promoRepository.getAllPromo();
	}
	public List<Promo> getAvailablePromo(){
		return promoRepository.getAvailablePromo();
	}
	public List<Promo> getSoonPromo(){
		return promoRepository.getSoonPromo();
	}
	public Promo getPromoById(String promoId) {
		return promoRepository.getPromoById(promoId);
	}
	
	public int addPromo(String id, int discount, double minimumPay, String startDate, String endDate) {
		return promoRepository.addPromo(id, discount, minimumPay, startDate, endDate);
	}

	public int editPromo(String promoId, int discount, double minimumPay, String startDate, String endDate) {
		return promoRepository.editPromo(promoId, discount, minimumPay, startDate, endDate);
	}
	public int deletePromo(String promoId) {
		return promoRepository.deletePromo(promoId);
	}
		
}
