package com.ada.web.service;

import com.ada.model.TransactionSim;
import com.ada.web.dao.TransactionSimDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TransactionSimServiceImpl implements TransactionSimService{
    @Autowired
    TransactionSimDAO transactionSimDAO;

    @Override
    public TransactionSim findByTransCode(String transCode){
        return transactionSimDAO.findByTransCode(transCode);
    }
}
