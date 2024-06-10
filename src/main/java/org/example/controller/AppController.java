package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AppController {

    @GetMapping("/admin")
    public String admin(Model model) {
        model.addAttribute("admin", "layout/admin_display/main.jsp");
        return "adminIndex";
    }

    @GetMapping("/indexAdmin")
    public String indexProduct(Model model) {
        model.addAttribute("product", "/product/index.jsp");
        model.addAttribute("category", "/category/index.jsp");
        model.addAttribute("account", "/account/index.jsp");
        model.addAttribute("edit", "/admin/order/index.jsp");
        return "adminIndex";
    }

    @GetMapping("/addAdmin")
    public String addProduct(Model model) {
        model.addAttribute("add", "/admin/product/add.jsp");
        model.addAttribute("add", "/admin/category/add.jsp");
        model.addAttribute("add", "/admin/account/add.jsp");
        return "adminIndex";
    }

    @GetMapping("/editAdmin")
    public String editProduct(Model model) {
        model.addAttribute("edit", "/admin/product/edit.jsp");
        model.addAttribute("edit", "/admin/category/edit.jsp");
        model.addAttribute("edit", "/admin/account/edit.jsp");
        model.addAttribute("edit", "/admin/order/edit.jsp");
        return "adminIndex";
    }

    //---------------------------------------------------------------------------------
    @GetMapping("/client")
    public String client(Model model) {
        model.addAttribute("client", "layout/client_display/main.jsp");
        return "clientIndex";
    }

    @GetMapping("indexClient")
    public String indexClient(Model model) {
        model.addAttribute("content", "/content/index.jsp");
        return "clientIndex";
    }

    @GetMapping("/editClient")
    public String editClient(Model model) {
        model.addAttribute("edit", "/client/content/edit.jsp");
        return "clientIndex";
    }

    @GetMapping("/cartClient")
    public String card(Model model) {
        model.addAttribute("card", "/client/product/cart.jsp");
        return "clientIndex";
    }

    //---------------------------------------------------------------------------------

}
