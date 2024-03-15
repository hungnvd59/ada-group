package com.ada.web.dao;

import com.ada.model.TransactionPackage;

public interface TransactionPackageDAO {
    TransactionPackage findById(int id);

    TransactionPackage findByTransCode(String transCode);
}
