package com.ada.web.controller;

import com.ada.common.ConstantAuthor;
import com.ada.common.PagingResult;
import com.ada.model.TransactionPackage;
import com.ada.model.TransactionSim;
import com.ada.web.service.TransactionPackageService;
import com.ada.web.service.TransactionService;
import com.ada.web.service.TransactionSimService;
import com.ada.web.service.chonsoApi.*;
import net.sf.jett.transform.ExcelTransformer;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/transaction")
public class TransactionController {
    SimpleDateFormat ddMMyyyy = new SimpleDateFormat("dd-MM-yyyy");
    private final String templateExcelDs = "/fileTemplate/ds_don_hang.xlsx";

    @Autowired
    private TransactionService transactionService;
    @Autowired
    private TransactionSimService transactionSimService;
    @Autowired
    private TransactionPackageService transactionPackageService;
    @Autowired
    private PackageApiService packageApiService;
    @Autowired
    private MsisdnApiService msisdnApiService;

    private SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");

    @RequestMapping("/index.html")
    public String list() {
        return "transaction.list";
    }

    @RequestMapping("/search")
    @Secured(ConstantAuthor.TRANS.view)
    public ResponseEntity<PagingResult> search(
            @RequestParam(value = "p", required = false, defaultValue = "1") int pageNumber,
            @RequestParam(value = "numberPerPage", required = false, defaultValue = "15") int numberPerPage,
            @RequestParam(value = "itemType", required = false, defaultValue = "-1") String itemType,
            @RequestParam(value = "itemName", required = false, defaultValue = "") String itemName,
            @RequestParam(value = "msisdnContact", required = false, defaultValue = "") String msisdnContact,
            @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
            @RequestParam(value = "status", required = false, defaultValue = "-1") String status,
            @RequestParam(value = "type", required = false, defaultValue = "-1") String type,
            @RequestParam(value = "transCode", required = false, defaultValue = "") String transCode,
            @RequestParam(value = "fromGenDate", required = false, defaultValue = "") String fromGenDate,
            @RequestParam(value = "toGenDate", required = false, defaultValue = "") String toGenDate,
            @RequestParam(value = "msisdnType", required = false, defaultValue = "-1") String msisdnType,
            @RequestParam(value = "group_id", required = false, defaultValue = "-1") String group_id,
            @RequestParam(value = "doiTuongGiuSo", required = false, defaultValue = "-1") String doiTuongGiuSo,
            @RequestParam(value = "loaiGoiCuoc", required = false, defaultValue = "-1") String loaiGoiCuoc,
            @RequestParam(value = "giaGoi", required = false, defaultValue = "-1") String giaGoi,
            @RequestParam(value = "chuKy", required = false, defaultValue = "-1") String chuKy) {
        PagingResult page = new PagingResult();
        page.setPageNumber(pageNumber);
        page.setNumberPerPage(numberPerPage);
        try {
            Timestamp fromDateT = null;
            Timestamp toDateT = null;
            if (fromGenDate != null && !"".equals(fromGenDate)) {
                String strFdate = fromGenDate + " 00:00:00";
                fromDateT = new Timestamp(sdf.parse(strFdate).getTime());
            }
            if (toGenDate != null && !"".equals(toGenDate)) {
                String strTdate = toGenDate + " 23:59:59";
                toDateT = new Timestamp(sdf.parse(strTdate).getTime());
            }
            page = transactionService.page(page, itemType, itemName, msisdnContact, mobile, status, type, transCode, fromDateT, toDateT,
                    msisdnType, group_id, doiTuongGiuSo,
                    loaiGoiCuoc, giaGoi, chuKy);
        } catch (Exception e){
            e.printStackTrace();
        }

        return new ResponseEntity<>(page, HttpStatus.OK);
    }

    @RequestMapping("/detail")
    public ResponseEntity<?> detailTransaction(@RequestParam(value = "itemType") String itemType,
                                               @RequestParam(value = "transCode") String transCode) {
        if (itemType.equals("SIMSO")) {
            TransactionSim transactionSim = transactionSimService.findByTransCode(transCode);
            return new ResponseEntity<>(transactionSim, HttpStatus.OK);
        } else {
            TransactionPackage transactionPackage = transactionPackageService.findByTransCode(transCode);
            return new ResponseEntity<>(transactionPackage, HttpStatus.OK);
        }
    }

