package com.ada.web.controller;


import com.ada.common.ConfigProperties;
import com.ada.common.Constants;
import com.ada.common.PagingResult;
import com.ada.model.AdaCustomer;
import com.ada.model.User;
import com.ada.model.view.CustomerView;
import com.ada.web.dao.CommonDao;
import com.ada.web.dao.UserDAO;
import com.ada.web.service.CustomerDao;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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

    @PostMapping("/add")
    public ResponseEntity<?> add(@RequestBody CustomerView dto, HttpServletRequest request) {
        try {
            AdaCustomer customerCheck = customerDao.getCustomerByMobile(dto.getMobile());
            if (customerCheck != null) {
                //Exist customer first
                return new ResponseEntity<>("-1", HttpStatus.OK);
            }
            AdaCustomer customer = new AdaCustomer(dto);
            customer.setStatus(Constants.CUSTOMER_STATUS.DANG_HOAT_DONG);
            customer.setGenDate(new Date());
            customer.setComingDate(new Date());
            commonDao.save(customer);
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

    @GetMapping("/export")
//    @Secured(ConstantAuthor.CTV_USER_MGMT.view)
    public void export(
            @RequestParam(value = "pageNumber", required = false, defaultValue = "1") int pageNumber,
            @RequestParam(value = "numberPerPage", required = false, defaultValue = "15") int numberPerPage,
            @RequestParam(value = "fullName", required = false, defaultValue = "") String fullName,
            @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
            @RequestParam(value = "provinceId", required = false, defaultValue = "-1") Long provinceId,
            @RequestParam(value = "districtId", required = false, defaultValue = "-1") Long districtId,
            @RequestParam(value = "team", required = false, defaultValue = "-1") Long team, HttpServletRequest request, HttpServletResponse response) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        try {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userDAO.getByUsername(auth.getName()).orElse(null);
            page = customerDao.page(page, fullName, mobile,
                    provinceId, districtId, team, user).orElse(new PagingResult());
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("items", page.getItems());

            String realPathOfFolder = request.getServletContext().getRealPath(
                    ConfigProperties.getConfigProperties("template_path"));
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ada-customer.xlsx"));

            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);
            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition",
                    "attachment; filename=" + dateDownload + "_DS_nhan_vien.xlsx");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
