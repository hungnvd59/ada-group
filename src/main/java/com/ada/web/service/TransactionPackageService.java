package com.ada.web.service;

import com.ada.model.TransactionPackage;

public interface TransactionPackageService {
    TransactionPackage findByTransCode(String transCode);
}
