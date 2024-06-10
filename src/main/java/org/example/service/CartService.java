package org.example.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import org.example.entity.Account;
import org.example.entity.Order;
import org.example.entity.OrderDetail;
import org.example.entity.Product;
import org.example.respository.OrderDetailRepository;
import org.example.respository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@SessionScope
public class CartService {
    @Autowired
    private ProductService productService;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Getter
    private final List<OrderDetail> items = new ArrayList<>();

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public void add(int id) {
        OrderDetail item = items.stream().filter(it -> it.getProductId().getId() == id).findFirst().orElse(null);
        if (item != null) {
            item.setQuantity(item.getQuantity() + 1);
        } else {
            Product product = productService.getProductById(id);
            if (product != null) {
                items.add(new OrderDetail(null, product.getPrice(), 1, product, null));
            }
        }
    }

    public void update(int id, int quantity) {
        items.stream().filter(it -> it.getProductId().getId() == id).findFirst().ifPresent(it -> it.setQuantity(quantity));
    }

    public void remove(int id) {
        items.removeIf(it -> it.getProductId().getId() == id);
    }

    public int getTotal(){
        return items.size();
    }

    public int getAmount() {
        return items.stream().mapToInt(item -> (int) (item.getQuantity() * item.getPrice())).sum();
    }

    public void checkout(String address, String username, HttpSession session) {
        Account loggedInUser = (Account) session.getAttribute("loggedInUser");
        if (loggedInUser != null && loggedInUser.getUsername().equals(username)) {
            Order order = new Order();
            order.setAddress(address);
            order.setCreatedate(LocalDate.now());
            order.setUsername(loggedInUser); // Assuming this sets the username in Order
            order = orderRepository.save(order);
            for (OrderDetail item : items) {
                if (item.getProductId() != null && item.getPrice() != null && item.getQuantity() != null) {
                    item.setOrderId(order);
                    orderDetailRepository.save(item);
                } else {
                    // Handle invalid order detail
                }
            }
            items.clear();
        } else {
            // Handle invalid user
        }
    }
}
