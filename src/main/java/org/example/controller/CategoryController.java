package org.example.controller;

import org.example.entity.Category;
import org.example.entity.Product;
import org.example.respository.CategoryRepo;
import org.example.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class CategoryController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    CategoryRepo categoryRepo;

    @GetMapping("/category/index")
    public String category(@ModelAttribute Category category, Model model,
                           @RequestParam(name = "page") Optional<Integer> page,
                           @RequestParam(defaultValue = "") String keyword) {
        Pageable pageable = PageRequest.of(page.orElse(0), 5);
        Page<Category> search = this.categoryRepo.search(pageable, keyword);
        model.addAttribute("category", search);
        model.addAttribute("keyword", keyword);
        model.addAttribute("fragments", "category/index.jsp");
        return "adminIndex";
    }

    @GetMapping("/category/add")
    public String add(@ModelAttribute Category category, Model model) {
        model.addAttribute("category", category);
        model.addAttribute("fragments", "category/add.jsp");
        return "adminIndex";
    }

    @PostMapping("/category/store")
    public String store(@Validated
                        @ModelAttribute("category") Category category, BindingResult result, Model model,
                        RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("fragments", "category/add.jsp");
            return "adminIndex";
        }
        model.addAttribute("category", category);
        this.categoryService.addOrUpdate(category);
        redirectAttributes.addFlashAttribute("message", "Category save successfully!");
        return "redirect:/admin/category/index";
    }

    @GetMapping("/category/edit/{id}")
    public String edit(@PathVariable("id") Integer id, Model model) {
        Category category = this.categoryService.getCategoryById(id);
        model.addAttribute("category", category);
        model.addAttribute("fragments", "category/edit.jsp");
        return "adminIndex";
    }

    @PostMapping("/category/update")
    public String update(@Validated
                         @ModelAttribute("category") Category category,
                         BindingResult result, Model model,
                         RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("fragments", "category/edit.jsp");
            return "adminIndex";
        }
        model.addAttribute("category", category);
        this.categoryService.addOrUpdate(category);
        redirectAttributes.addFlashAttribute("message", "Category update successfully!");
        return "redirect:/admin/category/index";
    }

    @GetMapping("/category/delete/{id}")
    public String delete(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            this.categoryService.deleteCategoryById(id);
            redirectAttributes.addFlashAttribute("message", "Category deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error: Unable to delete category. Please try again.");
        }
        return "redirect:/admin/category/index";
    }

}
