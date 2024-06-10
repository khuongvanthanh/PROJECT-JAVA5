package org.example.respository;
import org.example.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;

public interface OrderRepository extends JpaRepository<Order, Long> {
    @Query("from Order where (createdate between :firstDate and :lastDate) and username.username like %:keyword%")
    Page<Order> search(@Param("firstDate") LocalDate firstDate,
                       @Param("lastDate") LocalDate lastDate,
                       @Param("keyword") String keyword,
                       Pageable pageable);


}
