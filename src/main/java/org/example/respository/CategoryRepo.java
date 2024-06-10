package org.example.respository;

import org.example.entity.Category;
import org.example.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepo extends JpaRepository<Category, Integer> {
    @Query("FROM Category WHERE (name LIKE %:keyword%)")
    Page<Category> search(Pageable pageable, @Param("keyword") String keyword);
}
