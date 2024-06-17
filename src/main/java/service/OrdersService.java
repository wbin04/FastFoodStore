package service;

import java.util.List;
import java.util.Map;

import model.Item;
import model.Orders;
import repository.OrdersRepository;

public class OrdersService {
	private OrdersRepository ordersRepository = new OrdersRepository();
	public int addOrder(int userId, int totalCost, String note, String status, String paymentMethod, String receiverName, String shipAddress, String phoneNumber, String promoId) {
		return ordersRepository.addOrder(userId, totalCost, note, status, paymentMethod, receiverName, shipAddress, phoneNumber, promoId);
	}
	
	public List<Orders> getOrderByStatus(int type, int userId) {
		return ordersRepository.getOrderByStatus(type, userId);
	}
	public List<Orders> adminGetOrderByStatus(int type) {
		return ordersRepository.adminGetOrderByStatus(type);
	}
	
	public List<Orders> getAllOrder(int userId) {
		return ordersRepository.getAllOrder();
	}
	
	public List<Orders> getAllOrder() {
		return ordersRepository.getAllOrder();
	}
	
	public List<Item> getItemLine(int orderId){
		return ordersRepository.getItemLine(orderId);
	}
	
	public List<Orders> getOrdersByUserId(int userId){
		return ordersRepository.getOrdersByUserId(userId);
	}
	
	public Orders getOrdersByOrderId(int orderId){
		return ordersRepository.getOrdersByOrderId(orderId);
	}
	
	public Orders getNewestOrder(){
		return ordersRepository.getNewestOrder();
	}
	
	public int changeOrderStatus(int orderId, String status) {
		return ordersRepository.changeOrderStatus(orderId, status);
	}
	public int changeOrderStatus(int orderId, String status, String note) {
		return ordersRepository.changeOrderStatus(orderId, status, note);
	}
	
	public Map<String, Integer> getLast7DaysRevenue(String date) {
		return ordersRepository.getLast7DaysRevenue(date);
	}
	
	public int countFoodHasSold(String date) {
		return ordersRepository.countFoodHasSold(date);
	}
	
	public int countUser(String date) {
		return ordersRepository.countUser(date);
	}
	
	public int countOrders(String date) {
		return ordersRepository.countOrders(date);
	}
	public int calTotalRevenue(String date) {
		return ordersRepository.calTotalRevenue(date);
	}
	public List<Orders> SearchOrders(int key){
		return ordersRepository.SearchOrders(key);
	}
	
	public String getEmailByOrderId(int orderId) {
		return ordersRepository.getEmailByOrderId(orderId);
	}
	public int getDiscountByOrderId(int orderId) {
		return ordersRepository.getDiscountByOrderId(orderId);
	}
	public int[] getCurrentWeekRevenue() {
		return ordersRepository.getCurrentWeekRevenue();
	}
	public int[] getLastWeekRevenue() {
		return ordersRepository.getLastWeekRevenue();
	}
	public int[] getCurrentYearRevenue() {
		return ordersRepository.getCurrentYearRevenue();
	}
	public int[] getLastYearRevenue() {
		return ordersRepository.getLastYearRevenue();
	}
}
