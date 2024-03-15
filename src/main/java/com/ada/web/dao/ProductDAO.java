package com.ada.web.dao;

import com.ada.common.PagingResult;

import java.util.Optional;

public interface ProductDAO {
    Optional<PagingResult> page(PagingResult page, String name, String category, String status, String toDate, String fromDate);
}
