package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.model.AffLogsAddBonus;
import com.ada.model.AffPartner;
import com.ada.model.AffPayment;
import com.ada.model.AffReqPayment;
import com.ada.model.view.AffReqPaymentView;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface PaymentDAO {
    AffReqPayment getReqPaymentById(Long id);

    AffReqPaymentView getInfoReqPaymentById(Long id, Long statusPayment);

    AffPayment getPaymentById(Long id);

    AffReqPayment addReqPayment(AffReqPayment bo);

    AffPayment addPayment(AffPayment bo);

    Optional<PagingResult> pageReqPayment(PagingResult pageRs, String mobile, Long status, Date fromDate, Date toDate, Date fromPaymentDate, Date toPaymentDate, String reqCode, String typeExport);

    Optional<PagingResult> pagePayment(PagingResult page, Long partnerId, Long status, Date fromDate, Date toDate);

    boolean editReqPayment(AffReqPayment bo);

    boolean editPayment(AffPayment bo);

    //    Lấy tổng tiền đã thanh toán
    Long getTotalAmountByIdPartner(Long idPartner);

    //    Lấy số dư tài khoản lúc tạo yêu cầu thanh toán
    Long getAccBalanceInTimeReq(Long idPartner, Date genDate);

    AffPayment getPaymentByReqPaymentId(Long reqPaymentId);

    Optional<PagingResult> pageReqPaymentCtv(PagingResult pageRs, String partnerName, String username, Long status, Date fromDate, Date toDate);

    Long countRequest(Long idPartner);

    Long checkRequestWait(Long idPartner);

    Long checkRequestDoing(Long idPartner);

    AffReqPayment getReqPaymentByReqCode(String reqCode);

    AffReqPayment getReqPaymentByStatus(Long idPartner, Long status);

    AffLogsAddBonus addLogsAddBonus(AffLogsAddBonus affLogsAddBonus);

    boolean deleteLogAddBonus(String username, Long transId, Long transType);

    List<AffPartner> getPartner();

    String genReqCode();
}
