package org.example.service;

import org.example.entity.Account;
import org.example.entity.Order;
import org.example.respository.AccountRepo;
import org.example.respository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class AccountService {
    @Autowired
    AccountRepo accountRepo;
    @Autowired
    OrderRepository orderRepo;

    public Page<Account> getAllAccounts(Pageable pageable) {
        return accountRepo.findAll(pageable);
    }

    public Account getAccountById(String username) {
        for (Account account : accountRepo.findAll()) {
            if (account.getUsername().equals(username)) {
                return account;
            }
        }
        return null;
    }

    public void addOrUpdate(Account product) {
        accountRepo.save(product);
    }

    public void delete(String username) {
        for (Account account : accountRepo.findAll()) {
            if (account.getUsername().equals(username)) {
                accountRepo.delete(account);
            }
        }
    }

    public Boolean checkTrungMa(String username) {
        for (Account account : accountRepo.findAll()) {
            if (account.getUsername().equals(username)) {
                return true;
            }
        }
        return false;
    }

    public boolean getOrderByUsername(String username) {
        return orderRepo.equals(username);
    }


}
