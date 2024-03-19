package com.ada.web.controller;

import com.ada.common.FileUtil;
import com.ada.model.Catalogy;
import com.ada.model.User;
import com.ada.model.dto.ResultUpload;
import com.ada.web.dao.CommonDao;
import com.ada.web.dao.GroupAuthorityDAO;
import com.ada.web.dao.ParameterDAO;
import com.ada.web.dao.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.*;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/common")
public class CommonController {

    private static final String PATTERN_FILE = ".";
    @Autowired
    ParameterDAO parameterDAO;
    @Autowired
    CommonDao commonDao;
    @Autowired
    GroupAuthorityDAO groupService;
    @Autowired
    UserDAO userService;
    @Value("${filesUpload_folder}")
    private String pathFile;

    private String pathFirst = "/app/webhome/web/cdn.ctv.osp.vn";


    /*upload file*/
    @RequestMapping(value = "/uploadFiles", method = RequestMethod.POST)
    public ResponseEntity<ResultUpload> uploadFile(@RequestBody @Valid final MultipartFile file) {
        User userLogin = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        pathFile = ConfigProperties.getConfigProperties("filesUpload_folder");
        if (file == null) {
            return new ResponseEntity<ResultUpload>(new ResultUpload(), HttpStatus.NO_CONTENT);
        }
        if (file.getSize() / 1024 / 1024 > 25) {
            return new ResponseEntity<ResultUpload>(new ResultUpload(), HttpStatus.NOT_ACCEPTABLE);
        }
        SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
        String strDate = yyyyMMdd.format(new Date());
//        String folder = parameterDAO.getParameterByKey(Constants.SYS_UPLOAD_FILE).getValue() + "/" + strDate;
        String folder = pathFile + "/YCTT/" + userLogin.getUsername() + "/" + strDate;
        File directory = new File(folder);
        if (!directory.exists()) {
            directory.mkdir();
        }
        ResultUpload item = new ResultUpload();
        try {

            if (!file.isEmpty()) {
                String suffixFile = file.getOriginalFilename().split("\\.")[1];
                File fileSave = FileUtil.createNewFileYCTT(folder, userLogin.getUsername() + "_YCTT" + strDate, suffixFile);
                String path = "";
                try {
                    FileOutputStream outputStream = null;
                    outputStream = new FileOutputStream(fileSave);
                    outputStream.write(file.getBytes());
                    path = fileSave.getPath();
                    item.setName(file.getOriginalFilename());
                    item.setPath(path);
                    outputStream.close();
                    return new ResponseEntity<ResultUpload>(item, HttpStatus.OK);
                } catch (IOException e) {
                    return new ResponseEntity<ResultUpload>(item, HttpStatus.OK);
                }
            }

        } catch (Exception e) {
            return new ResponseEntity<ResultUpload>(item, HttpStatus.OK);
        }
        return new ResponseEntity<ResultUpload>(item, HttpStatus.OK);
    }

