package com.ada.web.controller;

import com.ada.common.*;
import com.ada.model.*;
import com.ada.model.dto.ChangePassDto;
import com.ada.model.view.AuthorityView;
import com.ada.model.view.GroupView;
import com.ada.web.dao.CommonDao;
import com.ada.web.dao.LogAccessDAO;
import com.ada.web.dao.UserDAO;
import com.ada.web.dao.GroupAuthorityDAO;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by Admin on 12/26/2017.
 */
@Controller
@RequestMapping("/system")
public class SystemUserController {

    private Logger logger = LogManager.getLogger(SystemUserController.class);
    @Autowired
    UserDAO userDAO;
    @Autowired
    GroupAuthorityDAO groupService;
    @Autowired
    LogAccessDAO logAccessService;
    @Autowired
    CommonDao commonDao;
    @Autowired
    BCryptPasswordEncoder encoder;


    @GetMapping("/user/quan-ly-tai-khoan-he-thong.html")
//    @Secured(ConstantAuthor.User.view)
    public String index() {
        return "user.list";
    }

    @GetMapping("/user/thong-tin-ca-nhan.html")
//    @Secured(ConstantAuthor.User.view)
    public String info() {
        return "user.info";
    }

    @GetMapping("/user/getInfo")
//    @Secured(ConstantAuthor.User.view)
    public ResponseEntity<?> getInfo() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = userDAO.getByUsername(auth.getName()).orElse(null);
        if (user != null) {
            return new ResponseEntity<>(user, HttpStatus.OK);
        }
        return new ResponseEntity<>("-1", HttpStatus.OK);
    }

    @GetMapping("/user/search")
//    @Secured(ConstantAuthor.User.view)
    public ResponseEntity<?> search(Model model, @RequestParam(value = "p", required = false, defaultValue = "1") int pageNumber, @RequestParam(value = "numberPerPage", required = false, defaultValue = "5") int numberPerPage, @RequestParam(value = "username", required = false, defaultValue = "") String filterUsername, @RequestParam(value = "type", required = false, defaultValue = "-1") Long type) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        page = userDAO.pageUser(Utils.trim(filterUsername), type, page).orElse(new PagingResult());
        return new ResponseEntity<>(page, HttpStatus.OK);
    }

    @GetMapping("/user/search-group-by-user-{userId}")
//    @Secured(ConstantAuthor.User.view)
    public String ViewGroupList(Model model, @RequestParam(value = "p", required = false, defaultValue = "1") int pageNumber, @PathVariable long userId) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(10);
        if (userId == 0) {
            return "404";
        }

//        List<Group> listGroups = groupService.loadAllGroupOfUser(userId).orElse(new ArrayList<>());
//        
//        if(listGroups != null && !listGroups.isEmpty()){
//            page.setItems(listGroups);
//            page.setRowCount(listGroups.size());
//        }
        page = groupService.pageGroupByUser(userId, page).orElse(new PagingResult());

        model.addAttribute("pageViewGroup", page);
        User user = userDAO.get(userId).orElse(null);
        model.addAttribute("userView", user);
        return "system/user/groupByUser";
    }

    @PostMapping("/user/update")
