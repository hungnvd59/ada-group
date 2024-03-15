package com.ada.web.service;

import com.ada.model.TransactionSim;

public interface TransactionSimService {
    TransactionSim findByTransCode(String transCode);
}
