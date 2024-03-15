package com.ada.web.service;

import com.ada.model.TransactionPackage;
import com.ada.web.dao.TransactionPackageDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TransactionPackageServiceImpl implements TransactionPackageService{
    @Autowired
    TransactionPackageDAO transactionPackageDAO;

    @Override
    public TransactionPackage findByTransCode(String transCode) {
        return transactionPackageDAO.findByTransCode(transCode);
    }
}
