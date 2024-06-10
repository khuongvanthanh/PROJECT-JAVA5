package org.example.service;

import org.example.entity.Category;
import org.example.respository.CategoryRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    CategoryRepo categoryRepo;

    public List<Category> getAllCategories() {
        return categoryRepo.findAll();
    }

    public Category getCategoryById(int id) {
        return categoryRepo.findById(id).get();
    }

    public void addOrUpdate(Category category) {
        categoryRepo.save(category);
    }

    public void deleteCategoryById(int id) {
        categoryRepo.deleteById(id);
    }
}
