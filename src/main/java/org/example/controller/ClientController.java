package org.example.controller;

import jakarta.servlet.http.HttpSession;
import org.example.entity.Account;
import org.example.entity.Product;
import org.example.respository.ClientRepo;
import org.example.service.CartService;
import org.example.service.CategoryService;
import org.example.service.ClientService;
import org.example.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/client")
public class ClientController {

    @Autowired
    CategoryService categoryService;

    @Autowired
    ClientRepo clientRepo;

    @Autowired
    ClientService clientService;

    @Autowired
    CartService cartService;

    @ModelAttribute("cart")
    CartService getCartService() {
        return cartService;
    }

    //--------------------------------------------------------------------------------------------------
    @GetMapping("/product/index")
    public String product(@ModelAttribute Product product, Model model,
                          @RequestParam(name = "page", defaultValue = "0") Optional<Integer> page,
                          @RequestParam(defaultValue = "") String keyword,
                          @RequestParam(name = "minPrice", required = false) Double minPrice,
                          @RequestParam(name = "maxPrice", required = false) Double maxPrice,
                          @RequestParam(name = "categories", required = false) String categories,
                          @RequestParam(defaultValue = "") String name,
                          @RequestParam(name = "categoryId", required = false) Integer categoryId,
                          @RequestParam(defaultValue = "nameAsc") String sort) {

        Pageable pageable = PageRequest.of(page.orElse(0), 8);
        List<Integer> categoryIds = categories != null && !categories.isEmpty() ? Arrays.stream(categories.split(",")).map(Integer::valueOf).collect(Collectors.toList()) : null;

        Page<Product> search = clientRepo.search(pageable, keyword, minPrice, maxPrice, categoryIds, name, categoryId, sort);

        model.addAttribute("category", this.categoryService.getAllCategories());
        model.addAttribute("product", search);
        model.addAttribute("keyword", keyword);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("selectedCategories", categoryIds);
        model.addAttribute("name", name);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("sort", sort);
        model.addAttribute("fragments", "content/index.jsp");

        if (search.isEmpty()) {
            model.addAttribute("noResultsMessage", "No results found. Please try another search.");
        } else {
            model.addAttribute("noResultsMessage", null);
        }


        return "clientIndex";
    }


    @GetMapping("/product/edit/{id}")
    public String edit(@PathVariable int id, @ModelAttribute Product product, Model model) {
        model.addAttribute("product", this.clientService.getClientByID(id));
        model.addAttribute("fragments", "content/edit.jsp");
        return "clientIndex";
    }

    @GetMapping("/product/cart")
    public String cart(@ModelAttribute Product product, Model model) {
        model.addAttribute("cart", cartService);
        if (cartService.isEmpty()) {
            model.addAttribute("message", "Your cart is empty. Please add some products before checking out.");
        }
        model.addAttribute("fragments", "content/cart.jsp");
        return "clientIndex";
    }

//--------------------------------------------------------------------------------------------------

    @PostMapping("/add/cart/{id}")
    public String addToCart(@PathVariable int id, @RequestParam(required = false) Boolean redirectToCheckout) {
        cartService.add(id);
        if (Boolean.TRUE.equals(redirectToCheckout)) {
            return "redirect:/client/content/checkout";
        }
        return "redirect:/client/product/index";
    }

    @GetMapping("/buy-now/{id}")
    public String buyNow(@PathVariable int id) {
        cartService.add(id);
        return "redirect:/client/content/checkout";
    }

    @GetMapping("/cart")
    public String cart(Model model) {
        model.addAttribute("cart", cartService);
        return "/client/product/index";
    }

    @PostMapping("/update-cart/{id}")
    public String updateCart(@PathVariable int id, @RequestParam int quantity) {
        cartService.update(id, quantity);
        return "redirect:/client/product/cart";
    }

    @GetMapping("/remove-cart/{id}")
    public String removeFromCart(@PathVariable int id) {
        cartService.remove(id);
        return "redirect:/client/product/cart";
    }

    //--------------------------------------------------------------------------------------------------
    @GetMapping("/content/checkout")
    public String checkout(Model model, HttpSession session) {
        Account loggedInUser = (Account) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/";
        }
        model.addAttribute("cart", cartService);
        model.addAttribute("loggedInUser", loggedInUser);
        model.addAttribute("fragments", "content/checkout.jsp");
        return "clientIndex";
    }


    @PostMapping("/checkout")
    public String checkout(@RequestParam String address, @RequestParam String username, Model model, HttpSession session) {
        if (cartService.isEmpty()) {
            model.addAttribute("message", "Your cart is empty. You cannot proceed to checkout.");
            return "redirect:/client/product/cart";
        }
        cartService.checkout(address, username, session);
        return "redirect:/client/product/index";
    }


}
