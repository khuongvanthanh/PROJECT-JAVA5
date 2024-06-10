package org.example.respository;

import org.example.entity.Account;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepo extends JpaRepository<Account, Long> {
    @Query("FROM Account WHERE (username LIKE %:keyword% OR fullname LIKE %:keyword% OR email LIKE %:keyword%) ")
    Page<Account> search(Pageable pageable, @Param("keyword") String keyword);


}
