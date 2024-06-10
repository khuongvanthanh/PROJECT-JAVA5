package org.example.controller;
import org.example.entity.OrderDetail;
import org.example.entity.Product;
import org.example.respository.OrderDetailRepository;
import org.example.respository.ProductRepo;
import org.example.service.CategoryService;
import org.example.service.ProductService;
import org.example.utils.HandleImages;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class ProductController {
    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductRepo productRepo;
    @Autowired
    OrderDetailRepository orderDetailRepository;

    @GetMapping("/product/index")
    public String product(@ModelAttribute Product product, Model model,
                          @RequestParam(name = "page") Optional<Integer> page,
                          @RequestParam(defaultValue = "") String keyword) {
        Pageable pageable = PageRequest.of(page.orElse(0), 5);
        Page<Product> search = this.productRepo.search(pageable, keyword);
        model.addAttribute("category", this.categoryService.getAllCategories());
        model.addAttribute("product", search);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("fragments", "product/index.jsp");
        return "adminIndex";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @GetMapping("/product/add")
    public String add(@ModelAttribute Product product, Model model) {
        model.addAttribute("product", product);
        model.addAttribute("category", this.categoryService.getAllCategories());
        model.addAttribute("fragments", "product/add.jsp");
        return "adminIndex";
    }

    @PostMapping("/product/store")
    public String store(@Validated
                        @ModelAttribute("product") Product product,
                        BindingResult result, Model model,
                        @RequestParam("fileImage") MultipartFile fileImage,
                        RedirectAttributes redirectAttributes) throws IOException {
        if (product.getCategoryId() == null) {
            result.rejectValue("categoryId", "error", "Please select a category");
        }
        if (fileImage.isEmpty()) {
            result.rejectValue("image", "error", "Please select an image file");
        } else if (!fileImage.getContentType().startsWith("image")) {
            result.rejectValue("image", "error", "Please select a valid image file");
        }
        if (result.hasErrors()) {
            model.addAttribute("category", this.categoryService.getAllCategories());
            model.addAttribute("product", product);

            if (!fileImage.isEmpty()) {
                String base64Image = Base64.getEncoder().encodeToString(fileImage.getBytes());
                model.addAttribute("imagePreview", base64Image);
            }
            model.addAttribute("fragments", "product/add.jsp");
            return "adminIndex";
        }
        if(product.getAvailable() == null){
            product.setAvailable((byte) 0);
        }else{
            product.setAvailable((byte) 1);
        }
        product.setCreatedate(new Date());
        product.setImage(HandleImages.handleMultipartFile(fileImage));
        this.productService.addOrUpdate(product);
        redirectAttributes.addFlashAttribute("message", "Product save successfully!");
        return "redirect:/admin/product/index";
    }

    @GetMapping("/product/edit/{id}")
    public String edit(@PathVariable("id") Integer id, Model model) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("category", this.categoryService.getAllCategories());
        model.addAttribute("fragments", "product/edit.jsp");
        return "adminIndex";
    }

    @PostMapping("/product/update")
    public String update(@Validated
                         @RequestParam("id") Integer id,
                         @ModelAttribute("product") Product product,
                         BindingResult result, Model model,
                         @RequestParam("fileImage") MultipartFile fileImage,
                         RedirectAttributes redirectAttributes) throws IOException {
        if (product.getCategoryId() == null) {
            result.rejectValue("categoryId", "error", "Please select a category");
        }
        if (result.hasErrors()) {
            model.addAttribute("category", this.categoryService.getAllCategories());
            model.addAttribute("product", product);
            return "/admin/product/edit";
        }

        if (!fileImage.isEmpty()) {
            product.setImage(HandleImages.handleMultipartFile(fileImage));
        } else {
            Product existingProduct = this.productService.getProductById(id);
            product.setImage(existingProduct.getImage());
        }
        if(product.getAvailable() == null){
            product.setAvailable((byte) 0);
        }else{
            product.setAvailable((byte) 1);
        }
        redirectAttributes.addFlashAttribute("message", "Product update successfully!");
        this.productService.addOrUpdate(product);
        return "redirect:/admin/product/index";
    }

    @GetMapping("/product/delete/{id}")
    public String delete(@PathVariable Integer id,@ModelAttribute Product product, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("message", "Product deleted successfully!");
        if(this.productService.getOrderDetailById(id)){
            redirectAttributes.addFlashAttribute("message", "No delete");
            return "redirect:/admin/product/index";
        }
        this.productService.deleteProductById(id);
        return "redirect:/admin/product/index";
    }
}
