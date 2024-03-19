package com.ada.web.controller;


import com.ada.common.Constants;
import com.ada.common.PagingResult;
import com.ada.model.AdaCustomer;
import com.ada.model.User;
import com.ada.model.view.CustomerView;
import com.ada.web.dao.CommonDao;
import com.ada.web.dao.UserDAO;
import com.ada.web.service.CustomerDao;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
@RequestMapping("/customer")
public class AdaCustomerController {
    private Logger logger = LogManager.getLogger(this.getClass());

    @Autowired
    UserDAO userDAO;

    @Autowired
    CustomerDao customerDao;

    @Autowired
    CommonDao commonDao;

    @RequestMapping(value = "/quan-ly-dai-ly.html", method = RequestMethod.GET)
    public String index() {
        return "customer.index";
    }

    @GetMapping("/search")
//    @Secured(ConstantAuthor.CTV_USER_MGMT.view)
    public ResponseEntity<?> search(
            @RequestParam(value = "pageNumber", required = false, defaultValue = "1") int pageNumber,
            @RequestParam(value = "numberPerPage", required = false, defaultValue = "15") int numberPerPage,
            @RequestParam(value = "fullName", required = false, defaultValue = "") String fullName,
            @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
            @RequestParam(value = "provinceId", required = false, defaultValue = "-1") Long provinceId,
            @RequestParam(value = "districtId", required = false, defaultValue = "-1") Long districtId,
            @RequestParam(value = "team", required = false, defaultValue = "-1") Long team) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userDAO.getByUsername(auth.getName()).orElse(null);

        try {
            page = customerDao.page(page, fullName, mobile,
                    provinceId, districtId, team, user).orElse(new PagingResult());
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(-1, HttpStatus.OK);
        }
        return new ResponseEntity<>(page, HttpStatus.OK);
    }

    @PostMapping("/update")
    public ResponseEntity<?> update(@RequestBody CustomerView dto, HttpServletRequest request) {
        try {
            AdaCustomer customerCheck = commonDao.findById(AdaCustomer.class, dto.getId());
            if (customerCheck == null) {
                return new ResponseEntity<>("-1", HttpStatus.OK);
            }
            AdaCustomer customer = new AdaCustomer(dto);
            commonDao.update(customer);
            return new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>("0", HttpStatus.OK);
    }

    @PostMapping("/delete")
    public ResponseEntity<?> delete(@RequestBody CustomerView dto, HttpServletRequest request) {
        try {
            AdaCustomer customerCheck = commonDao.findById(AdaCustomer.class, dto.getId());
            if (customerCheck == null) {
                return new ResponseEntity<>("-1", HttpStatus.OK);
            }
            customerCheck.setStatus(Constants.CUSTOMER_STATUS.NGUNG_HOAT_DONG);
            customerCheck.setLeaveDate(new Date());
            commonDao.update(customerCheck);
            return new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>("0", HttpStatus.OK);
    }
}
