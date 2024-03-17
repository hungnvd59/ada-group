package com.ada.web.controller;

import com.ada.common.ConstantAuthor;
import com.ada.common.PagingResult;
import com.ada.common.Utils;
import com.ada.model.Authority;
import com.ada.model.User;
import com.ada.web.dao.LogAccessDAO;
import com.ada.web.dao.UserDAO;
import com.ada.web.service.AuthorityService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
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
@RequestMapping("/system/authority")
public class AuthorityController {

    private Logger logger = LogManager.getLogger(AuthorityController.class);
    @Autowired
    LogAccessDAO logAccessDao;
    @Autowired
    UserDAO userDao;
    @Autowired
    AuthorityService authorityService;

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

    @GetMapping("/quan-ly-chuc-nang-he-thong.html")
//    @Secured(ConstantAuthor.AUTHORITY.viewList)
    public String getListAuthority() {
        return "authority.list";
    }

    @GetMapping("/search")
//    @Secured(ConstantAuthor.AUTHORITY.viewList)
    public ResponseEntity<?> authorityList(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNumber,
                                           @RequestParam(value = "numberPerPage", required = false, defaultValue = "15") int numberPerPage,
                                           @RequestParam(value = "authKey") String authKey) {
        User userLogin = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        logger.info(userLogin.getUsername() + "------------- GET /system/authority/search");
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        try {
            page = authorityService.page(page, Utils.trim(authKey)).orElse(new PagingResult());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>(page, HttpStatus.OK);
    }

    @GetMapping("/get-list-auth-parent")
//    @Secured(ConstantAuthor.Authority.view)
    public ResponseEntity<List<Authority>> getListAuthparent(Long authId) {
        if (authId == null) {
            authId = 0L;
        }
        List<Authority> authoritys = new ArrayList<>();
        try {
            authoritys = authorityService.getListAuthParent(authId);
        } catch (Exception e) {

        }
        return new ResponseEntity<List<Authority>>(authoritys, HttpStatus.OK);
    }

    @PostMapping(value = "/add")
//    @Secured(ConstantAuthor.Authority.add)
    public ResponseEntity<String> addAuthority(@RequestBody Authority authItem, HttpServletRequest request) {
        String page = "0";  // 0: no error, 1: error, 2: not required, 3 key exits
        try {
            if (!checkRequired(authItem)) {
                return new ResponseEntity<String>("2", HttpStatus.OK);
            } else if (authorityService.isExits(authItem)) {
                return new ResponseEntity<String>("3", HttpStatus.OK);
            } else {
                boolean isUpdate = authorityService.addAuthority(authItem, Utils.getIpClient(request));
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
//    @Secured(ConstantAuthor.Authority.edit)
    public ResponseEntity<String> editAuthority(@RequestBody Authority authItem, HttpServletRequest request) {
        String page = "0";  // 0: no error, 1: error, 2: not required, 3 not exits, 4 had auth child
        try {
            if (!checkRequired(authItem)) {
                return new ResponseEntity<String>("2", HttpStatus.OK);
//            } else if (authorityService.isExits(paramItem)) {
//                return new ResponseEntity<String>("3", HttpStatus.OK);
            } else {
                if (authItem == null || authItem.getId() == 0L) {
                    return new ResponseEntity<String>("3", HttpStatus.OK);
                }
                Authority authorityEdit = authorityService.getAuthorityById(authItem.getId());
                if (authorityEdit == null) {
                    return new ResponseEntity<String>("3", HttpStatus.OK);
                }

                if (!Objects.equals(authorityEdit.getFid(), authItem.getFid())) {
                    List<Authority> authorityChild = authorityService.getAuthorityChildrenById(authItem.getId());
                    if (authorityChild != null && !authorityChild.isEmpty() && authorityChild.size() > 0) {
                        return new ResponseEntity<String>("4", HttpStatus.OK);
                    }
                    authorityEdit.setFid(authItem.getFid());
                }

                authorityEdit.setDescription(authItem.getDescription());
                authorityEdit.setAuthority(authItem.getAuthority());
                boolean isUpdate = authorityService.editAuthority(authorityEdit, Utils.getIpClient(request));
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
//    @Secured(ConstantAuthor.Authority.delete)
    public ResponseEntity<String> deleteAuthority(@RequestBody Authority authItem, HttpServletRequest request) {
        String page = "0";  // 0: no error, 1: error, 2: not required, 3 not exits, 4 assigned, 5 had auth child
        try {
            if (authItem == null || authItem.getId() == 0L) {
                return new ResponseEntity<String>("3", HttpStatus.OK);
            }
            Authority authorityDel = authorityService.getAuthorityById(authItem.getId());
            if (authorityDel == null) {
                return new ResponseEntity<String>("3", HttpStatus.OK);
            }

            List<Authority> authorityChild = authorityService.getAuthorityChildrenById(authItem.getId());
            if (authorityChild != null && !authorityChild.isEmpty() && authorityChild.size() > 0) {
                return new ResponseEntity<String>("5", HttpStatus.OK);
            }

            boolean checkAssigned = authorityService.checkAuthorityAssigned(authItem.getId());
            if (checkAssigned) {
                return new ResponseEntity<String>("4", HttpStatus.OK);
            }

            boolean isUpdate = authorityService.deleteAuthority(authorityDel, Utils.getIpClient(request));
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

    private boolean checkRequired(Authority authority) {
        boolean result = false;
        if (authority.getAuthority() == null || authority.getAuthority().isEmpty()) {
            result = false;
        } else if (authority.getDescription() == null || authority.getDescription().isEmpty()) {
            result = false;
        } else {
            result = true;
        }
        return result;
    }

}
