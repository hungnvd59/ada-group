package com.ada.web.service;

import com.ada.common.PagingResult;
import com.ada.web.dao.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    ProductDAO productDAO;

    @Override
    @Transactional(value = "transactionManager")
    public Optional<PagingResult> page(PagingResult page, String name, String category, String status, String toDate, String fromDate) {
        return productDAO.page(page, name, category, status, toDate, fromDate);
    }
}
