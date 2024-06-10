package org.example.service;

import org.example.entity.Order;
import org.example.entity.OrderDetail;
import org.example.respository.OrderDetailRepository;
import org.example.respository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public Optional<Order> findOrderById(Long orderId) {
        return orderRepository.findById(orderId);
    }

    public List<OrderDetail> findOrderDetailsByOrderId(Long orderId) {
        return orderDetailRepository.findOrderDetailsByOrderId(orderId);
    }

    public void deleteOrder(Long id){
        List<OrderDetail> orderDetails = orderDetailRepository.findOrderDetailsByOrderId(id);
        orderDetailRepository.deleteAll(orderDetails);
        orderRepository.deleteById(id);
    }


    public void deleteOrderDetail(Long id){
        for(OrderDetail orderDetail : orderDetailRepository.findOrderDetailsByOrderId(id)){
            if(orderDetail.getOrderId().equals(id)){
                orderDetailRepository.delete(orderDetail);
            }
        }
    }
}
