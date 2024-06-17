package model;

public class Promo {
	private String id;
	private int percent;
	private String startDate;
	private String endDate;
	private double minimumPay;
	
	public Promo() {
		
	}
	
	public Promo(String id, int percent, String start_date, String end_date, double minimum_pay) {
		this.id = id;
		this.percent = percent;
		this.startDate = start_date;
		this.endDate = end_date;
		this.minimumPay = minimum_pay;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getPercent() {
		return percent;
	}

	public void setPercent(int percent) {
		this.percent = percent;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public double getMinimumPay() {
		return minimumPay;
	}

	public void setMinimumPay(double minimumPay) {
		this.minimumPay = minimumPay;
	}

	
}
