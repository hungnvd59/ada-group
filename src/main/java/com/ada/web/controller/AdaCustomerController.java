package com.ada.web.controller;


import com.ada.common.PagingResult;
import com.ada.model.User;
import com.ada.web.dao.UserDAO;
import com.ada.web.service.CustomerDao;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/customer")
public class AdaCustomerController {
    private Logger logger = LogManager.getLogger(this.getClass());

    @Autowired
    UserDAO userDAO;

    @Autowired
    CustomerDao customerDao;

    @RequestMapping(value = "/quan-ly-nhan-vien.html", method = RequestMethod.GET)
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
            @RequestParam(value = "status", required = false, defaultValue = "-1") Long status,
            @RequestParam(value = "presenter", required = false, defaultValue = "") String presenter,
            @RequestParam(value = "provinceId", required = false, defaultValue = "-1") Long provinceId,
            @RequestParam(value = "districtId", required = false, defaultValue = "-1") Long districtId,
            @RequestParam(value = "comingDate", required = false, defaultValue = "") String comingDate,
            @RequestParam(value = "leaveDate", required = false, defaultValue = "") String leaveDate) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userDAO.getByUsername(auth.getName()).orElse(null);

        try {
            page = customerDao.page(page, fullName, mobile, status, presenter,
                    provinceId, districtId, comingDate, leaveDate, user).orElse(new PagingResult());
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(-1, HttpStatus.OK);
        }
        return new ResponseEntity<>(page, HttpStatus.OK);
    }
}
