package com.ada.web.controller;

import com.ada.common.ConstantAuthor;
import com.ada.common.PagingResult;
import com.ada.model.AffPackage;
import com.ada.web.dao.AffPackageDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/package")
public class AffPackageController {
    SimpleDateFormat ddMMyyyy = new SimpleDateFormat("dd-MM-yyyy");
    private final String templateExcelDs = "/fileTemplate/ds_goi_cuoc.xlsx";

    @Autowired
    AffPackageDAO affPackageDAO;

    @RequestMapping(value = "/index.html", method = RequestMethod.GET)
    public String list() {
        return "package.list";
    }

    @RequestMapping(value = "/detail.html", method = RequestMethod.GET)
    public String detail(@RequestParam Long id) {
        return "package.detail";
    }

    @GetMapping("/search")
    @Secured(ConstantAuthor.PACKAGE.view)
    public ResponseEntity<PagingResult> search(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNumber,
                                               @RequestParam(value = "numberPerPage", required = false, defaultValue = "15") int numberPerPage,
                                               @RequestParam(value = "packCode", required = false, defaultValue = "") String packCode,
                                               @RequestParam(value = "packName", required = false, defaultValue = "") String packName,
                                               @RequestParam(value = "status", required = false, defaultValue = "-1") Long status,
                                               @RequestParam(value = "fromGenDate", required = false, defaultValue = "") String fromGenDate,
                                               @RequestParam(value = "toGenDate", required = false, defaultValue = "") String toGenDate,
                                               @RequestParam(value = "type", required = false, defaultValue = "-1") String type,
                                               @RequestParam(value = "loaiGoiCuoc", required = false, defaultValue = "-1") String loaiGoiCuoc,
                                               @RequestParam(value = "giaGoi", required = false, defaultValue = "-1") String giaGoi,
                                               @RequestParam(value = "chuKy", required = false, defaultValue = "-1") String chuKy) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        try {
            page = affPackageDAO.page(page, packCode, packName, status, fromGenDate, toGenDate, type, loaiGoiCuoc, giaGoi, chuKy).orElse(new PagingResult());
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
        return new ResponseEntity<>(page, HttpStatus.OK);
    }

    @GetMapping("/detail")
    @Secured(ConstantAuthor.PACKAGE.view)
    public ResponseEntity<?> getDetail(@RequestParam(value = "id", required = true) Long id) {
        try {
            AffPackage affPackage = affPackageDAO.findById(id);
            return new ResponseEntity<>(affPackage, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @Secured(ConstantAuthor.PACKAGE.edit)
    public ResponseEntity<?> addPackage(@RequestBody AffPackage affPackage) {
        try {
            Authentication auth = SecurityContextHolder.getContext()
                    .getAuthentication();
            affPackage.setGenDate(new Date());
            affPackage.setCreateBy(auth.getName());
            affPackageDAO.add(affPackage);
            return new ResponseEntity<>(1, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(-1, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @Secured(ConstantAuthor.PACKAGE.edit)
    public ResponseEntity<?> updatePackage(@RequestBody AffPackage affPackage) {
        try {
            Authentication auth = SecurityContextHolder.getContext()
                    .getAuthentication();
            affPackage.setUpdateBy(auth.getName());
            affPackage.setLastUpdated(new Date());
            boolean checkEdit = affPackageDAO.update(affPackage);
            if(checkEdit) {
                return new ResponseEntity<>(1, HttpStatus.OK);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>(-1, HttpStatus.OK);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @Secured(ConstantAuthor.PACKAGE.edit)
    public ResponseEntity<?> deletePackage(@RequestBody AffPackage affPackage) {
        try {
            boolean checkEdit = affPackageDAO.delete(affPackage.getId());
            if(checkEdit) {
                return new ResponseEntity<>(1, HttpStatus.OK);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>(-1, HttpStatus.OK);
    }

}