//    @Secured(ConstantAuthor.User.edit)
    public ResponseEntity<?> update(@RequestBody User dto, HttpServletRequest request) {
        try {
            User userCheck = commonDao.findById(User.class, dto.getId());
            if (userCheck == null) {
                return new ResponseEntity<>("-1", HttpStatus.OK);
            }
            commonDao.update(dto);
            return new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>("0", HttpStatus.OK);
    }

    @PostMapping("/user/restore-pass")
//    @Secured(ConstantAuthor.User.edit)
    public ResponseEntity<?> restorePass(@RequestBody User dto, HttpServletRequest request) {
        try {
            User userCheck = commonDao.findById(User.class, dto.getId());
            if (userCheck == null) {
                return new ResponseEntity<>("-1", HttpStatus.OK);
            }
            dto.setPassword(encoder.encode(Constants.PASSWORD_DEFAULT));
            commonDao.update(dto);
            return new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>("0", HttpStatus.OK);
    }

    @GetMapping("/user/export")
//    @Secured(ConstantAuthor.CTV_USER_MGMT.view)
    public void export(@RequestParam(value = "pageNumber", required = false, defaultValue = "1") int pageNumber, @RequestParam(value = "numberPerPage", required = false, defaultValue = "15") int numberPerPage, @RequestParam(value = "username", required = false, defaultValue = "") String username, @RequestParam(value = "type", required = false, defaultValue = "-1") Long type, HttpServletRequest request, HttpServletResponse response) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        try {
            page.setPageNumber(pageNumber);
            page.setNumberPerPage(numberPerPage);
            page = userDAO.pageUser(Utils.trim(username), type, page).orElse(new PagingResult());
            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("items", page.getItems());

            String realPathOfFolder = request.getServletContext().getRealPath(ConfigProperties.getConfigProperties("template_path"));
            InputStream fileIn = new BufferedInputStream(new FileInputStream(realPathOfFolder + "ada-user-system.xlsx"));

            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);
            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename=" + dateDownload + "_DS_tai_khoan_he_thong_ADA.xlsx");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/user/phan-quyen-nguoi-dung.html/{id}", method = RequestMethod.GET)
    public String userGroup(Model model, @PathVariable("id") Long id) {
        if (id == null) {
            return "404";
        }
        User user = userDAO.get(id).orElse(null);
        if (user == null) {
            return "404";
        }
        //load all groups
        List<Group> allGroups = groupService.loadAllGroup().orElse(new ArrayList<>());
        //load group of user
        List<Group> listGroups = groupService.loadAllGroupOfUser(id).orElse(new ArrayList<>());
        String groups = "";
        if (listGroups.size() > 0) {
            for (Group item : listGroups) {
                groups += item.getId() + ",";
            }
        }
        model.addAttribute("user", user);
        model.addAttribute("listGroupId", groups);
        model.addAttribute("allGroups", allGroups);
        return "user.group";
    }

    @GetMapping("/user/user-group-view-{id}")
//    @Secured(ConstantAuthor.User.author)
    public String groupEdit(Model model, @PathVariable("id") Long id) {
        if (id == null || id.intValue() == 0) {
            return "404";
        }
        GroupView item = groupService.getGroupView(id).orElse(null);
        if (item == null) {
            return "404";
        }
        List<Authority> items = groupService.loadAllAuthority().orElse(new ArrayList<>());
        if (items == null && items.size() == 0) {
            return "404";
        }

        loadGroupAuthorityToModel(model, item, items);
        model.addAttribute("item", item);
        return "system/user/userGroupView";
    }

    @PostMapping("/user/user-group")
//    @Secured(ConstantAuthor.User.author)
    public String addUserGroup(Model model, Long id, String listGroup, RedirectAttributes attributes) {
        if (id == null) {
            return "404";
        }
        User user = userDAO.get(id).orElse(null);
        if (user == null) {
            return "404";
        }
        listGroup = Utils.trim(listGroup);
        try {
            if (listGroup.length() > 0) {
                String[] array = listGroup.split(",");
                List<String> stringList = Arrays.stream(array).collect(Collectors.toList());
                if (stringList.size() > 0) {
                    List<GroupUser> items = new ArrayList<>();
                    User userCurrent = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                    for (String item : stringList) {
                        items.add(new GroupUser(Long.valueOf(item), id, userCurrent.getUsername(), new Date()));
                    }
                    if (items.size() > 0) {
                        groupService.addListGroupUser(items, id);
                    }
                }
            } else {
                groupService.deleteListGroupOfUser(id);
            }
            attributes.addFlashAttribute("success", "message.user.set.role.success");
            return "redirect:/system/user/quan-ly-tai-khoan-he-thong.html";
        } catch (Exception e) {
            logger.error("Have an error SystemUserController.addUserGroup:" + e.getMessage());
            model.addAttribute("errorMessage", "message.have.error");
            //load all groups
            List<Group> allGroups = groupService.loadAllGroup().orElse(new ArrayList<>());
            model.addAttribute("user", user);
            model.addAttribute("groups", listGroup);
            model.addAttribute("allGroups", allGroups);
        }
        model.addAttribute("errorMessage", "message.have.error");
        return "user.group";
    }

    @PostMapping("/info/change-my-pass")
    public ResponseEntity<Integer> changeMyPass(@RequestBody ChangePassDto dto, HttpServletRequest request) {
        //0-dieu kien ko phu hop, 1-oke thanh cong,2-mat khau cu khong dung,3-co loi server khi change
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        dto.setPasswordCurrent(Utils.trim(dto.getPasswordCurrent()));
        dto.setPasswordNew(Utils.trim(dto.getPasswordNew()));
        if (StringUtils.isBlank(dto.getPasswordCurrent()) || StringUtils.isBlank(dto.getPasswordNew())) {
            return new ResponseEntity<Integer>(0, HttpStatus.OK);
        }
        Integer result = 0;
        try {
            String ipClient = Utils.getIpClient(request);
            result = userDAO.changeMyPass(dto.getPasswordCurrent(), dto.getPasswordNew(), user, ipClient).orElse(3);
        } catch (Exception e) {
            return new ResponseEntity<Integer>(3, HttpStatus.OK);
        }
        return new ResponseEntity<Integer>(result, HttpStatus.OK);
    }

    public void loadGroupAuthorityToModel(Model model, GroupView groupView, List<Authority> items) {
        List<String> listAutho = new ArrayList<String>(Arrays.asList(groupView.getListAuthority().split(",")));
        List<AuthorityView> list = new ArrayList<>();
        List<AuthorityView> resultList = new ArrayList<>();
        List<Authority> childrens = new ArrayList<>();
        for (Authority item : items) {
            if (item.getFid() == 0) {
                AuthorityView au = new AuthorityView();
                au.setParent(item);
                list.add(au);
            }
        }

        for (AuthorityView item : list) {
            childrens = new ArrayList<>();
            for (Authority authority : items) {
                if (authority.getFid() == item.getParent().getId()) {
                    if (listAutho.contains(authority.getId() + "")) {
                        childrens.add(authority);
                    }
                }
            }
            item.setChildrens(childrens);
        }
        for (AuthorityView item : list) {
            if (!item.getChildrens().isEmpty() || listAutho.contains(item.getParent().getId() + "")) {
                resultList.add(item);
            }
        }
        model.addAttribute("groups", resultList);
    }

}
