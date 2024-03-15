package com.ada.web.controller;

import com.ada.common.*;
import com.ada.model.AffPartner;
import com.ada.model.api.request.PlaceRequest;
import com.ada.model.api.response.PlaceResponse;
import com.ada.web.dao.PartnerDao;
import com.ada.web.dao.PaymentDAO;
import com.ada.web.service.PartnerService;
import com.ada.web.service.chonsoApi.PalaceService;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/partner")
public class PartnerController {
    private Logger logger = LogManager.getLogger(PartnerController.class);

    public static String url_cdn = ConfigProperties.getConfigProperties("url_cdn");

    @Autowired
    PartnerDao partnerDao;
    @Autowired
    PaymentDAO paymentDAO;

    @Autowired
    PartnerService partnerService;

    @Autowired
    private PalaceService palaceService;

    @Autowired
    BCryptPasswordEncoder encoder;

    private final String templateExcel = "/fileTemplate/template_danh_sach_ctv.xlsx";


    @RequestMapping(value = "/index.html", method = RequestMethod.GET)
    public String list() {
        return "partner.list";
    }

    @GetMapping("/search")
    public ResponseEntity<PagingResult> search(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNumber,
                                               @RequestParam(value = "numberPerPage", required = false, defaultValue = "15") int numberPerPage,
                                               @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
                                               @RequestParam(value = "status", required = false, defaultValue = "") Long status,
                                               @RequestParam(value = "fromDate", required = false, defaultValue = "") String fromDate,
                                               @RequestParam(value = "toDate", required = false, defaultValue = "") String toDate) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        try {
            page = partnerService.page(page, mobile, status, fromDate, toDate).orElse(new PagingResult());
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
        return new ResponseEntity<>(page, HttpStatus.OK);
    }

    @GetMapping("/export")
    public ResponseEntity<PagingResult> export(@RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
                                               @RequestParam(value = "status", required = false, defaultValue = "") Long status,
                                               @RequestParam(value = "fromDate", required = false, defaultValue = "") String fromDate,
                                               @RequestParam(value = "toDate", required = false, defaultValue = "") String toDate,
                                               @RequestParam(value = "searchFlag", required = false, defaultValue = "") String searchFlag,
                                               HttpServletRequest request, HttpServletResponse response) {
        PagingResult page = new PagingResult();
        try {
            if ("false".equals(searchFlag.trim())) {
                page = partnerDao.searchAll().orElse(new PagingResult());
            } else {
                page = partnerService.page(page, mobile, status, fromDate, toDate).orElse(new PagingResult());
            }
            Map<String, Object> beans = new HashMap<>();
            beans.put("page", page);

            Resource resource = new ClassPathResource(templateExcel);
            InputStream fileIn = resource.getInputStream();
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);

            response.setContentType("application/vnd.ms-excel");
            SimpleDateFormat dateFormat = new SimpleDateFormat("ddMMyyyy");
            String dateDownload = dateFormat.format(new Date());
            response.setHeader("Content-Disposition", "attachment; filename= DanhSachCTV_" + dateDownload + ".xlsx");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
        return new ResponseEntity<>(page, HttpStatus.OK);
    }

    @RequestMapping(value = "/detail.html", method = RequestMethod.GET)
    public String edit() {
        return "partner.detail";
    }

