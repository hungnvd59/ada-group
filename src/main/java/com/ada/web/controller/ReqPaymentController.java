package com.ada.web.controller;

import com.google.gson.Gson;
import com.ada.common.*;
import com.ada.model.*;
import com.ada.model.dto.ReqPaymentDTO;
import com.ada.model.view.AffReqPaymentView;
import com.ada.model.view.FileUpload;
import com.ada.model.view.ReqPaymentView;
import com.ada.web.dao.*;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

//import com.osp.web.service.CalShareMoneyService;

@Controller
@RequestMapping("/reqPayment")
public class ReqPaymentController {
    private Logger logger = LogManager.getLogger(ReqPaymentController.class);
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
    SimpleDateFormat sdfHHMM = new SimpleDateFormat("dd/MM/yyyy hh:mm");
    SimpleDateFormat sdf24 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
    SimpleDateFormat input = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
    private final String templateExcel = "/fileTemplate/template_yeu_cau_thanh_toan.xlsx";
    private final String templateExcelDs = "/fileTemplate/template_yeu_cau_thanh_toan_doi_soat.xlsx";
    private static final String PATTERN_FILE = ".";
    public static String url_cdn = ConfigProperties.getConfigProperties("url_cdn");

    @Autowired
    PaymentDAO paymentDAO;

    @Autowired
    UserDAO userDAO;

    @Autowired
    FilesDAO filesDAO;

    @Autowired
    ActionLogDAO actionLogDAO;

//    @Autowired
//    CalShareMoneyService calShareMoneyService;

//    @Autowired
//    TransPackageDAO transPackageDAO;


    @Autowired
    ParameterDAO parameterDAO;


    @Autowired
    PartnerDao partnerDao;

