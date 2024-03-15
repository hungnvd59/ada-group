package com.ada.web.dao;

import com.ada.model.TransactionSim;

public interface TransactionSimDAO {
    TransactionSim findById(int id);

    TransactionSim findByTransCode(String tranCode);
}
