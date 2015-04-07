package com.heymilo.order;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import com.google.gson.annotations.Expose;
import com.heymilo.order.entity.Order;
import com.heymilo.order.entity.OrderStatus;

public class OrderListDTO {
	@Expose
	private Long id;
	
	@Expose
	private String productDesc;
	
	@Expose
	private OrderStatus status;
	
	@Expose
	private String buyerName;
	
	@Expose
	private String buyerEmail;
	
	@Expose
	private String createdStr; 
	
	@Expose
	private String updatedStr;
	
	@Expose
	private double totalPrice;
	
	private DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH24:mi");
	
	public OrderListDTO(){
		
	}
	
	public OrderListDTO(Order order){
		this.id = order.getId();
		this.buyerName = order.getUser().getName();
		this.buyerEmail = order.getUser().getEmail();
		this.status = order.getStatus();
		this.productDesc = order.getProductDesc();
		this.totalPrice = order.getTotalPrice().doubleValue();
		this.createdStr = format.format(order.getCreatedAt());
		this.updatedStr = format.format(order.getUpdatedAt());
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getProductDesc() {
		return productDesc;
	}

	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}

	public OrderStatus getStatus() {
		return status;
	}

	public void setStatus(OrderStatus status) {
		this.status = status;
	}

	public String getBuyerName() {
		return buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	public String getBuyerEmail() {
		return buyerEmail;
	}

	public void setBuyerEmail(String buyerEmail) {
		this.buyerEmail = buyerEmail;
	}

	public String getCreatedStr() {
		return createdStr;
	}

	public void setCreatedStr(String createdStr) {
		this.createdStr = createdStr;
	}

	public String getUpdatedStr() {
		return updatedStr;
	}

	public void setUpdatedStr(String updatedStr) {
		this.updatedStr = updatedStr;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	
}
