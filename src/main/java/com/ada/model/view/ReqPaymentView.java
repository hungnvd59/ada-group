package com.ada.model.view;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Transient;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Entity
public class ReqPaymentView {
    @Id
    @Column(name = "ID")
    private Long id;
    @Column(name = "PARTNER_ID")
    private Long partnerId;
    @Column(name = "STATUS")
    private Long status;
    @Column(name = "REQ_PARTNER_NAME")
    private String reqPartnerName;
    @Column(name = "USERNAME")
    private String username;
    @Column(name = "GEN_DATE")
    private Date genDate;
    @Column(name = "PAYMENT_DATE")
    private Date paymentDate;
    @Column(name = "AMOUNT")
    private Long amount;
    @Column(name = "source_request")
    private Long sourceRequest;
    @Column(name = "req_amount")
    private Long reqAmount;
    @Column(name = "last_updated")
    private Date lastUpdated;
    @Column(name = "REQ_CODE")
    private String reqCode;
    @Column(name = "ACC_NUMBER")
    private String accNumber;
    @Column(name = "ACC_BRANCH")
    private String accBranch;
    @Column(name = "ACC_NAME")
    private String accName;
    @Column(name = "ACC_BANK")
    private String accBank;
    @Column(name = "FEE")
    private String fee;
    @Column(name = "APPROVE_DATE")
    private Date approveDate;

    @Column(name = "DESCRIPTION")
    private String description;


    @Transient
    private String genDateStr;
    @Transient
    private String paymentDateStr;
    @Transient
    private String lastUpdatedStr;

    @Transient
    private List<String> listStatus;

    public ReqPaymentView(Long id, Long partnerId, Long status, String reqPartnerName, String username, Date genDate, Date paymentDate, Long amount, Long sourceRequest, Long reqAmount, Date lastUpdated, String reqCode, String genDateStr, String paymentDateStr, String lastUpdatedStr) {
        this.id = id;
        this.partnerId = partnerId;
        this.status = status;
        this.reqPartnerName = reqPartnerName;
        this.username = username;
        this.genDate = genDate;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.sourceRequest = sourceRequest;
        this.reqAmount = reqAmount;
        this.lastUpdated = lastUpdated;
        this.reqCode = reqCode;
        this.genDateStr = genDateStr;
        this.paymentDateStr = paymentDateStr;
        this.lastUpdatedStr = lastUpdatedStr;
    }

    public String getLastUpdatedStr() {
        SimpleDateFormat ddMMyyyy = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        if (getLastUpdated() != null) {
            lastUpdatedStr = ddMMyyyy.format(getLastUpdated());
        }
        return lastUpdatedStr;
    }

    public void setLastUpdatedStr(String lastUpdatedStr) {
        this.lastUpdatedStr = lastUpdatedStr;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public Long getSourceRequest() {
        return sourceRequest;
    }

    public void setSourceRequest(Long sourceRequest) {
        this.sourceRequest = sourceRequest;
    }

    public ReqPaymentView() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(Long partnerId) {
        this.partnerId = partnerId;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public String getReqPartnerName() {
        return reqPartnerName;
    }

    public void setReqPartnerName(String reqPartnerName) {
        this.reqPartnerName = reqPartnerName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public Date getGenDate() {
        return genDate;
    }

    public void setGenDate(Date genDate) {
        this.genDate = genDate;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getGenDateStr() {
        SimpleDateFormat ddMMyyyy = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        if (getGenDate() != null) {
            genDateStr = ddMMyyyy.format(getGenDate());
        }
        return genDateStr;
    }

    public void setGenDateStr(String genDateStr) {
        this.genDateStr = genDateStr;
    }

    public String getPaymentDateStr() {
        SimpleDateFormat ddMMyyyy = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        if (paymentDate != null) {
            paymentDateStr = ddMMyyyy.format(paymentDate);
        }
        return paymentDateStr;
    }

    public void setPaymentDateStr(String paymentDateStr) {
        this.paymentDateStr = paymentDateStr;
    }

    public Long getReqAmount() {
        return reqAmount;
    }

    public void setReqAmount(Long reqAmount) {
        this.reqAmount = reqAmount;
    }

    public String getReqCode() {
        return reqCode;
    }

    public void setReqCode(String reqCode) {
        this.reqCode = reqCode;
    }

    public String getAccNumber() {
        return accNumber;
    }

    public void setAccNumber(String accNumber) {
        this.accNumber = accNumber;
    }

    public String getAccBranch() {
        return accBranch;
    }

    public void setAccBranch(String accBranch) {
        this.accBranch = accBranch;
    }

    public String getAccName() {
        return accName;
    }

    public void setAccName(String accName) {
        this.accName = accName;
    }

    public String getAccBank() {
        return accBank;
    }

    public void setAccBank(String accBank) {
        this.accBank = accBank;
    }

    public String getFee() {
        return fee;
    }

    public void setFee(String fee) {
        this.fee = fee;
    }

    public Date getApproveDate() {
        return approveDate;
    }

    public void setApproveDate(Date approveDate) {
        this.approveDate = approveDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getListStatus() {
        return listStatus;
    }

    public void setListStatus(List<String> listStatus) {
        this.listStatus = listStatus;
    }
}
