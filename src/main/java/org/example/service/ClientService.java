package org.example.service;

import org.example.entity.Product;
import org.example.respository.ClientRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClientService {
    @Autowired
    private ClientRepo clientRepo;
    public Product getClientByID(int id) {
        return clientRepo.findById(id).get();
    }
}
