package org.example.controller;

import org.example.entity.Order;
import org.example.entity.OrderDetail;
import org.example.respository.OrderDetailRepository;
import org.example.respository.OrderRepository;
import org.example.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    OrderRepository orderRepository;

    @GetMapping("/order/index")
    public String index(@ModelAttribute Order order, Model model,
                        @RequestParam("page") Optional<Integer> page,
                        @RequestParam("firstDate") Optional<String> firstDate,
                        @RequestParam("lastDate") Optional<String> lastDate,
                        @RequestParam("keyword") Optional<String> keyword) {
        Pageable pageable = PageRequest.of(page.orElse(0), 5);

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate firstDateParsed = firstDate.filter(f -> !f.isEmpty()).map(f -> LocalDate.parse(f, dateFormatter)).orElse(null);
        LocalDate lastDateParsed = lastDate.filter(l -> !l.isEmpty()).map(l -> LocalDate.parse(l, dateFormatter)).orElse(null);

        Page<Order> search = orderRepository.search(firstDateParsed, lastDateParsed, keyword.orElse(null), pageable);
        model.addAttribute("order", search);
        model.addAttribute("keyword", keyword.orElse(""));
        model.addAttribute("firstDate", firstDate.orElse(""));
        model.addAttribute("lastDate", lastDate.orElse(""));
        model.addAttribute("fragments", "order/index.jsp");
        return "adminIndex";
    }

    @GetMapping("/order/edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model) {
        Optional<Order> orderOpt = orderService.findOrderById(id);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get(); // Retrieve the Order object from Optional
            List<OrderDetail> orderDetails = orderService.findOrderDetailsByOrderId(id);
            model.addAttribute("order", order); // Pass the Order object to the model
            model.addAttribute("orderDetails", orderDetails);
            model.addAttribute("fragments", "order/edit.jsp");
            return "adminIndex";
        } else {
            return "redirect:/admin/order/index";
        }
    }

    @GetMapping("/order/delete/{id}")
    public String deleteOrder(@PathVariable("id") Long id) {
        this.orderService.deleteOrder(id);
        return "redirect:/admin/order/index";
    }
}