    @GetMapping("/index.html")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.view)
    public String index() {
        return "reqPaymentIndex";
    }

    @GetMapping("/detail.html")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.view)
    public String edit() {
        return "reqPaymentDetail";
    }

    @RequestMapping(value = "/add.html", method = RequestMethod.GET)
    public String add() {
        return "reqPaymentAdd";
    }

    @GetMapping("/getPartner")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.view)
    public ResponseEntity<List<AffPartner>> getPartner() {
        List<AffPartner> result = paymentDAO.getPartner();
        if (result == null && result.size() == 0) {
            return null;
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/search")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.view)
    public ResponseEntity<PagingResult> search(@RequestParam(value = "pageNumber", required = false, defaultValue = "1") int pageNumber,
                                               @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
                                               @RequestParam(value = "status", required = false, defaultValue = "") Long status,
                                               @RequestParam(value = "numberPerPage", required = false, defaultValue = "15") int numberPerPage,
                                               @RequestParam(value = "fromDate", required = false, defaultValue = "") String fromGenDate,
                                               @RequestParam(value = "toDate", required = false, defaultValue = "") String toGenDate,
                                               @RequestParam(value = "fromPaymentDate", required = false, defaultValue = "") String fromPaymentDate,
                                               @RequestParam(value = "toPaymentDate", required = false, defaultValue = "") String toPaymentDate,
                                               @RequestParam(value = "reqCode", required = false, defaultValue = "") String reqCode) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        Timestamp fromDate = null;
        Timestamp toDate = null;
        Timestamp fromReqDate = null;
        Timestamp toReqDate = null;
        try {
            if (fromGenDate != null && !"".equals(fromGenDate)) {
                String strFdate = fromGenDate + " 00:00:00";
                fromDate = new Timestamp(sdf.parse(strFdate).getTime());
            }
            if (toGenDate != null && !"".equals(toGenDate)) {
                String strTdate = toGenDate + " 23:59:59";
                toDate = new Timestamp(sdf.parse(strTdate).getTime());
            }
            if (fromPaymentDate != null && !"".equals(fromPaymentDate)) {
                String strFdate = fromPaymentDate + " 00:00:00";
                fromReqDate = new Timestamp(sdf.parse(strFdate).getTime());
            }
            if (toPaymentDate != null && !"".equals(toPaymentDate)) {
                String strTdate = toPaymentDate + " 23:59:59";
                toReqDate = new Timestamp(sdf.parse(strTdate).getTime());
            }
            page = paymentDAO.pageReqPayment(page, mobile, status, fromDate, toDate, fromReqDate, toReqDate, reqCode, null).orElse(new PagingResult());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<PagingResult>(page, HttpStatus.OK);
    }

    @GetMapping("/exportExcel")
    public void exportExcel(HttpServletResponse response, HttpServletRequest request,
                            @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
                            @RequestParam(value = "username", required = false, defaultValue = "") String username,
                            @RequestParam(value = "status", required = false, defaultValue = "") Long status,
                            @RequestParam(value = "numberPer", required = false, defaultValue = "") Long numberPer,
                            @RequestParam(value = "fromDate", required = false, defaultValue = "") String fromGenDate,
                            @RequestParam(value = "toDate", required = false, defaultValue = "") String toGenDate,
                            @RequestParam(value = "type", required = false, defaultValue = "") String type,
                            @RequestParam(value = "fromPaymentDate", required = false, defaultValue = "") String fromPaymentDate,
                            @RequestParam(value = "toPaymentDate", required = false, defaultValue = "") String toPaymentDate,
                            @RequestParam(value = "reqCode", required = false, defaultValue = "") String reqCode) {

        PagingResult page = new PagingResult();
        page.setPageNumber(1);
        page.setNumberPerPage(Math.toIntExact(numberPer));
        SimpleDateFormat ddMMyyyy = new SimpleDateFormat("dd-MM-yyyy");
        Timestamp fromDate = null;
        Timestamp toDate = null;
        Timestamp fromReqDate = null;
        Timestamp toReqDate = null;
        try {
            if (fromGenDate != null && !"".equals(fromGenDate)) {
                String strFdate = fromGenDate + " 00:00:00";
                fromDate = new Timestamp(sdf.parse(strFdate).getTime());
            }
            if (toGenDate != null && !"".equals(toGenDate)) {
                String strTdate = toGenDate + " 23:59:59";
                toDate = new Timestamp(sdf.parse(strTdate).getTime());
            }
            if (fromPaymentDate != null && !"".equals(fromPaymentDate)) {
                String strFdate = fromPaymentDate + " 00:00:00";
                fromReqDate = new Timestamp(sdf.parse(strFdate).getTime());
            }
            if (toPaymentDate != null && !"".equals(toPaymentDate)) {
                String strTdate = toPaymentDate + " 23:59:59";
                toReqDate = new Timestamp(sdf.parse(strTdate).getTime());
            }
            page = paymentDAO.pageReqPayment(page, mobile, status, fromDate, toDate, fromReqDate, toReqDate, reqCode, type).orElse(new PagingResult());
            Map<String, Object> beans = new HashMap<String, Object>();
            List<String> status1 = new ArrayList<>();
            status1.add("Đang xử lý");
            status1.add("Từ chối");
            status1.add("Hoàn tất");
            List<String> status2 = new ArrayList<>();
            status2.add("Từ chối");
            status2.add("Hoàn tất");
            List<ReqPaymentView> list = (List<ReqPaymentView>) page.getItems();

            for (ReqPaymentView item : list) {
                if (item.getStatus() == 1) {
                    item.setListStatus(status1);
                }
                if (item.getStatus() == 3) {
                    item.setListStatus(status2);
                }

            }
            beans.put("page", page);
            beans.put("sysDate", ddMMyyyy.format(new Date()));
            Resource resource = null;
            if (type != null && "1".equals(type)) {
                resource = new ClassPathResource(templateExcelDs);
            } else {
                resource = new ClassPathResource(templateExcel);
            }

            InputStream fileIn = resource.getInputStream();
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=" + ddMMyyyy.format(new Date()) + "_DSYeuCauThanhToan.xlsx");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @PostMapping(value = "/addReqPayment")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.add)
    public ResponseEntity<String> add(@RequestBody ReqPaymentDTO reqPayment, HttpServletRequest request) {
        User userLogin = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
//      -------------------------------Create ReqPayment------------------------------------------
            AffPartner user = partnerDao.findById(reqPayment.getReqPayment().getPartnerId());

            // check xem có yêu cầu nào đang ở trạng thái chờ duyệt hay không?
            Long countWait = paymentDAO.checkRequestWait(user.getId());

            //check xem co yeu cau nao dang xử ly không
            Long countDoing = paymentDAO.checkRequestDoing(user.getId());

            if (countWait > 0) {
                return new ResponseEntity<String>("6", HttpStatus.OK);
            }
            if (countDoing > 0) {
                return new ResponseEntity<String>("7", HttpStatus.OK);
            }

            boolean checkInfo = checkRequiredInfo(user);

            if (!checkInfo) {
                return new ResponseEntity<String>("4", HttpStatus.OK);
            }

            boolean checkEqName = checkEqNameInfo(user);

            if (!checkEqName) {
                return new ResponseEntity<String>("5", HttpStatus.OK);
            }

            //tính phí
            Long fee = 0L;
            Parameter parameter = parameterDAO.getParameterByKey(Constants.SYS_FEE_PAYMENT_KEY);
            if (parameter != null && parameter.getValue() != null && parameter.getValue().equals(Constants.FEE_PAYMENT.PAY)) {
//                fee = calShareMoneyService.tinhPhiRutTien(user);
            }

            boolean flag = false;
            AffReqPayment resultAdd = null;
            if (!checkRequired(reqPayment.getReqPayment())) {
                return new ResponseEntity<String>("2", HttpStatus.OK);
            } else {
                String reqCode = paymentDAO.genReqCode();
                AffReqPayment rsAdd = new AffReqPayment();
                rsAdd.setDescription(reqPayment.getReqPayment().getDescription());
                rsAdd.setAmount(reqPayment.getReqPayment().getAmount());
                rsAdd.setAccName(reqPayment.getReqPayment().getAccName());
                rsAdd.setAccBank(reqPayment.getReqPayment().getAccBank());
                rsAdd.setAccNumber(reqPayment.getReqPayment().getAccNumber());
                rsAdd.setAccBranch(reqPayment.getReqPayment().getAccBranch());
                rsAdd.setPaymentBy(reqPayment.getReqPayment().getPaymentBy());
                rsAdd.setPartnerId(reqPayment.getReqPayment().getPartnerId());
                rsAdd.setFee(fee);
                rsAdd.setReqCode(reqCode.trim());
                rsAdd.setGenDate(new Date());
                rsAdd.setAccBank(user.getAccBank());
                rsAdd.setAccBranch(user.getAccBranch());
                rsAdd.setAccName(user.getAccName());
                rsAdd.setAccNumber(user.getAccNumber());
                rsAdd.setWalletBalance(user.getAccBalance());
                if (user == null) {
                    logger.info("Khong tim thay user tao yeu cau: " + reqPayment.getReqPayment().getPartnerId());
                    return new ResponseEntity<String>("1", HttpStatus.OK);
                }
                logger.info("vi tien truoc khi tru thanh toan user: " + user.getUserName() + " so du = " + user.getAccBalance());
                rsAdd.setSourceRequest(Constants.SOURCE_REQUEST.ADMIN);
                rsAdd.setStatus(Constants.TYPE_PAYMENT.CHO_XY_LY);
                rsAdd.setContent(Constants.SOURCE_LOGS.YEU_CAU_THANH_TOAN + ": Tạo yêu cầu thanh toán!");
                rsAdd.setCreateBy(userLogin.getUsername());

                if (rsAdd.getStatus() != null && !"".equals(rsAdd.getStatus()) && Objects.equals(rsAdd.getStatus(), Constants.TYPE_PAYMENT.DA_DUYET)) {
                    rsAdd.setApproveBy(userLogin.getUsername());
                    rsAdd.setApproveDate(new Date());
                    rsAdd.setLastUpdated(new Date());
                    rsAdd.setUpdateBy(userLogin.getUsername());

                }
                resultAdd = paymentDAO.addReqPayment(rsAdd);
                if (resultAdd.getId() != null) {
                    // thêm logs
                    AffActionLogs logs = new AffActionLogs();// parse old data to json
//                    actionLogDAO.createFullLogInsert(logs, resultAdd, request);

                    //create logs
                    logs.setAction(Constants.ACTION_LOGS.THEM);
                    logs.setSource_logs(Constants.SOURCE_LOGS.YEU_CAU_THANH_TOAN);
                    logs.setUser_type("ADMIN");
                    logs.setUser_name(userLogin.getUsername());
                    logs.setInfo("Thêm mới thông tin yêu cầu thanh toán");
                    logs.setObject_id(rsAdd.getId());
                    logs.setGen_date(new Date());
                    actionLogDAO.addActionLog(logs);
                } else {
                    logger.info("Tao yeu cau thanh toan khong thanh cong cho user: " + reqPayment.getReqPayment().getPartnerId());
                    return new ResponseEntity<String>("1", HttpStatus.OK);
                }
            }
//      -------------------------------Create Payment------------------------------------------
            if (resultAdd != null) {
                if (checkRequired(resultAdd)) {
                    AffPayment affPayment = new AffPayment();
                    affPayment.setReqPaymentId(resultAdd.getId());
                    affPayment.setAmount(resultAdd.getAmount());
                    affPayment.setDescription(resultAdd.getDescription());
                    affPayment.setStatus(Constants.STATUS_NUM.HIEU_LUC);
                    affPayment.setPaymentBy(resultAdd.getPaymentBy());
//                    affPayment.setPaymentDate(sdf.parse(reqPayment.getReqPayment().getPaymentDate()));
                    affPayment.setGenDate(new Date());
                    affPayment.setCreateBy(userLogin.getUsername());
                    AffPayment affPaymentAdd = paymentDAO.addPayment(affPayment);

                    if (reqPayment.getDetailFileUpload() != null && reqPayment.getDetailFileUpload().getFileName() != null) {
                        AffFiles affFiles = new AffFiles();
                        affFiles.setFileTitle(reqPayment.getDetailFileUpload().getFileName());
                        affFiles.setFileType(Constants.TYPE_FILE.DUYET_YEU_CAU_THANH_TOAN);
                        affFiles.setGenDate(new Date());
                        affFiles.setStatus(Constants.STATUS_NUM.HIEU_LUC);
                        affFiles.setObjectId(resultAdd.getId());
                        affFiles.setPath(url_cdn + reqPayment.getDetailFileUpload().getLinkFile().replace("/app/webhome/web/cdn.ctv.osp.vn", ""));
                        affFiles.setNameInServer(reqPayment.getDetailFileUpload().getFileName());
                        List<FileUpload> files = (List<FileUpload>) filesDAO.getListFile(resultAdd.getId(), Constants.TYPE_FILE.DUYET_YEU_CAU_THANH_TOAN);
                        for (FileUpload file : files) {
                            filesDAO.removeFileById(file.getIdFile());
                        }
                        filesDAO.add(affFiles);
                    }
                } else {
                    logger.info("khong tao thanh toan so tien thanh toan nho hon 100.000");
                    return new ResponseEntity<String>("1", HttpStatus.OK);
                }
            } else {
                logger.info("Tao yeu cau thanh toan khong thanh cong cho user: " + reqPayment.getReqPayment().getPartnerId());
                return new ResponseEntity<String>("1", HttpStatus.OK);
            }
            return new ResponseEntity<String>("0", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("1", HttpStatus.OK);
        }
    }

    /**
     * Sửa thông tin yêu cầu thanh toán
     *
     * @param reqPayment
     * @param request
     * @return
     */
    @PostMapping(value = "/update")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.edit)
    public ResponseEntity<String> edit(@RequestBody ReqPaymentDTO reqPayment, HttpServletRequest request) {
        User userLogin = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        AffActionLogs logs = new AffActionLogs();
        try {
            if (!checkRequired(reqPayment.getReqPayment())) {
                logger.warn("Truong hop amount <= 0");
                System.out.println("Truong hop amount <= 0");
                return new ResponseEntity<String>("2", HttpStatus.OK);
            } else {
                // Truong hop amount >0
                if (reqPayment.getReqPayment().getId() == 0L) {
                    logger.warn("Truong hop request gui len (req payment) khong ton tai hoac co id = 0 ");
                    System.out.println("Truong hop request gui len (req payment) khong ton tai hoac co id = 0 ");
                    return new ResponseEntity<String>("3", HttpStatus.OK);
                }

                logger.info("Thuc hien tim kiem payment trong DB tu request payment gui len");
                System.out.println("Thuc hien tim kiem payment trong DB tu request payment gui len");

                //reqPaymentDb request payment get DB
                AffReqPayment reqPaymentDb = paymentDAO.getReqPaymentById(reqPayment.getReqPayment().getId());
                if (reqPaymentDb.getFee() == null) {
                    reqPaymentDb.setFee(0L);
                }
                if (reqPaymentDb == null) {
                    logger.info(reqPayment.getReqPayment().getReqCode() + "| Khong tim thay user tao yeu cau: " + reqPayment.getReqPayment().getId());
                    System.out.println(reqPayment.getReqPayment().getReqCode() + "| Khong tim thay user tao yeu cau: " + reqPayment.getReqPayment().getId());
                    return new ResponseEntity<String>("3", HttpStatus.OK);
                }
                if (reqPayment.getReqPayment().getAmount() != null && !"".equals(reqPayment.getReqPayment().getAmount())) {
                    reqPaymentDb.setAmount(reqPayment.getReqPayment().getAmount());
                }
                if (reqPayment.getReqPayment().getContent() != null && !"".equals(reqPayment.getReqPayment().getContent())) {
                    reqPaymentDb.setContent(reqPayment.getReqPayment().getContent());
                } else {
                    reqPaymentDb.setContent(null);
                }
                reqPaymentDb.setDescription(reqPayment.getReqPayment().getDescription());
                if (reqPayment.getReqPayment().getPaymentBy() != null && !"".equals(reqPayment.getReqPayment().getPaymentBy())) {
                    reqPaymentDb.setPaymentBy(reqPayment.getReqPayment().getPaymentBy());
                }
                if (reqPayment.getReqPayment().getPaymentDate() != null && !"".equals(reqPayment.getReqPayment().getPaymentDate())) {
                    reqPaymentDb.setPaymentDate(reqPayment.getReqPayment().getPaymentDate());
                }

                AffPartner user = partnerDao.findById(reqPaymentDb.getPartnerId());
                if (user == null) {
                    logger.info(reqPaymentDb.getReqCode() + "| Khong tim thay user tao yeu cau: " + reqPaymentDb.getPartnerId());
                    System.out.println(reqPaymentDb.getReqCode() + "| Khong tim thay user tao yeu cau: " + reqPaymentDb.getPartnerId());
                    return new ResponseEntity<String>("1", HttpStatus.OK);
                }

                logger.info("vi tien trươc khi tru thanh toan user: " + user.getUserName() + " so du = " + user.getAccBalance());
                System.out.println("vi tien trươc khi tru thanh toan user: " + user.getUserName() + " so du = " + user.getAccBalance());

                if (reqPayment.getReqPayment().getStatus() != null) {
                    reqPaymentDb.setStatus(reqPayment.getReqPayment().getStatus());
                }

                if (reqPaymentDb.getStatus().equals(Constants.TYPE_PAYMENT.DA_DUYET)) {
                    reqPaymentDb.setApproveBy(userLogin.getUsername());
                    reqPaymentDb.setApproveDate(new Date(System.currentTimeMillis()));
                    logger.info(reqPaymentDb.getReqCode() + "| Duyet thanh toan thanh cong boi " + userLogin.getUsername());
                    System.out.println(reqPaymentDb.getReqCode() + "| Duyet thanh toan thanh cong boi " + userLogin.getUsername());
                }
                reqPaymentDb.setLastUpdated(new Date());
                reqPaymentDb.setUpdateBy(userLogin.getUsername());
                logger.info("Thuc hien update req payment");
                boolean isUpdate = paymentDAO.editReqPayment(reqPaymentDb);
                AffPayment affPayment = null;
                if (isUpdate) {
                    affPayment = paymentDAO.getPaymentByReqPaymentId(reqPaymentDb.getId());
                    if (affPayment != null) {
                        affPayment.setPaymentBy(reqPaymentDb.getPaymentBy());
                        if (reqPayment.getReqPayment().getPaymentDate() != null && !reqPayment.getReqPayment().getPaymentDate().equals("")) {
                            affPayment.setPaymentDate(sdf.parse(reqPayment.getReqPayment().getPaymentDate()));
                        }
                        affPayment.setDescription(reqPaymentDb.getDescription());
                        paymentDAO.editPayment(affPayment);
                        AffReqPayment affReqPaymentAffter = paymentDAO.getReqPaymentById(reqPaymentDb.getId());
                        if (affReqPaymentAffter != null && affReqPaymentAffter.getStatus().equals(Constants.TYPE_PAYMENT.DA_DUYET)) {
                            boolean updateUser = partnerDao.updatePocketMoneyPartner(user.getUserName(), (reqPaymentDb.getAmount() + reqPaymentDb.getFee()) * -1);
                            logger.info(reqPaymentDb.getReqCode() + "| Tru tien thanh toan thanh cong user.getUsername(): " + user.getUserName() + "| so tien tru: " + ((reqPaymentDb.getAmount() + reqPaymentDb.getFee()) * -1));
                            System.out.println(reqPaymentDb.getReqCode() + "| Tru tien thanh toan thanh cong cho user: " + user.getUserName() + "| so tien bi tru: " + ((reqPaymentDb.getAmount() + reqPaymentDb.getFee()) * -1));
                            if (updateUser) {
                                user = partnerDao.findById(user.getId());
                                try {

                                    AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THANH_CONG, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), reqPaymentDb, user, reqPaymentDb.getFee(), user.getAccBalance());
                                    paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                } catch (Exception e) {
                                    logger.info(e.getMessage());
                                    e.printStackTrace();
                                }
                            } else {
                                user = partnerDao.findById(user.getId());
                                try {
                                    AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THAT_BAI, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), reqPaymentDb, user, reqPaymentDb.getFee(), user.getAccBalance());
                                    paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                } catch (Exception e) {
                                    logger.info(e.getMessage());
                                    e.printStackTrace();
                                }
                            }
                        }

                    } else {
                        if (checkRequired(reqPaymentDb) && (reqPaymentDb.getStatus().equals(Constants.TYPE_PAYMENT.DA_DUYET) || reqPaymentDb.getStatus().equals(Constants.TYPE_PAYMENT.DANG_XU_LY))) {
                            affPayment = new AffPayment();
                            affPayment.setReqPaymentId(reqPaymentDb.getId());
                            affPayment.setAmount(reqPayment.getReqPayment().getPayAmount());
                            affPayment.setDescription((reqPaymentDb.getDescription()));
                            affPayment.setStatus(Constants.STATUS_NUM.HIEU_LUC);
                            affPayment.setPaymentBy(reqPaymentDb.getPaymentBy());
                            if (reqPayment.getReqPayment().getPaymentDate() != null && !"".equals(reqPayment.getReqPayment().getPaymentDate())) {
                                affPayment.setPaymentDate(sdf.parse(reqPayment.getReqPayment().getPaymentDate()));
                            } else {
                                affPayment.setPaymentDate(new Date());
                            }
                            affPayment.setGenDate(new Date());
                            affPayment.setCreateBy(userLogin.getUsername());
                            paymentDAO.addPayment(affPayment);
                            AffReqPayment affReqPaymentAffter = paymentDAO.getReqPaymentById(reqPaymentDb.getId());
                            if (affReqPaymentAffter != null && affReqPaymentAffter.getStatus().equals(Constants.TYPE_PAYMENT.DA_DUYET)) {
                                boolean updateUser = partnerDao.updatePocketMoneyPartner(user.getUserName(), (reqPayment.getReqPayment().getPayAmount() + reqPaymentDb.getFee()) * -1);
                                logger.info(reqPaymentDb.getReqCode() + "| Tru tien thanh toan thanh cong user.getUsername(): " + user.getUserName() + "| so tien tru: " + ((reqPayment.getReqPayment().getPayAmount() + reqPaymentDb.getFee()) * -1));
                                if (updateUser) {
                                    user = partnerDao.findById(user.getId());
                                    try {
                                        AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THANH_CONG, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), reqPaymentDb, user, reqPaymentDb.getFee(), user.getAccBalance());
                                        paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                    } catch (Exception e) {
                                        logger.info(e.getMessage());
                                        e.printStackTrace();
                                    }
                                } else {
                                    user = partnerDao.findById(user.getId());
                                    try {
                                        AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THAT_BAI, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), reqPaymentDb, user, reqPaymentDb.getFee(), user.getAccBalance());
                                        paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                    } catch (Exception e) {
                                        logger.info(e.getMessage());
                                        e.printStackTrace();
                                    }
                                }
                            }
                        }
                    }
                    if (reqPayment.getFlagDelete().equals("true")) {
                        List<FileUpload> files = (List<FileUpload>) filesDAO.getListFile(reqPaymentDb.getId(), Constants.TYPE_FILE.DUYET_YEU_CAU_THANH_TOAN);
                        for (FileUpload file : files) {
                            filesDAO.removeFileById(file.getIdFile());
                        }
                    }
                    if (reqPayment.getDetailFileUpload() != null && reqPayment.getDetailFileUpload().getFileName() != null) {
                        AffFiles affFiles = new AffFiles();
                        affFiles.setFileTitle(reqPayment.getDetailFileUpload().getFileName());
                        affFiles.setFileType(Constants.TYPE_FILE.DUYET_YEU_CAU_THANH_TOAN);
                        affFiles.setGenDate(new Date());
                        affFiles.setStatus(Constants.STATUS_NUM.HIEU_LUC);
                        affFiles.setObjectId(reqPaymentDb.getId());
                        affFiles.setPath(reqPayment.getDetailFileUpload().getLinkFile());
                        affFiles.setPath(url_cdn + reqPayment.getDetailFileUpload().getLinkFile().replace("/app/webhome/web/cdn.ctv.osp.vn", ""));
                        affFiles.setNameInServer(reqPayment.getDetailFileUpload().getFileName());
                        List<FileUpload> files = (List<FileUpload>) filesDAO.getListFile(reqPaymentDb.getId(), Constants.TYPE_FILE.DUYET_YEU_CAU_THANH_TOAN);
                        for (FileUpload file : files) {
                            filesDAO.removeFileById(file.getIdFile());
                        }
                        filesDAO.add(affFiles);
                    }
                } else {
                    logger.info("update yeu cau thanh toan khong thanh cong requestId: " + reqPaymentDb.getId());
                    try {
                        AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THAT_BAI, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), reqPaymentDb, user, reqPaymentDb.getFee(), user.getAccBalance());
                        paymentDAO.addLogsAddBonus(affLogsAddBonus);
                    } catch (Exception e) {
                        logger.info(e.getMessage());
                        e.printStackTrace();
                    }
                }
                // parse old data to json
                actionLogDAO.createFullLogInsert(logs, reqPaymentDb, request);
                if (isUpdate) {
                    // lưu logs
                    //create logs
                    logs.setAction(Constants.ACTION_LOGS.SUA);
                    logs.setSource_logs(Constants.SOURCE_LOGS.YEU_CAU_THANH_TOAN);
                    logs.setInfo(userLogin.getUsername() + "Sửa thông tin yêu cầu thanh toán");
                    logs.setObject_id(reqPaymentDb.getId());
                    logs.setGen_date(new Date());
                    logs.setUser_type("ADMIN");
                    logs.setUser_name(userLogin.getUsername());
                    actionLogDAO.addActionLog(logs);
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

    /**
     * Hiển thị thông tin khi ấn xử lý yêu cầu thanh toán
     *
     * @param id
     * @return
     */
    @GetMapping("/loadInfoReqPayment")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.view)
    public ResponseEntity<AffReqPaymentView> loadInfoReqPayment(
            @RequestParam(value = "id", required = false) Long id,
            @RequestParam(value = "status", required = false) Long status) {
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();
        AffReqPaymentView affReqPaymentView = new AffReqPaymentView();
        try {
            affReqPaymentView = paymentDAO.getInfoReqPaymentById(id, status);

            AffPartner userReq = partnerDao.findById(affReqPaymentView.getPartnerId());

            if (userReq != null && userReq.getBankInfoStatusVerify() != null) {
                affReqPaymentView.setBankInfoStatusVerify(userReq.getBankInfoStatusVerify());
            } else {
                affReqPaymentView.setBankInfoStatusVerify(0L);
            }

            affReqPaymentView.setFullName(userReq.getPartnerName());
            affReqPaymentView.setMobilePartner(userReq.getMobile());
            affReqPaymentView.setAuthName(auth.getName());

            AffPayment affPayment = paymentDAO.getPaymentByReqPaymentId(id);

            if (affPayment != null) {
                affReqPaymentView.setPayment(affPayment);
            }
            if (affReqPaymentView == null) {
                return new ResponseEntity<AffReqPaymentView>(affReqPaymentView, HttpStatus.OK);
            }
            List<FileUpload> fileLst = (List<FileUpload>) filesDAO.getListFile(affReqPaymentView.getId(), Constants.TYPE_FILE.DUYET_YEU_CAU_THANH_TOAN);
            if (affReqPaymentView != null) {
                if (affReqPaymentView.getStatus() != Constants.TYPE_PAYMENT.DA_DUYET) {
                    affReqPaymentView.setPaymentBy(null);
                    affReqPaymentView.setPaymentDate(null);
                }
                if (fileLst != null && fileLst.size() > 0) {
                    affReqPaymentView.setFileLst(fileLst.get(0));
                }
                Long accBalanceInTimeReq = paymentDAO.getAccBalanceInTimeReq(affReqPaymentView.getPartnerId(), affReqPaymentView.getGenDate());
                if (accBalanceInTimeReq != -1) {
                    affReqPaymentView.setAccBalanceInTimeReq(accBalanceInTimeReq);
                }
                if (Objects.equals(affReqPaymentView.getStatus(), Constants.TYPE_PAYMENT.DA_DUYET) || Objects.equals(affReqPaymentView.getStatus(), Constants.TYPE_PAYMENT.TU_CHOI)) {
                    List<FileUpload> fileLst2 = (List<FileUpload>) filesDAO.getListFile(affReqPaymentView.getId(), Constants.TYPE_FILE.DUYET_YEU_CAU_THANH_TOAN);
                    if (fileLst2.size() > 0) {
                        affReqPaymentView.setFilePayment(fileLst2.get(0));
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Have error in loadInfoReqPayment:" + e.getMessage());
            e.printStackTrace();
        }
        return new ResponseEntity<AffReqPaymentView>(affReqPaymentView, HttpStatus.OK);
    }

    /**
     * Load danh sách lịch sử yêu cầu thanh toán
     *
     * @param idReqPayment
     * @return
     */
    @GetMapping("/getListReqPaymentLog")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.edit)
    public ResponseEntity<List<AffReqPayment>> getListReqPaymentLog(
            @RequestParam(value = "idReqPayment", required = false) Long idReqPayment) {
        List<AffReqPayment> lstAffReqPayment = new ArrayList<>();
        Gson gson = new Gson();
        try {
            //Get list log payment from action log
            List<AffActionLogs> lstActionLogReqPayment = actionLogDAO.getListActionLogByObjectId(idReqPayment);
            for (AffActionLogs log : lstActionLogReqPayment) {
                if (log != null) {
                    lstAffReqPayment.add(gson.fromJson(log.getFields_name(), AffReqPayment.class));
                }
            }
            for (AffReqPayment affReqPayment : lstAffReqPayment) {
                affReqPayment.setPartnerName(partnerDao.findById(affReqPayment.getPartnerId()).getPartnerName());
            }
        } catch (Exception e) {
            logger.error("Have error in viewDetail:" + e.getMessage());
            e.printStackTrace();
        }
        return new ResponseEntity<List<AffReqPayment>>(lstAffReqPayment, HttpStatus.OK);
    }


    private boolean checkRequired(AffReqPayment reqPayment) {
        boolean result = false;
        if (reqPayment.getAmount() == null && reqPayment.getStatus() != Constants.TYPE_PAYMENT.TU_CHOI) {
            result = false;
        } else if (reqPayment.getAmount() != null && reqPayment.getStatus() != Constants.TYPE_PAYMENT.TU_CHOI && reqPayment.getAmount() == 0) {
            result = false;
        } else {
            result = true;
        }
        return result;
    }

    @PostMapping("/uploadFile")
    @Secured(ConstantAuthor.PAYMENT.add)
    public ResponseEntity<ResultFileUpload> uploadFile(@RequestBody @Valid final MultipartFile multipartFile, HttpServletRequest request) {
        User userLogin = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        int rowSuccess = 0;
        int rowError = 0;
        boolean isUpdate = false;
        AffActionLogs logs;// parse old data to json
        ReqPaymentDTO reqPayment = new ReqPaymentDTO();
        if (multipartFile == null) {
            return ResponseEntity.ok(new ResultFileUpload(rowSuccess, rowError));
        }
        String folder = ConfigProperties.getConfigProperties("system_folder");
        try {
            if (!multipartFile.isEmpty()) {
                try {
                    final String newFileName = multipartFile.getName() + "_" + System.currentTimeMillis();
                    final String originalFilename = multipartFile.getOriginalFilename();
                    final String pattern = Objects.requireNonNull(originalFilename != null ? originalFilename.substring(originalFilename.lastIndexOf(PATTERN_FILE) + 1) : null);
                    final File file = new File(folder, newFileName + PATTERN_FILE + pattern);
                    multipartFile.transferTo(file);
                    InputStream inputStream = new FileInputStream(file.getAbsoluteFile());
                    ReadFileExcel readFileExcel = new ReadFileExcel();
                    List<AffReqPayment> affReqPayments = new ArrayList<>();
                    Long a = System.currentTimeMillis();
                    affReqPayments = readFileExcel.getListFromExcelFilePayment(inputStream, originalFilename);
                    logger.info((System.currentTimeMillis() - a) / 1000);

                    // thêm mới thanh toán nếu thành công và update trạng thái trạng thái yêu cầu thanh toán
                    for (AffReqPayment affReqPayment : affReqPayments) {
                        logs = new AffActionLogs();
                        if (affReqPayment.getReqCode() != null && !"".equals(affReqPayment.getReqCode())) {
                            AffReqPayment affReqPaymentDb = paymentDAO.getReqPaymentByReqCode(affReqPayment.getReqCode());
                            actionLogDAO.createFullLogInsert(logs, affReqPaymentDb, request);
                            if (affReqPaymentDb != null) {
                                if (Objects.equals(affReqPaymentDb.getStatus(), Constants.REQUEST_STATUS.CHO_DUYET)
                                        && Objects.equals(affReqPayment.getStatus(), Constants.REQUEST_STATUS.DA_DUYET)) {
                                    affReqPaymentDb.setApproveBy(userLogin.getUsername());
                                    if (affReqPayment.getApproveDate() != null) {
                                        affReqPaymentDb.setApproveDate(affReqPayment.getApproveDate());
                                    } else {
                                        affReqPaymentDb.setApproveDate(new Date());
                                    }
                                    affReqPaymentDb.setStatus(Constants.REQUEST_STATUS.DA_DUYET);
                                    affReqPaymentDb.setLastUpdated(new Date());
                                    affReqPaymentDb.setUpdateBy(userLogin.getUsername());
                                    if (affReqPayment.getDescription() != null && !"".equals(affReqPayment.getDescription())) {
                                        affReqPaymentDb.setDescription(affReqPayment.getDescription());
                                    }
                                    isUpdate = paymentDAO.editReqPayment(affReqPaymentDb);
                                    logger.info(affReqPaymentDb.getReqCode() + "| Duyet thanh toan thanh cong boi " + userLogin.getUsername());
                                    rowSuccess++;
                                } else if (Objects.equals(affReqPaymentDb.getStatus(), Constants.REQUEST_STATUS.CHO_DUYET)
                                        && Objects.equals(affReqPayment.getStatus(), Constants.REQUEST_STATUS.TU_CHOI)) {
                                    affReqPaymentDb.setPaymentDate(null);
                                    affReqPaymentDb.setApproveBy(userLogin.getUsername());
                                    affReqPaymentDb.setApproveDate(new Date());

                                    affReqPaymentDb.setStatus(Constants.REQUEST_STATUS.TU_CHOI);
                                    affReqPaymentDb.setLastUpdated(new Date());
                                    affReqPaymentDb.setUpdateBy(userLogin.getUsername());
                                    if (affReqPayment.getDescription() != null && !"".equals(affReqPayment.getDescription())) {
                                        affReqPaymentDb.setDescription(affReqPayment.getDescription());
                                    }

                                    isUpdate = paymentDAO.editReqPayment(affReqPaymentDb);
                                    logger.info(affReqPaymentDb.getReqCode() + "| Tu Choi duyet thanh toan boi " + userLogin.getUsername());
                                    rowSuccess++;
                                } else if (Objects.equals(affReqPaymentDb.getStatus(), Constants.REQUEST_STATUS.CHO_DUYET)
                                        && Objects.equals(affReqPayment.getStatus(), Constants.REQUEST_STATUS.DANG_XU_LY)) {
                                    affReqPaymentDb.setApproveBy(userLogin.getUsername());
                                    affReqPaymentDb.setApproveDate(new Date());
                                    affReqPaymentDb.setStatus(Constants.REQUEST_STATUS.DANG_XU_LY);
                                    affReqPaymentDb.setLastUpdated(new Date());
                                    affReqPaymentDb.setUpdateBy(userLogin.getUsername());
                                    if (affReqPayment.getDescription() != null && !"".equals(affReqPayment.getDescription())) {
                                        affReqPaymentDb.setDescription(affReqPayment.getDescription());
                                    }
                                    isUpdate = paymentDAO.editReqPayment(affReqPaymentDb);
                                    logger.info(affReqPaymentDb.getReqCode() + "| Dang xu ly thanh toan boi " + userLogin.getUsername());
                                    rowSuccess++;
                                } else if (Objects.equals(affReqPaymentDb.getStatus(), Constants.REQUEST_STATUS.DANG_XU_LY)
                                        && Objects.equals(affReqPayment.getStatus(), Constants.REQUEST_STATUS.DA_DUYET)) {
                                    affReqPaymentDb.setApproveBy(userLogin.getUsername());
                                    affReqPaymentDb.setApproveDate(new Date());
                                    affReqPaymentDb.setStatus(Constants.REQUEST_STATUS.DA_DUYET);
                                    affReqPaymentDb.setLastUpdated(new Date());
                                    affReqPaymentDb.setUpdateBy(userLogin.getUsername());
                                    if (affReqPayment.getDescription() != null && !"".equals(affReqPayment.getDescription())) {
                                        affReqPaymentDb.setDescription(affReqPayment.getDescription());
                                    }
                                    isUpdate = paymentDAO.editReqPayment(affReqPaymentDb);
                                    logger.info(affReqPaymentDb.getReqCode() + "| Chuyen Dang xu ly sang thanh cong thanh toan boi " + userLogin.getUsername());
                                    rowSuccess++;
                                }

                                AffPayment affPayment = null;

                                if (isUpdate) {
                                    // thêm logs update yêu cầu thanh toán
                                    //create logs
                                    logs.setAction(Constants.ACTION_LOGS.SUA);
                                    logs.setSource_logs(Constants.SOURCE_LOGS.DOI_SOAT);
                                    logs.setInfo("Update thông tin yêu cầu thanh toán id: " + affReqPaymentDb.getId());
                                    logs.setObject_id(affReqPaymentDb.getId());
                                    logs.setGen_date(new Date());
                                    actionLogDAO.addActionLog(logs);

                                    affPayment = paymentDAO.getPaymentByReqPaymentId(affReqPaymentDb.getId());
                                    if (affPayment != null) {
                                        affPayment.setPaymentBy(userLogin.getUsername());
                                        if (affReqPayment.getApproveDate() != null) {
                                            affPayment.setPaymentDate(affReqPayment.getApproveDate());
                                        } else {
                                            affPayment.setPaymentDate(new Date());
                                        }

                                        affPayment.setDescription(affPayment.getDescription());
                                        paymentDAO.editPayment(affPayment);
                                        AffPartner user = partnerDao.findById(affReqPaymentDb.getPartnerId());
                                        if (user == null) {
                                            logger.info(affReqPaymentDb.getReqCode() + "| Khong tim thay user tao yeu cau: " + affReqPaymentDb.getPartnerId());
                                        }
                                        if (Objects.equals(affReqPayment.getStatus(), Constants.REQUEST_STATUS.DA_DUYET)) {
                                            logger.info(affReqPaymentDb.getReqCode() + "| Tru tien vao vi khi thanh toan trang thai thanh cong| => " + affPayment.getId());
                                            Long soTienTruocKhiTru = user.getAccBalance();
                                            // sau khi trừ tiền update xác nhận thanh toán về 0
                                            boolean updateUserMoney = partnerDao.updatePocketMoneyPartner(user.getUserName(), (affPayment.getAmount() + affReqPaymentDb.getFee()) * -1);
                                            reqPayment.setReqPayment(affReqPayment);
                                            if (updateUserMoney) {
                                                user = partnerDao.findById(user.getId());
                                                try {
                                                    logger.info(affReqPaymentDb.getReqCode() + "| Tru tien thanh toan thanh cong user.getUsername(): " + user.getUserName() + "| so tien tru: " + ((affPayment.getAmount() + affReqPaymentDb.getFee()) * -1));
                                                    AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THANH_CONG, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), affReqPaymentDb, user, affReqPaymentDb.getFee(), user.getAccBalance());
                                                    paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                                } catch (Exception e) {
                                                    e.printStackTrace();
                                                }
                                            } else {
                                                try {
                                                    logger.info(affReqPaymentDb.getReqCode() + "| Tru tien thanh toan khong thanh cong user.getUsername(): " + user.getUserName() + "| so tien tru: " + ((affPayment.getAmount() + affReqPaymentDb.getFee()) * -1));
                                                    AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THAT_BAI, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), affReqPaymentDb, user, affReqPaymentDb.getFee(), user.getAccBalance());
                                                    paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                                } catch (Exception e) {
                                                    e.printStackTrace();
                                                }
                                            }
                                        }

                                    } else {
                                        if (Objects.equals(affReqPaymentDb.getStatus(), Constants.REQUEST_STATUS.DANG_XU_LY) || Objects.equals(affReqPaymentDb.getStatus(), Constants.REQUEST_STATUS.DA_DUYET)) {
                                            affPayment = new AffPayment();
                                            affPayment.setReqPaymentId(affReqPaymentDb.getId());
                                            if (affReqPayment.getAmount() != null && affReqPayment.getAmount() > 0) {
                                                affPayment.setAmount(affReqPayment.getAmount());
                                            } else {
                                                affPayment.setAmount(affReqPaymentDb.getAmount());
                                            }
                                            affPayment.setDescription(affReqPayment.getDescription());
                                            affPayment.setStatus(Constants.STATUS_NUM.HIEU_LUC);
                                            affPayment.setPaymentBy(userLogin.getUsername());
                                            if (affReqPayment.getApproveDate() != null) {
                                                affPayment.setPaymentDate(affReqPayment.getApproveDate());
                                            } else {
                                                affPayment.setPaymentDate(new Date());
                                            }
                                            affPayment.setGenDate(new Date());
                                            affPayment.setCreateBy(userLogin.getUsername());
                                            paymentDAO.addPayment(affPayment);
                                            // trừ tiền vào ví sau khi thanh toán
                                            logger.info(affReqPaymentDb.getReqCode() + "| Them moi ban ghi thanh toan thanh cong affPayment.getId() => " + affPayment.getId());
                                            AffPartner user = partnerDao.findById(affReqPaymentDb.getPartnerId());
                                            if (user == null) {
                                                logger.info(affReqPaymentDb.getReqCode() + "| Khong tim thay user tao yeu cau: " + affReqPaymentDb.getPartnerId());
                                            }


                                            AffReqPayment affReqPaymentAfter = paymentDAO.getReqPaymentById(affReqPaymentDb.getId());
                                            if (affReqPaymentAfter.getStatus().equals(Constants.REQUEST_STATUS.DA_DUYET)) {
                                                logger.info(affReqPaymentDb.getReqCode() + "| Tru tien vao vi khi thanh toan trang thai thanh cong| => " + affPayment.getId());
                                                Long soTienTruocKhiTru = user.getAccBalance();
                                                // sau khi trừ tiền update xác nhận thanh toán về 0
                                                boolean updateUserMoney = partnerDao.updatePocketMoneyPartner(user.getUserName(), (affReqPayment.getPayAmount() + affReqPaymentDb.getFee()) * -1);
                                                reqPayment.setReqPayment(affReqPayment);
                                                if (updateUserMoney) {
                                                    user = partnerDao.findById(user.getId());
                                                    try {
                                                        logger.info(affReqPaymentDb.getReqCode() + "| Tru tien thanh toan thanh cong user.getUsername(): " + user.getUserName() + "| so tien tru: " + ((affPayment.getAmount() + affReqPaymentDb.getFee()) * -1));
                                                        AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THANH_CONG, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), affReqPaymentDb, user, affReqPaymentDb.getFee(), user.getAccBalance());
                                                        paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                                    } catch (Exception e) {
                                                        e.printStackTrace();
                                                    }
                                                } else {
                                                    try {
                                                        logger.info(affReqPaymentDb.getReqCode() + "| Tru tien thanh toan khong thanh cong user.getUsername(): " + user.getUserName() + "| so tien tru: " + ((affPayment.getAmount() + affReqPaymentDb.getFee()) * -1));
                                                        AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPayment, Constants.STATUS_TRANS.THAT_BAI, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), affReqPaymentDb, user, affReqPaymentDb.getFee(), user.getAccBalance());
                                                        paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                                    } catch (Exception e) {
                                                        e.printStackTrace();
                                                    }
                                                }
                                                logs.setAction(Constants.ACTION_LOGS.SUA);
                                                logs.setSource_logs(Constants.SOURCE_LOGS.YEU_CAU_THANH_TOAN);
                                                logs.setInfo("Trừ tiền vào ví user id: " + user.getId() + "Số tiền trước khi trừ = " + soTienTruocKhiTru + ", số tiền trừ: " + affReqPayment.getAmount());
                                                logs.setObject_id(affReqPaymentDb.getId());
                                                logs.setGen_date(new Date());
                                                logs.setUser_type("ADMIN");
                                                logs.setUser_name(userLogin.getUsername());
                                                actionLogDAO.addActionLog(logs);
                                            }
                                        }
                                    }
                                } else {
                                    logger.info("Khong co ban ghi nao phu hop update affReqPaymentDb.getId() = " + affReqPaymentDb.getId());
                                    rowError++;
                                }
                            }
                        }
                    }
                    if (rowSuccess > 0) {
                        FileUtil.deleteFile(file.getAbsolutePath());
                        return ResponseEntity.ok(new ResultFileUpload(affReqPayments.size(), rowError));
                    } else {
                        FileUtil.deleteFile(file.getAbsolutePath());
                        return ResponseEntity.ok(new ResultFileUpload(rowSuccess, affReqPayments.size()));
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    return ResponseEntity.ok(new ResultFileUpload(rowSuccess, rowError));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.ok(new ResultFileUpload(rowSuccess, rowError));
        }
        return ResponseEntity.ok(new ResultFileUpload(rowSuccess, rowError));
    }

    @GetMapping("/xac-thuc-thong-tin-ngan-hang")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.edit)
    public ResponseEntity<String> bankInfoStatusVerify(@RequestParam(value = "bankInfoStatusVerify", required = false, defaultValue = "") Long bankInfoStatusVerify,
                                                       @RequestParam(value = "partnerId", required = false, defaultValue = "") Long partnerId) {
        try {
            AffPartner userReq = partnerDao.findById(partnerId);
            if (bankInfoStatusVerify != null && bankInfoStatusVerify == 1L && userReq != null) {
                userReq.setBankInfoStatusVerify(bankInfoStatusVerify);
                partnerDao.editPartner(userReq);
                return new ResponseEntity<String>("1", HttpStatus.OK);
            } else if (bankInfoStatusVerify != null && bankInfoStatusVerify == 0L && userReq != null) {
                userReq.setBankInfoStatusVerify(bankInfoStatusVerify);
                partnerDao.editPartner(userReq);
                return new ResponseEntity<String>("0", HttpStatus.OK);
            }
        } catch (Exception e) {
            logger.error("Have error in autoRepay:" + e.getMessage());
            e.printStackTrace();
            return new ResponseEntity<String>("2", HttpStatus.OK);
        }
        return new ResponseEntity<String>("2", HttpStatus.OK);
    }


    @GetMapping("/confirmPayment")
    @Secured(ConstantAuthor.REQ_PAYMENT_ADM.edit)
    public ResponseEntity<String> confirmPayment(@RequestParam(value = "id", required = false, defaultValue = "") Long id) {
        AffReqPayment affReqPayment = new AffReqPayment();
        User userLogin = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        try {
            if (id != null) {
                affReqPayment = paymentDAO.getReqPaymentById(id);
                if (affReqPayment.getStatus().equals(Constants.REQUEST_STATUS.DANG_XU_LY)) {
                    affReqPayment.setStatus(Constants.REQUEST_STATUS.DA_DUYET);
                    affReqPayment.setLastUpdated(new Date());
                    affReqPayment.setUpdateBy(userLogin.getUsername());
                    affReqPayment.setApproveBy(userLogin.getUsername());
                    affReqPayment.setApproveDate(new Date());
                    boolean blEdit = paymentDAO.editReqPayment(affReqPayment);
                    if (blEdit) {
                        logger.info(affReqPayment.getReqCode() + "| Xac nhan thanh toan boi " + userLogin.getUsername() + " | thanh cong");
                        System.out.println(affReqPayment.getReqCode() + "| Xac nhan thanh toan boi " + userLogin.getUsername() + " | thanh cong");
                        AffPayment affPayment = paymentDAO.getPaymentByReqPaymentId(affReqPayment.getId());
                        if (affPayment != null) {
                            logger.info(affReqPayment.getReqCode() + "|Xac nhan tru tien khi xác nhan thanh toan thanh cong boi user | " + userLogin.getUsername());
                            System.out.println(affReqPayment.getReqCode() + "|Xac nhan tru tien khi xác nhan thanh toan thanh cong boi user | " + userLogin.getUsername());
                            AffPartner userReq = partnerDao.findById(affReqPayment.getPartnerId());
                            if (userReq != null) {
                                logger.info(affReqPayment.getReqCode() + "|So tien truoc khi tru | " + userReq.getAccBalance());
                                System.out.println(affReqPayment.getReqCode() + "|So tien truoc khi tru | " + userReq.getAccBalance());
                                boolean rsUpdate = partnerDao.updatePocketMoneyPartner(userReq.getUserName(), (affPayment.getAmount() + affReqPayment.getFee()) * -1);
                                ReqPaymentDTO reqPaymentDTO = new ReqPaymentDTO();
                                reqPaymentDTO.setPayment(affPayment);
                                reqPaymentDTO.setReqPayment(affReqPayment);
                                if (rsUpdate) {
                                    logger.info("vi tien sau khi tru thanh toan user: " + userReq.getUserName() + " so du = " + userReq.getAccBalance());
                                    System.out.println("vi tien sau khi tru thanh toan user: " + userReq.getUserName() + " so du = " + userReq.getAccBalance());
                                    try {
                                        AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPaymentDTO, Constants.STATUS_TRANS.THANH_CONG, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), affReqPayment, userReq, affReqPayment.getFee(), userReq.getAccBalance());
                                        paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                    } catch (Exception e) {
                                        System.out.println(e.getMessage());
                                        e.printStackTrace();
                                    }
                                } else {
                                    try {
                                        AffLogsAddBonus affLogsAddBonus = setLogsAddBonus(reqPaymentDTO, Constants.STATUS_TRANS.THAT_BAI, Constants.LEVEL_BONUS.TIEN_THANH_TOAN, Constants.SRC_CHANGE.THANH_TOAN, Long.valueOf(Constants.TRANS_TYPE.THANH_TOAN), affReqPayment, userReq, affReqPayment.getFee(), userReq.getAccBalance());
                                        paymentDAO.addLogsAddBonus(affLogsAddBonus);
                                    } catch (Exception e) {
                                        System.out.println(e.getMessage());
                                        e.printStackTrace();
                                    }
                                }
                            }
                        }
                    }
                } else {
                    return new ResponseEntity<String>("0", HttpStatus.OK);
                }
                return new ResponseEntity<String>("1", HttpStatus.OK);
            } else {
                return new ResponseEntity<String>("2", HttpStatus.OK);
            }

        } catch (Exception e) {
            logger.info(affReqPayment.getReqCode() + "| Xac nhan thanh toan boi " + userLogin.getUsername() + " | that bai");
            e.printStackTrace();
        }
        return new ResponseEntity<String>("3", HttpStatus.OK);
    }

    private AffLogsAddBonus setLogsAddBonus(ReqPaymentDTO reqPayment, Long status, Long levelBonus, String description, Long transType, AffReqPayment reqPaymentDb, AffPartner user, Long fee, Long currentAmount) {

        AffLogsAddBonus affLogsAddBonus = new AffLogsAddBonus();
        affLogsAddBonus.setGenDate(new Date());
        affLogsAddBonus.setLevel(levelBonus);
        affLogsAddBonus.setUserName(user.getUserName());
        affLogsAddBonus.setDescription(description);
        affLogsAddBonus.setStatus(status);
        affLogsAddBonus.setTransId(reqPaymentDb.getReqCode());
        affLogsAddBonus.setTransType(transType);
        affLogsAddBonus.setCurrentAmount(currentAmount);
        if (reqPayment.getReqPayment().getPayAmount() != null && reqPayment.getReqPayment().getPayAmount() > 0) {
            affLogsAddBonus.setAmount((reqPayment.getReqPayment().getPayAmount() + fee) * -1);
        } else {
            affLogsAddBonus.setAmount((reqPaymentDb.getAmount() + fee) * -1);
        }

        return affLogsAddBonus;
    }

    private boolean checkRequiredInfo(AffPartner user) {
        boolean result = false;
        if (user.getIdNumber() == null || "".equals(user.getIdNumber())) {
            result = false;
        } else if (user.getLinkFrontIdNumber() == null || "".equals(user.getLinkFrontIdNumber())) {
            result = false;
        } else if (user.getLinkBackIdNumber() == null || "".equals(user.getLinkBackIdNumber())) {
            result = false;
        } else if (user.getAccNumber() == null || "".equals(user.getAccNumber())) {
            result = false;
        } else if (user.getAccName() == null || "".equals(user.getAccName())) {
            result = false;
        } else if (user.getAccBank() == null || "".equals(user.getAccBank())) {
            result = false;
        } else {
            result = true;
        }
        return result;
    }

    private boolean checkEqNameInfo(AffPartner user) {
        boolean result = false;
        if (user.getAccName() != null && !"".equals(user.getAccName()) && user.getPartnerName() != null && !"".equals(user.getPartnerName()) && !user.getPartnerName().trim().toUpperCase().equals(user.getAccName().trim().toUpperCase())) {
            result = false;
        } else {
            result = true;
        }
        return result;
    }

    @RequestMapping(value = "/saveFile", method = RequestMethod.POST)
    public ResponseEntity<?> saveFile(@RequestBody AffFiles files) {
        return new ResponseEntity<>(filesDAO.add(files), HttpStatus.OK);
    }
}