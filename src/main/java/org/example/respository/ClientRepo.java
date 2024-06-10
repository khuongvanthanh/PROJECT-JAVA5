package org.example.respository;
import org.example.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ClientRepo extends JpaRepository<Product, Integer> {
    @Query("SELECT p FROM Product p WHERE "
            + "(:keyword IS NULL OR p.name LIKE %:keyword%) AND "
            + "(:minPrice IS NULL OR p.price >= :minPrice) AND "
            + "(:maxPrice IS NULL OR p.price <= :maxPrice) AND "
            + "(:categories IS NULL OR p.categoryId.id IN :categories) AND "
            + "(:name IS NULL OR p.name LIKE %:name%) AND "
            + "(:categoryId IS NULL OR p.categoryId.id = :categoryId) "
            + "ORDER BY "
            + "CASE WHEN :sort = 'priceAsc' THEN p.price END ASC, "
            + "CASE WHEN :sort = 'priceDesc' THEN p.price END DESC, "
            + "CASE WHEN :sort = 'nameAsc' THEN p.name END ASC, "
            + "CASE WHEN :sort = 'nameDesc' THEN p.name END DESC")
    Page<Product> search(Pageable pageable,
                         @Param("keyword") String keyword,
                         @Param("minPrice") Double minPrice,
                         @Param("maxPrice") Double maxPrice,
                         @Param("categories") List<Integer> categories,
                         @Param("name") String name,
                         @Param("categoryId") Integer categoryId,
                         @Param("sort") String sort);
}
