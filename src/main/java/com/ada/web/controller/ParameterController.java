package com.ada.web.controller;

import com.ada.common.ConstantAuthor;
import com.ada.common.PagingResult;
import com.ada.common.Utils;
import com.ada.model.Parameter;
import com.ada.model.User;
import com.ada.web.dao.LogAccessDAO;
import com.ada.web.dao.UserDAO;
import com.ada.web.service.ParameterService;

import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by Admin on 1/9/2018.
 */
@Controller
@RequestMapping("/system/parameters")
public class ParameterController {

    private Logger logger = LogManager.getLogger(ParameterController.class);
    @Autowired
    LogAccessDAO logAccessDao;
    @Autowired
    UserDAO userDao;
    @Autowired
    ParameterService parameterService;

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

    @GetMapping("/quan-ly-tham-so-he-thong.html")
//    @Secured(ConstantAuthor.PARAMETERS.viewList)
    public String getParameters() {
        return "parameters.list";
    }

    @GetMapping("/search")
//    @Secured(ConstantAuthor.PARAMETERS.viewList)
    public ResponseEntity<?> search(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNumber,
                                    @RequestParam(value = "numberPerPage", required = false, defaultValue = "20") int numberPerPage,
                                    @RequestParam(value = "paramKey", required = false, defaultValue = "") String paramKey) {
        User userLogin = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        logger.info(userLogin.getUsername() + "------------- GET /system/parameters/search");
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        page = parameterService.page(page, paramKey).orElse(new PagingResult());
        return new ResponseEntity<>(page, HttpStatus.OK);
    }

    @PostMapping(value = "/add")
    @Secured(ConstantAuthor.Parameter.update)
    public ResponseEntity<String> addParameter(@RequestBody Parameter paramItem, HttpServletRequest request) {
        String page = "0";  // 0: no error, 1: error, 2: not required, 3 key exits
        try {
            if (!checkRequired(paramItem)) {
                return new ResponseEntity<String>("2", HttpStatus.OK);
            } else if (parameterService.isExits(paramItem)) {
                return new ResponseEntity<String>("3", HttpStatus.OK);
            } else {
                boolean isUpdate = parameterService.addParameter(paramItem, Utils.getIpClient(request));
                if (isUpdate) {
                    return new ResponseEntity<String>("0", HttpStatus.OK);
                } else {
                    return new ResponseEntity<String>("1", HttpStatus.OK);

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("1", HttpStatus.OK);
        }
    }

    @PostMapping(value = "/edit")
    @Secured(ConstantAuthor.Parameter.update)
    public ResponseEntity<String> editParameter(@RequestBody Parameter paramItem, HttpServletRequest request) {
        String page = "0";  // 0: no error, 1: error, 2: not required, 3 not exits
        try {
            if (!checkRequired(paramItem)) {
                return new ResponseEntity<String>("2", HttpStatus.OK);
//            } else if (parameterService.isExits(paramItem)) {
//                return new ResponseEntity<String>("3", HttpStatus.OK);
            } else {
                if (paramItem == null || paramItem.getId() == 0L) {
                    return new ResponseEntity<String>("3", HttpStatus.OK);
                }
                Parameter parameterEdit = parameterService.getParamById(paramItem.getId());
                if (parameterEdit == null) {
                    return new ResponseEntity<String>("3", HttpStatus.OK);
                }
                parameterEdit.setValue(paramItem.getValue());
                parameterEdit.setDescription(paramItem.getDescription());

                boolean isUpdate = parameterService.editParameter(parameterEdit, Utils.getIpClient(request));
                if (isUpdate) {
                    return new ResponseEntity<String>("0", HttpStatus.OK);
                } else {
                    return new ResponseEntity<String>("1", HttpStatus.OK);

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("1", HttpStatus.OK);
        }
    }

    @PostMapping(value = "/delete")
    @Secured(ConstantAuthor.Parameter.update)
    public ResponseEntity<String> deleteParameter(@RequestBody Parameter paramItem, HttpServletRequest request) {
        String page = "0";  // 0: no error, 1: error, 2: not required, 3 not exits
        try {
            if (paramItem == null || paramItem.getId() == 0L) {
                return new ResponseEntity<String>("3", HttpStatus.OK);
            }
            Parameter parameterDel = parameterService.getParamById(paramItem.getId());
            if (parameterDel == null) {
                return new ResponseEntity<String>("3", HttpStatus.OK);
            }
            boolean isUpdate = parameterService.deleteParameter(parameterDel, Utils.getIpClient(request));
            if (isUpdate) {
                return new ResponseEntity<String>("0", HttpStatus.OK);
            } else {
                return new ResponseEntity<String>("1", HttpStatus.OK);

            }

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("1", HttpStatus.OK);
        }
    }

    private boolean checkRequired(Parameter param) {
        boolean result = false;
        if (param.getKey() == null || param.getKey().isEmpty()) {
            result = false;
        } else if (param.getValue() == null || param.getValue().isEmpty()) {
            result = false;
        } else {
            result = true;
        }
        return result;
    }

}