    @RequestMapping(value = "/download", method = RequestMethod.GET)
    public void downloadFile(@RequestParam String name, @RequestParam String path, HttpServletRequest request, HttpServletResponse response) throws IOException {
        InputStream inputStream = null;
        try {
            if (path == null) {
                return;
            }
            //https://ctv.osp.vn/cdn
            path = pathFirst + path.replace("https://ctv.osp.vn/cdn", "");
            File file = new File(new String(path.getBytes("UTF-8"), "ASCII"));
            if (!file.exists()) {
                String errorMessage = "Sorry. The file you are looking for does not exist";
                OutputStream outputStream = response.getOutputStream();
                outputStream.write(errorMessage.getBytes());
                outputStream.close();
                return;
            }
            String mimeType = URLConnection.guessContentTypeFromName(file.getName());
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            response.setHeader("Content-Disposition", "inline;filename=" + URLEncoder.encode(name, "UTF-8"));

            response.setContentLength((int) file.length());
            inputStream = new BufferedInputStream(new FileInputStream(file));
            FileCopyUtils.copy(inputStream, response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }
    }

    //
    @GetMapping("/getListProvince")
    public ResponseEntity<List> getListProvince(HttpServletRequest request) {
        List<Catalogy> list = new ArrayList<>();
        try {
            list = commonDao.getALlProvince();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<List>(list, HttpStatus.OK);
    }

    @GetMapping("/getDistrictByProvince")
    public ResponseEntity<List> getListDistrict(@RequestParam(value = "province") Long provinceId, HttpServletRequest request) {
        return new ResponseEntity<>(commonDao.getDistrictByProvince(provinceId), HttpStatus.OK);
    }

    @GetMapping("/getWardByDistrict")
    public ResponseEntity<List> getWardByDistrict(@RequestParam(value = "districtId") Long provinceId, HttpServletRequest request) {
        return new ResponseEntity<>(commonDao.getWardByDistrict(provinceId), HttpStatus.OK);
    }

    //
//    @GetMapping("/getListProvinceWithMobiShop")
//    public ResponseEntity<List> getListProvinceWithMobiShop(HttpServletRequest request) {
//        List<AffCatCatalogy> list = new ArrayList<>();
//        try {
//            list = categoryDAO.getListProvinceWithMobiShop();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<List>(list, HttpStatus.OK);
//    }
//
//    @GetMapping("/getListDistrictWithMobiShop")
//    public ResponseEntity<List> getListDistrictWithMobiShop(@RequestParam(value = "province") Long provinceId, HttpServletRequest request) {
//        return new ResponseEntity<>(categoryDAO.getAllDistrictByProvinceIdWithMobiShop(provinceId), HttpStatus.OK);
//    }
//
//    @GetMapping("/getListDistrict")
//    public ResponseEntity<List> getListDistrict(@RequestParam(value = "province") Long provinceId, HttpServletRequest request) {
//        return new ResponseEntity<>(categoryDAO.getAllDistrictByProvinceId(provinceId), HttpStatus.OK);
//    }
//
//    @GetMapping("/getListWard")
//    public ResponseEntity<List> getListWard(@RequestParam(value = "district") Long districtId, HttpServletRequest request) {
//        return new ResponseEntity<>(categoryDAO.getAllWardByDistrictId(districtId), HttpStatus.OK);
//    }
//
//    @GetMapping("/getListGroupByAuthority")
//    public ResponseEntity<List> getListGroupByAuthority(@RequestParam(value = "authority") String authority, HttpServletRequest request) {
//        return new ResponseEntity<>(categoryDAO.getGroupByAuthority(authority), HttpStatus.OK);
//    }
//
//    @GetMapping("/getListShopNearMy")
//    public ResponseEntity<List> getListShopNearMy(@RequestParam(value = "province") Long provinceId, @RequestParam(value = "district") Long districtId) {
//        List<AffAdmMobiShop> list = new ArrayList<>();
//        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        try {
//            if (provinceId == null) {
//                provinceId = user.getProvince();
//            }
//            list = categoryDAO.getListShopNearMy(provinceId, districtId, Constants.TYPE_CUA_HANG);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<List>(list, HttpStatus.OK);
//    }
//
//    @PostMapping(value = "/upload")
//    public ResponseEntity<UploadFileModel> uploadFile2(@RequestPart(value = "file") MultipartFile multipartFile, @RequestParam(value = "type", required = false, defaultValue = "2") Long type, HttpServletRequest request) {
//        try {
//            if (multipartFile == null) {
//                return new ResponseEntity<>(new UploadFileModel(), HttpStatus.BAD_REQUEST);
//            } else {
//                SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
//                String strDate = yyyyMMdd.format(new Date());
//                String subSource = "";
//                if (Objects.equals(type, Constants.SOURCE_UPLOAD_FILE.ADMIN)) {
//                    subSource =   "admin/" + strDate;
//                } else if (Objects.equals(type, Constants.SOURCE_UPLOAD_FILE.WEB_AFF)){
//                    subSource = "web/" +  strDate;
//                } else {
//                    subSource = "site/" +  strDate;
//                }
//
//                String folder = pathFile + subSource;
//
//                File directory = new File(folder);
//
//                if (!directory.exists()) {
//                    directory.mkdir();
//                }
//                final String originalFilename = multipartFile.getOriginalFilename();
//                File file = FileUtil.createNewFile(folder, "CTR_");
//                try {
//                    multipartFile.transferTo(file);
//                    return ResponseEntity.ok(new UploadFileModel(subSource + "/" +file.getName(), originalFilename, true));
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    return new ResponseEntity<>(new UploadFileModel(), HttpStatus.INTERNAL_SERVER_ERROR);
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<>(new UploadFileModel(), HttpStatus.INTERNAL_SERVER_ERROR);
//    }
//
//    @PostMapping(value = "/uploadImages")
//    public ResponseEntity<UploadFileModel> uploadImages(@RequestPart(value = "file") MultipartFile multipartFile, @RequestParam(value = "type", required = false, defaultValue = "2") Long type, HttpServletRequest request) {
//        try {
//            if (multipartFile == null) {
//                return new ResponseEntity<>(new UploadFileModel(), HttpStatus.BAD_REQUEST);
//            } else {
//                SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
//                String strDate = yyyyMMdd.format(new Date());
//                String subSource = "";
//                if (Objects.equals(type, Constants.SOURCE_UPLOAD_FILE.ADMIN)) {
//                    subSource =   "admin/" + strDate;
//                } else if (Objects.equals(type, Constants.SOURCE_UPLOAD_FILE.WEB_AFF)){
//                    subSource = "web/" +  strDate;
//                } else {
//                    subSource = "site/" +  strDate;
//                }
//
//                String folder = pathFile + subSource;
//
//                File directory = new File(folder);
//
//                if (!directory.exists()) {
//                    directory.mkdir();
//                    directory.setReadable(true, false);
//                    directory.setExecutable(true, false);
//                }
//                final String newFileName = multipartFile.getName() + "_" + System.currentTimeMillis();
//                final String originalFilename = multipartFile.getOriginalFilename();
//                final String pattern = Objects.requireNonNull(originalFilename != null ? originalFilename.substring(originalFilename.lastIndexOf(PATTERN_FILE) + 1) : null);
//
//                //File file = FileUtil.createNewFile(folder, "CTR_");
//                final File file = new File(folder, newFileName + PATTERN_FILE + pattern);
//                try {
//                    multipartFile.transferTo(file);
////                    ImageResizer.resize(file,"", 50, 0);
//                    file.setReadable(true, false);
//                    file.setExecutable(true, false);
//                    return ResponseEntity.ok(new UploadFileModel(pathFile, subSource+ "/"+newFileName + PATTERN_FILE + pattern, true));
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    return new ResponseEntity<>(new UploadFileModel(), HttpStatus.INTERNAL_SERVER_ERROR);
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<>(new UploadFileModel(), HttpStatus.INTERNAL_SERVER_ERROR);
//    }
//
//    @GetMapping("/getListGroupMsisdn")
//    public ResponseEntity<List> getListGroupMsisdn(@RequestParam(value = "groupMsisdn") String groupMsisdn) {
//        List<AffGroupMsisdn> list = new ArrayList<>();
//        try {
//            list = categoryDAO.getListGroupMsisdn(groupMsisdn);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<List>(list, HttpStatus.OK);
//    }
//
//    @GetMapping("/getAllListDistrict")
//    public ResponseEntity<List> getAllListDistrict(HttpServletRequest request) {
//        return new ResponseEntity<>(categoryDAO.getAllListDistrict(), HttpStatus.OK);
//    }
//
//    @GetMapping("/getListGroupMsisdnChecked")
//    public ResponseEntity<List> getListGroupMsisdnChecked(@RequestParam(value = "campaignId") Long campaignId) {
//        List<GroupMsisdnView> list = new ArrayList<>();
//        try {
//            list = categoryDAO.getListGroupMsisdnChecked(campaignId);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<List>(list, HttpStatus.OK);
//    }
//
//    @GetMapping("/getAllPackageChecked")
//    public ResponseEntity<List> getAllPackageChecked(@RequestParam(value = "campaignId") Long campaignId) {
//        List<PackageView> list = new ArrayList<>();
//        try {
//            list = categoryDAO.getAllPackageChecked(campaignId);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<List>(list, HttpStatus.OK);
//    }
    @GetMapping("/checkSession")
    public ResponseEntity<String> checkSession(HttpServletRequest request) {
        //0: còn session, 1: hết session
        try {
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (user == null) {
                return new ResponseEntity<String>("1", HttpStatus.OK);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("1", HttpStatus.OK);
        }
        return new ResponseEntity<String>("0", HttpStatus.OK);
    }

//    @GetMapping("/getListUserReqPayment")
//    public ResponseEntity<List> getListUserReqPayment() {
//        User userLogin = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        List<User> list = new ArrayList<>();
//        Long shopRegion = null;
//        Long province = null;
//        try {
//            if (Objects.equals(userLogin.getType(), Constants.TYPE_USER.ADMIN_KV)) {
//                shopRegion = Long.valueOf(userLogin.getShopRegion());
//            }  else if (Objects.equals(userLogin.getType(), Constants.TYPE_USER.ADMIN_MBF_TINH)) {
//                province = userLogin.getProvince();
//            }
//            list = userService.getListUserReqPayment(shopRegion, province, userLogin.getType(), userLogin);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<List>(list, HttpStatus.OK);
//    }
//
//    @PostMapping(value = "/uploadMulti")
//    public ResponseEntity<List<UploadFileModel>> uploadMulti(@RequestParam(value = "file") MultipartFile[] multipartFile, @RequestParam(value = "type", required = false, defaultValue = "2") Long type, HttpServletRequest request) {
//        List<UploadFileModel> list = new ArrayList<>();
//        try {
//            if (multipartFile == null) {
//                return new ResponseEntity<>(list, HttpStatus.INTERNAL_SERVER_ERROR);
//            } else {
//                SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
//                String strDate = yyyyMMdd.format(new Date());
//                String subSource = "";
//                if (Objects.equals(type, Constants.SOURCE_UPLOAD_FILE.ADMIN)) {
//                    subSource =   "admin/" + strDate;
//                } else if (Objects.equals(type, Constants.SOURCE_UPLOAD_FILE.WEB_AFF)){
//                    subSource = "web/" +  strDate;
//                } else {
//                    subSource = "site/" +  strDate;
//                }
//
//                String folder = pathFile + subSource;
//
//                File directory = new File(folder);
//
//                if (!directory.exists()) {
//                    directory.mkdir();
//                }
//                String finalSubSource = subSource;
//                for (MultipartFile file: multipartFile) {
//                    File fileSave = null;
//                    try {
//                        fileSave = FileUtil.createNewFile(folder, "CTR_");
//                        file.transferTo(fileSave);
//                        list.add(new UploadFileModel(finalSubSource + "/" +fileSave.getName(), file.getOriginalFilename(), true));
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                    }
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return new ResponseEntity<>(list, HttpStatus.OK);
//    }
}
