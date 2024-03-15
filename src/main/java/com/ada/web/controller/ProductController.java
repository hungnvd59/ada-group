package com.ada.web.controller;

import com.ada.common.PagingResult;
import com.ada.web.dao.ProductDAO;
import com.ada.web.service.ProductService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/ctv/osp")
public class ProductController {
    private Logger logger = LogManager.getLogger(ParameterController.class);

    @Autowired
    ProductDAO productDAO;

    @Autowired
    ProductService productService;

    @GetMapping("/search")
    public ResponseEntity<PagingResult> parameterList(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNumber,
                                                      @RequestParam(value = "name", required = false, defaultValue = "") String name,
                                                      @RequestParam(value = "category", required = false, defaultValue = "") String category,
                                                      @RequestParam(value = "status", required = false, defaultValue = "") String status,
                                                      @RequestParam(value = "toDate", required = false, defaultValue = "") String toDate,
                                                      @RequestParam(value = "fromDate", required = false, defaultValue = "") String fromDate) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        try {
            page = productService.page(page, name, category, status, toDate, fromDate).orElse(new PagingResult());
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
        return new ResponseEntity<>(page, HttpStatus.OK);
    }
}
