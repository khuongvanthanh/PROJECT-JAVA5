package org.example.respository;

import org.example.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface ProductRepo extends JpaRepository<Product, Integer> {
    @Query("FROM Product WHERE (name LIKE %:keyword% OR categoryId.name LIKE %:keyword%)")
    Page<Product> search(Pageable pageable, @Param("keyword") String keyword);
}
