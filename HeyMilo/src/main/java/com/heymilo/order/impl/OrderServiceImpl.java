package com.heymilo.order.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.heymilo.identity.entity.User;
import com.heymilo.order.OrderDAO;
import com.heymilo.order.OrderDTO;
import com.heymilo.order.OrderItemDto;
import com.heymilo.order.OrderService;
import com.heymilo.order.PaymentService;
import com.heymilo.order.entity.OneTimeOrder;
import com.heymilo.order.entity.Order;
import com.heymilo.order.entity.OrderItem;
import com.heymilo.order.entity.OrderStatus;
import com.heymilo.order.entity.SubscriptionOrder;
import com.heymilo.order.exception.OrderException;
import com.heymilo.order.exception.OutOfStockException;
import com.heymilo.shop.entity.Product;
import com.heymilo.shop.product.ProductService;
import com.heymilo.shop.product.StockService;
import com.heymilo.ui.param.OrderSearchModel;

@Service
public class OrderServiceImpl implements OrderService {
	
	private Log log = LogFactory.getLog(OrderServiceImpl.class);
	
	@Autowired 
	private PaymentService paymentService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private StockService stockService;
	
	@Autowired
	private OrderDAO orderDao;
	
	@Transactional
	@Override
	public OneTimeOrder createOrder(OrderDTO orderDto, User user)
			throws OrderException {
		
		try {
		//1. orderitem별로 validation을 한다. 재고수량 확인.
			checkStock(orderDto.getOrderItems());
		
		//2. PG사에 승인요청을 한다. 이 부분이 인증을 거친 이후에 처리되야한다. 이부분은 추후에 KCP와 연결하는 부분이 처리되면 하자.
			
		
		//3. 오더를 생성시킨다.
			OneTimeOrder order = generateOrder(orderDto, user);
			orderDao.save(order);
			
		//4. 각각의 재고를 줄인다. 이때에 재고가 부족할수있으니 다시 체크한다.
			for(OrderItem orderItem : order.getItems()) {
				stockService.changeStock(orderItem.getProduct(), orderItem.getItemCount());
			}
			
			return order;
			
		} catch (OutOfStockException outOfStock) {
			log.info("OutOfStock ", outOfStock);
			throw outOfStock;
		} catch (Exception e) {
			log.error("Order Create Error ", e);
			throw new OrderException(e.getMessage());
		}
	}
	
	private void checkStock(List<OrderItemDto> itemDtos) throws OutOfStockException {
		for (OrderItemDto item : itemDtos) {
			if(!stockService.canOrder(item.getProductId(), item.getItemCount())) {
				throw new OutOfStockException("제품 " + item.getProductId() + "의 재고가 부족합니다.");
			}
		}
	}
	
	private OneTimeOrder generateOrder(OrderDTO orderDto, User user){
		OneTimeOrder order = new OneTimeOrder();
		
		order.setPhone1(orderDto.getPhone1());
		order.setPhone2(orderDto.getPhone2());
		order.setReceiveName(orderDto.getReceiveName());
		order.setZipCode(orderDto.getZipCode());
		order.setDetailAddress(orderDto.getDetailAddress());
		order.setAddress(orderDto.getAddress());
		order.setStatus(OrderStatus.ORDERD);
		order.setUser(user);
		order.setActive(true);
		order.setOrderNo(generateOrderNo(user.getId()));
		
		double totalPrice = 0;
		String productDesc=null;
		List<OrderItem> orderItems = Lists.newArrayList();
		order.setItems(orderItems);
		
		for(OrderItemDto itemDto : orderDto.getOrderItems()) {
			OrderItem item = new OrderItem();
			Product product = productService.load(itemDto.getProductId());
			item.setItemPrice(product.getMiloPrice());
			item.setProduct(product);
			item.setItemCount(itemDto.getItemCount());
			item.setCreatedAt(new Date());
			item.setOrder(order);
			orderItems.add(item);
			if(productDesc == null) {
				productDesc = product.getName() + " 외";
			}
			totalPrice += product.getMiloPrice().doubleValue();
		}
		
		order.setTotalPrice(new BigDecimal(totalPrice));
		order.setProductDesc(productDesc);
		
		return order;
	}

	private String generateOrderNo(Long memberId) {
		Date current = new Date();
		return String.valueOf(memberId + current.getTime());
	}
	
	@Transactional
	@Override
	public SubscriptionOrder createSubscriptionOrder(OrderDTO orderDto,
			User user) throws OrderException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OneTimeOrder> searchOrder(OrderSearchModel searchModel) {
		return orderDao.searchOneTimeOrder(searchModel);
	}
	
	

	@Override
	public int countOrder(OrderSearchModel searchModel) {
		return orderDao.countOneTimeOrder(searchModel);
	}

	@Override
	public OneTimeOrder loadOneTimeOrder(Long orderId) {
		Order order = orderDao.loadOrder(orderId);
		if(order instanceof OneTimeOrder) {
			return (OneTimeOrder)order;
		}
		
		return null;
	}
	
	
}
