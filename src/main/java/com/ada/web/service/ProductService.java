package com.ada.web.service;

import com.ada.common.PagingResult;

import java.util.Optional;

public interface ProductService {
    public Optional<PagingResult> page(PagingResult page, String name, String category, String status, String toDate, String fromDate);
}
