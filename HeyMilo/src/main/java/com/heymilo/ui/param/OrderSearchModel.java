package com.heymilo.ui.param;

import com.heymilo.order.entity.OrderStatus;

public class OrderSearchModel extends DataTableSearchModel {
	
	private OrderStatus status;
	private Long orderId;
	private Long buyerId;
	
	public OrderStatus getStatus() {
		return status;
	}
	public void setStatus(OrderStatus status) {
		this.status = status;
	}
	public Long getOrderId() {
		return orderId;
	}
	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}
	public Long getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(Long buyerId) {
		this.buyerId = buyerId;
	}
	
	
}
