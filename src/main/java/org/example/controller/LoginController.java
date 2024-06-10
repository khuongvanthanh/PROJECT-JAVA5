package org.example.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Account;
import org.example.respository.LoginRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {

    @Autowired
    private LoginRepo loginRepo;

    @GetMapping
    public String loginPage(Model model) {
        model.addAttribute("account", new Account());
        return "login/index";
    }

    @PostMapping("/account")
    public String login(Account account, Model model, HttpServletRequest request, HttpSession session) {
        Account foundAccount = loginRepo.findById(account.getUsername()).orElse(null);
        if (foundAccount != null && foundAccount.getPassword().equals(account.getPassword())) {
            if (foundAccount.getActivated() == 1) {
                session.setAttribute("loggedInUser", foundAccount);
                if (foundAccount.getAdmin() == 1) {
                    request.setAttribute("isAdmin", true);
                    return "redirect:/admin";
                } else {
                    request.setAttribute("isAdmin", false);
                    if (session.getAttribute("checkout") != null) {
                        session.removeAttribute("checkout");
                        return "redirect:/client/product/cart";
                    } else {
                        return "redirect:/client/product/index";
                    }
                }
            } else {
                model.addAttribute("message", "Account is not activated. Please contact the administrator.");
            }
        } else {
            model.addAttribute("message", "Invalid username or password.");
        }
        return "login/index";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/client/product/index";
    }

//    @PostMapping("/account/guest")
//    public String loginAsGuest(Model model, HttpSession session) {
//        Account guestAccount = new Account();
//        guestAccount.setUsername("guest");
//        guestAccount.setPassword("guest");
//        session.setAttribute("loggedInUser", guestAccount);
//
//        if (session.getAttribute("checkout") != null) {
//            session.removeAttribute("checkout");
//            return "redirect:/client/product/cart";
//        } else {
//            return "redirect:/client/product/index";
//        }
//    }

}

