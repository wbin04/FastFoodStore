package service;

import java.util.List;

import model.Category;
import repository.CategoryRepository;

public class CategoryService {
	private CategoryRepository categoryRepository = new CategoryRepository();
	public List<Category> getAll(){
		return categoryRepository.getAll();
	}
	
	public int[] getCategoryRevenue() {
		return categoryRepository.getCategoryRevenue();
	}
	
}
