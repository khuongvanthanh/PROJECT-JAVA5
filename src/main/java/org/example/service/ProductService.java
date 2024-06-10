package org.example.service;

import org.example.entity.Product;
import org.example.respository.OrderDetailRepository;
import org.example.respository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
@Service
public class ProductService {
    @Autowired
    ProductRepo productRepo;
    @Autowired
    OrderDetailRepository orderDetailRepository;

    public Page<Product> getAllProducts(Pageable pageable) {
        return productRepo.findAll(pageable);
    }

    public Product getProductById(int id) {
        return productRepo.findById(id).get();
    }

    public void addOrUpdate(Product product) {
        productRepo.save(product);
    }

    public void deleteProductById(int id) {
        productRepo.deleteById(id);
    }

    public boolean getOrderDetailById(int id) {
        return orderDetailRepository.existsById(id);
    }

}