    @RequestMapping(value = "/get", method = RequestMethod.GET)
    public ResponseEntity<?> get(@RequestParam(value = "id") Long id) {
        AffPartner affPartner = partnerService.findById(id);
        if (affPartner == null) {
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
        affPartner.setLinkSell(ConfigProperties.getConfigProperties("PATH_REF_LINK") + affPartner.getRefCode());

        PlaceRequest placeRequestTT = new PlaceRequest();
        placeRequestTT.setType("TT");
        placeRequestTT.setParentId("");
        PlaceResponse placeResponseTT;
        try {
            placeResponseTT = palaceService.places(placeRequestTT, null);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(affPartner, HttpStatus.OK);
        }
        affPartner.setPalaceTT(placeResponseTT);
        return new ResponseEntity<>(affPartner, HttpStatus.OK);
    }

    @RequestMapping(value = "/getDistrict", method = RequestMethod.GET)
    public ResponseEntity getDistrict(@RequestParam(value = "id") Long id) {
        PlaceRequest placeRequestQH = new PlaceRequest();
        placeRequestQH.setType("QH");
        placeRequestQH.setParentId(String.valueOf(id));
        PlaceResponse placeResponseQH = palaceService.places(placeRequestQH, null);
        if (placeResponseQH == null) {
            return new ResponseEntity<>("-1", HttpStatus.OK);
        }
        return new ResponseEntity<>(placeResponseQH, HttpStatus.OK);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public ResponseEntity<?> saveEdit(@RequestBody AffPartner affPartner) {
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();

        //handle image
        if (affPartner.getLinkFrontIdNumber() == null && ("").equals(affPartner.getLinkFrontIdNumber().trim()) || affPartner.getLinkBackIdNumber() == null && ("").equals(affPartner.getLinkBackIdNumber().trim())) {
            return new ResponseEntity<>("Ảnh không hợp lệ", HttpStatus.BAD_REQUEST);
        }

        String linkFrontImg = setFileName(Constants.FILE_NAME.INDENTITY_FRONT);
        String linkBackImg = setFileName(Constants.FILE_NAME.INDENTITY_BACK);
        String pathFile = FileCommon.PATH_DIR + FileCommon.PATH_FILE_INDENTITY + affPartner.getMobile() + "/";


        AffPartner editAffPartner = partnerService.findById(affPartner.getId());
        if (affPartner != null) {
            editAffPartner.setPartnerName(affPartner.getPartnerName());
            editAffPartner.setIdentityType(affPartner.getIdentityType());
            editAffPartner.setIdNumber(affPartner.getIdNumber());
            editAffPartner.setIdentityDate(affPartner.getIdentityDate());
            editAffPartner.setIdentityPlace(affPartner.getIdentityPlace());
            if (!Objects.equals(editAffPartner.getLinkFrontIdNumber(), affPartner.getLinkFrontIdNumber())) {
                if (FileCommon.uploadImageBase64(linkFrontImg, pathFile, affPartner.getLinkFrontIdNumber())) {
                    editAffPartner.setLinkFrontIdNumber(pathFile.replace(FileCommon.PATH_DIR, "") + linkFrontImg);
                    logger.info("Upload image front success, link is: " + editAffPartner.getLinkFrontIdNumber());
                }
            }
            if (!Objects.equals(editAffPartner.getLinkBackIdNumber(), affPartner.getLinkBackIdNumber())) {
                if (FileCommon.uploadImageBase64(linkBackImg, pathFile, affPartner.getLinkBackIdNumber())) {
                    editAffPartner.setLinkBackIdNumber(pathFile.replace(FileCommon.PATH_DIR, "") + linkBackImg);
                    logger.info("Upload image back success, link is: " + editAffPartner.getLinkBackIdNumber());
                }
            }
            editAffPartner.setAddress(affPartner.getAddress());
            editAffPartner.setLastUpdate(new Date(System.currentTimeMillis()));
            editAffPartner.setUpdateBy(auth.getName());
            editAffPartner.setStatus(affPartner.getStatus());
            editAffPartner.setProvinceId(affPartner.getProvinceId());
            editAffPartner.setDistrictId(affPartner.getDistrictId());
        }
        boolean isUpdate = partnerService.editPartner(editAffPartner);
        if (!isUpdate) return new ResponseEntity<>("1", HttpStatus.OK);

        return new ResponseEntity<>("0", HttpStatus.OK);
    }

    @RequestMapping(value = "/confirm", method = RequestMethod.POST)
    public ResponseEntity<?> confirmPartner(@RequestBody AffPartner affPartner) {
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();

        AffPartner editAffPartner = partnerService.findById(affPartner.getId());
        if (affPartner != null) {
            editAffPartner.setStatus(Constants.STATUS_PARTNER.ACTIVE);
            editAffPartner.setLastUpdate(new Date());
            editAffPartner.setUpdateBy(auth.getName());
        }
        boolean isUpdate = partnerService.editPartner(editAffPartner);
        if (!isUpdate) return new ResponseEntity<>("1", HttpStatus.OK);

        return new ResponseEntity<>("0", HttpStatus.OK);
    }

    @RequestMapping(value = "/block", method = RequestMethod.POST)
    public ResponseEntity<?> block(@RequestBody AffPartner affPartner) {
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();

        AffPartner editAffPartner = partnerService.findById(affPartner.getId());
        if (affPartner != null) {
            editAffPartner.setStatus(Constants.STATUS_PARTNER.BLOCK);
            editAffPartner.setLastUpdate(new Date());
            editAffPartner.setUpdateBy(auth.getName());
        }
        boolean isUpdate = partnerService.editPartner(editAffPartner);
        if (!isUpdate) return new ResponseEntity<>("1", HttpStatus.OK);

        return new ResponseEntity<>("0", HttpStatus.OK);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public ResponseEntity<?> delete(@RequestBody AffPartner affPartner) {
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();

        AffPartner editAffPartner = partnerService.findById(affPartner.getId());
        if (affPartner != null) {
            editAffPartner.setStatus(Constants.STATUS_PARTNER.DELETEBYOSP);
            editAffPartner.setLastUpdate(new Date());
            editAffPartner.setUpdateBy(auth.getName());
        }
        boolean isUpdate = partnerService.editPartner(editAffPartner);
        if (!isUpdate) return new ResponseEntity<>("1", HttpStatus.OK);

        return new ResponseEntity<>("0", HttpStatus.OK);
    }

    @RequestMapping(value = "/restore-password", method = RequestMethod.POST)
    public ResponseEntity<?> restorePass(@RequestBody AffPartner partner, HttpServletRequest request) {
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();
        try {
            AffPartner partnerRePass = partnerService.findById(partner.getId());
            if (partnerRePass != null) {
                partnerRePass.setPwd(Config.hashMd5Password(Constants.PASSWORD_DEFAULT));
                partnerRePass.setLastUpdate(new Date());
                partnerRePass.setUpdateBy(auth.getName());
            }
            boolean isUpdate = partnerService.editPartner(partnerRePass);
            if (!isUpdate) return new ResponseEntity<>("1", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ResponseEntity<>("0", HttpStatus.OK);
    }

    @GetMapping("/findById")
//    @Secured(ConstantAuthor.CTV.view)
    public ResponseEntity<AffPartner> findById(@RequestParam(value = "id", required = false, defaultValue = "") Long id) {
        if (id == null) {
            return new ResponseEntity<AffPartner>(new AffPartner(), HttpStatus.OK);
        } else {
            AffPartner user = partnerDao.findById(id);

            user.setTotalAmount(paymentDAO.getTotalAmountByIdPartner(id));
            Long fee = 0L;
//            Parameter parameter = parameterDAO.getParameterByKey(Constants.SYS_FEE_PAYMENT_KEY);
//            if (parameter != null && parameter.getValue() != null && parameter.getValue().equals(Constants.FEE_PAYMENT.PAY)) {
//                fee = calShareMoneyService.tinhPhiRutTien(user.get());
//            }
            user.setFee(fee);
            return new ResponseEntity<AffPartner>(user, HttpStatus.OK);
        }
    }

//	@GetMapping("/partners")
////    @Secured(ConstantAuthor.CTV.view)
//    public ResponseEntity<PagingResult> UserList(Model model,
//                                                 @RequestParam(value = "pageNumber", required = false, defaultValue = "1") int pageNumber,
//                                                 @RequestParam(value = "numberPerPage", required = false, defaultValue = "1") int numberPerPage,
//                                                 @RequestParam(value = "partnerName", required = false, defaultValue = "") String partnerName,
//                                                 @RequestParam(value = "type", required = false, defaultValue = "") String type,
//                                                 @RequestParam(value = "username", required = false, defaultValue = "") String username,
//                                                 @RequestParam(value = "status", required = false, defaultValue = "") String status,
//                                                 @RequestParam(value = "idNumber", required = false, defaultValue = "") String idNumber,
//                                                 @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
//                                                 @RequestParam(value = "shopRegion", required = false, defaultValue = "") String shopRegion,
//                                                 @RequestParam(value = "province", required = false, defaultValue = "") String province,
//                                                 @RequestParam(value = "district", required = false, defaultValue = "") String district,
//                                                 @RequestParam(value = "fromGenDate", required = false, defaultValue = "") String fromGenDate,
//                                                 @RequestParam(value = "toGenDate", required = false, defaultValue = "") String toGenDate,
//                                                 @RequestParam(value = "shopCode", required = false, defaultValue = "") String shopCode,
//                                                 @RequestParam(value = "pointCode", required = false, defaultValue = "") String pointCode,
//                                                 @RequestParam(value = "staffCode", required = false, defaultValue = "") String staffCode,
//                                                 @RequestParam(value = "shareCode", required = false, defaultValue = "") String shareCode,
//                                                 @RequestParam(value = "presenter", required = false, defaultValue = "") String presenter) {
//        PagingResult page = new PagingResult();
//        page.setPageNumber(pageNumber);
//        page.setNumberPerPage(numberPerPage);
//        page = partnerService.pagepartner(Utils.trim(partnerName), Utils.trim(type), Utils.trim(username), Utils.trim(status), Utils.trim(idNumber), Utils.trim(mobile), Utils.trim(shopRegion),
//                Utils.trim(province), Utils.trim(district), Utils.trim(fromGenDate), Utils.trim(toGenDate), page, true, Utils.trim(shopCode), Utils.trim(pointCode), Utils.trim(staffCode),
//                Utils.trim(shareCode), Utils.trim(presenter)).orElse(new PagingResult());
//        page.setMessage(ConfigProperties.getlanguagesProperties("link.cdn"));
//        return new ResponseEntity<PagingResult>(page, HttpStatus.OK);
//    }

    private String setFileName(String key) {
        return String.format(key, new Date().getTime() + ".jpg");
    }

//    private String getPath(String imageBase64, String mobile, String fileName) {
//        return FileCommon.uploadImageBase64(fileName, FileCommon.PATH_FILE_INDENTITY + mobile + "/", imageBase64 );
//    }
}
