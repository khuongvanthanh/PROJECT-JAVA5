package org.example.respository;

import org.example.entity.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Integer> {
    @Query("FROM OrderDetail WHERE orderId.id = :orderId")
    List<OrderDetail> findOrderDetailsByOrderId(@Param("orderId") Long orderId);
}
