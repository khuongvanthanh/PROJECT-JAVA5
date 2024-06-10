package org.example.controller;

import org.example.entity.Account;
import org.example.respository.AccountRepo;
import org.example.service.AccountService;
import org.example.utils.HandleImages;
import org.example.utils.MarkPassword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Base64;
import java.util.Objects;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AccountController {
    @Autowired
    private AccountService accountService;
    @Autowired
    private AccountRepo accountRepo;


    @GetMapping("/account/index")
    public String account(@ModelAttribute Account account, Model model,
                          @RequestParam(name = "page") Optional<Integer> page,
                          @RequestParam(defaultValue = "") String keyword) {
        Pageable pageable = PageRequest.of(page.orElse(0), 5);
        Page<Account> search = accountRepo.search(pageable, keyword);
        model.addAttribute("accounts", search);
        model.addAttribute("keyword", keyword);
        search.forEach(acc -> acc.setPassword(MarkPassword.maskPassword(acc.getPassword())));
        model.addAttribute("fragments", "account/index.jsp");
        return "adminIndex";
    }

    @GetMapping("/account/add")
    public String add(@ModelAttribute Account account, Model model) {
        model.addAttribute("account", account);
        model.addAttribute("fragments", "account/add.jsp");
        return "adminIndex";
    }

    @PostMapping("/account/store")
    public String store(@Validated @ModelAttribute("account") Account account,
                        BindingResult result, Model model,
                        @RequestParam("fileImage") MultipartFile fileImage,
                        RedirectAttributes redirectAttributes,
                        @RequestParam String username) throws IOException {
        if (fileImage.isEmpty()) {
            result.rejectValue("photo", "error", "Please select an image file");
        } else if (!Objects.requireNonNull(fileImage.getContentType()).startsWith("image")) {
            result.rejectValue("photo", "error", "Please select a valid image file");
        }

        if (result.hasErrors()) {
            model.addAttribute("account", account);
            if (!fileImage.isEmpty()) {
                String base64Image = Base64.getEncoder().encodeToString(fileImage.getBytes());
                model.addAttribute("imagePreview", base64Image);
            }
            model.addAttribute("errorMessage", "Please upload an image");
            return "/admin/account/add";
        }

        if (account.getAdmin() == null) {
            account.setAdmin((byte) 0);
        } else {
            account.setAdmin((byte) 1);
        }

        if (account.getUsername().equals(username) == this.accountService.checkTrungMa(username)) {
            result.rejectValue("username", "error", "Username is already taken");
            return "/admin/account/add";
        }

        account.setPhoto(HandleImages.handleMultipartFile(fileImage));
        accountService.addOrUpdate(account);
        redirectAttributes.addFlashAttribute("message", "Account saved successfully!");
        return "redirect:/admin/account/index";
    }


    @GetMapping("/account/edit/{username}")
    public String edit(@PathVariable("username") String username, Model model) {
        Account account = accountService.getAccountById(username);
        model.addAttribute("account", account);
        model.addAttribute("fragments", "account/edit.jsp");
        return "adminIndex";
    }


    @PostMapping("/account/update")
    public String update(@Validated @ModelAttribute("account") Account account,
                         BindingResult result, Model model,
                         @RequestParam("fileImage") MultipartFile fileImage,
                         RedirectAttributes redirectAttributes) throws IOException {
        if (result.hasErrors()) {
            model.addAttribute("account", account);
            return "/admin/account/edit";
        }

        if (!fileImage.isEmpty()) {
            account.setPhoto(HandleImages.handleMultipartFile(fileImage));
        } else {
            Account existingAccount = accountService.getAccountById(account.getUsername());
            account.setPhoto(existingAccount.getPhoto());
        }
        if (account.getAdmin() == null) {
            account.setAdmin((byte) 0);
        } else {
            account.setAdmin((byte) 1);
        }
        accountService.addOrUpdate(account);
        redirectAttributes.addFlashAttribute("message", "Account updated successfully!");
        return "redirect:/admin/account/index";
    }

    @GetMapping("/account/delete/{username}")
    public String delete(@PathVariable String username, @ModelAttribute Account account, RedirectAttributes redirectAttributes) {
        try {
            accountService.delete(username);
            redirectAttributes.addFlashAttribute("message", "Account deleted successfully!");
            return "redirect:/admin/account/index";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "No deleted");
            return "redirect:/admin/account/index";
        }
    }

}