    @RequestMapping("/detailApi")
    public ResponseEntity<?> detailApi(Model model,
                                       @RequestParam(value = "itemType") String itemType,
                                       @RequestParam(value = "transCode") String transCode) {
        if (itemType.equals("SIMSO")) {
            TransactionSim transactionSim = transactionSimService.findByTransCode(transCode);

            MsisdnDetailRequest msisdnDetailRequest = new MsisdnDetailRequest();
            msisdnDetailRequest.setMsisdn(transactionSim.getMsisdn());

            MsisdnDetailResponse msisdnDetailResponse = msisdnApiService.detail(msisdnDetailRequest, null);
            return new ResponseEntity<>(msisdnDetailResponse.getData().getItems().get(0), HttpStatus.OK);
        } else {
            TransactionPackage transactionPackage = transactionPackageService.findByTransCode(transCode);
            AffPackageDetailRequest packageTemp = new AffPackageDetailRequest();
            packageTemp.setPckCode(transactionPackage.getPack_code());
            AffPackageDetailResponse packageApiDetail = packageApiService.getPackageDetail(packageTemp, null);

            return new ResponseEntity<>(packageApiDetail.getData().getItems().get(0), HttpStatus.OK);
        }
    }

    @RequestMapping(value = "/export", method = RequestMethod.GET)
    @Secured(ConstantAuthor.TRANS.view)
    public void exportExcel(
            @RequestParam(value = "itemType", required = false, defaultValue = "-1") String itemType,
            @RequestParam(value = "itemName", required = false, defaultValue = "") String itemName,
            @RequestParam(value = "msisdnContact", required = false, defaultValue = "") String msisdnContact,
            @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile,
            @RequestParam(value = "status", required = false, defaultValue = "-1") String status,
            @RequestParam(value = "type", required = false, defaultValue = "-1") String type,
            @RequestParam(value = "transCode", required = false, defaultValue = "") String transCode,
            @RequestParam(value = "fromGenDate", required = false, defaultValue = "") String fromGenDate,
            @RequestParam(value = "toGenDate", required = false, defaultValue = "") String toGenDate,

            @RequestParam(value = "msisdnType", required = false, defaultValue = "-1") String msisdnType,
            @RequestParam(value = "group_id", required = false, defaultValue = "-1") String group_id,
            @RequestParam(value = "doiTuongGiuSo", required = false, defaultValue = "-1") String doiTuongGiuSo,

            @RequestParam(value = "loaiGoiCuoc", required = false, defaultValue = "-1") String loaiGoiCuoc,
            @RequestParam(value = "giaGoi", required = false, defaultValue = "-1") String giaGoi,
            @RequestParam(value = "chuKy", required = false, defaultValue = "-1") String chuKy,
            HttpServletRequest request, HttpServletResponse response) {

        PagingResult page = new PagingResult();

        page.setPageNumber(0);

        try {
            Timestamp fromDateT = null;
            Timestamp toDateT = null;
            if (fromGenDate != null && !"".equals(fromGenDate)) {
                String strFdate = fromGenDate + " 00:00:00";
                fromDateT = new Timestamp(sdf.parse(strFdate).getTime());
            }
            if (toGenDate != null && !"".equals(toGenDate)) {
                String strTdate = toGenDate + " 23:59:59";
                toDateT = new Timestamp(sdf.parse(strTdate).getTime());
            }
            page = transactionService.page(page, itemType, itemName, msisdnContact, mobile, status, type, transCode, fromDateT, toDateT,
                    msisdnType, group_id, doiTuongGiuSo,
                    loaiGoiCuoc, giaGoi, chuKy);

            Map<String, Object> beans = new HashMap<String, Object>();
            beans.put("page", page);
            beans.put("sysDate", ddMMyyyy.format(new Date()));
            Resource resource = new ClassPathResource(templateExcelDs);
            InputStream fileIn = resource.getInputStream();
            ExcelTransformer transformer = new ExcelTransformer();
            Workbook workbook = transformer.transform(fileIn, beans);
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=" + ddMMyyyy.format(new Date()) + "_DSDonHang.xlsx");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/getGroupMsisdn")
    public ResponseEntity<?> getGroupMsisdn() {
        GroupMsisdnRequest groupMsisdnRequest = new GroupMsisdnRequest();
        groupMsisdnRequest.setSrcReq("CTV Mobifone");
        GroupMsisdnResponse groupMsisdnResponse = msisdnApiService.groupMsisdn(groupMsisdnRequest, null);

        return new ResponseEntity<>(groupMsisdnResponse.getData().getListGroupMsisdn(), HttpStatus.OK);
    }

}
