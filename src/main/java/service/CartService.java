package service;

import java.util.*;

import model.Cart;
import model.Item;
import model.Items;
import repository.CartRepository;

public class CartService {
	private CartRepository cartRepository = new CartRepository();
	
	public List<Items> getItemByCartId(int cartId){
		return cartRepository.getItemByCartId(cartId);
	}
	
	public Cart getCartByUserId(int userId) {
		return cartRepository.getCartByUserId(userId);
	}
	
	public Items getItemByFoodId(int cartId, int foodId) {
		return cartRepository.getItemByFoodId(cartId, foodId);
	}
	
	public int addItem(int cartId, int foodId, int quantity) {
		return cartRepository.addItem(cartId, foodId, quantity);
	}
	
	public List<Item> getItemFood(int cartId){
		return cartRepository.getItemFood(cartId);
	}
	
	public int delItemFromCart(int cartId, int foodId) {
		return cartRepository.delItemFromCart(cartId, foodId);
	}
	
	public int updateItemQuantity(int cartId, int foodId, String deli) {
		return cartRepository.updateItemQuantity(cartId, foodId, deli);
	}
	
	public Cart getCart(int cartId) {
		return cartRepository.getCart(cartId);
	}
	
	public int updateTotalMoney(int cartId) {
		List<Item> listItem = getItemFood(cartId);
		int tong = 0;
		for(Item i : listItem) {
			tong += i.getPrice() * i.getQuantity();
		}
		return cartRepository.updateTotalMoney(tong, cartId);
	}
	public int getCartTotalQuantity(int cartId) {
		List<Item> listItem = getItemFood(cartId);
		int soLuong = 0;
		for(Item i : listItem) {
			soLuong += i.getQuantity();
		}
		return soLuong;
	}
}
