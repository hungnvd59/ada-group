package com.ada.model.view;

import com.ada.model.AffPayment;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Date;

@Entity
public class AffReqPaymentView {
    @Id
    @Column(name = "ID")
    private Long id;
    @Column(name = "PARTNER_ID")
    private Long partnerId;
    @Column(name = "REQ_PARTNER_NAME")
    private String reqPartnerName;
    @Column(name = "USERNAME")
    private String reqPartnerUsername;
    @Column(name = "GEN_DATE")
    private Date genDate;
    @Column(name = "ACC_BALANCE")
    private Long accBalance;
    @Column(name = "AMOUNT")
    private Long amount;
    @Column(name = "CONTENT")
    private String content;
    @Column(name = "SOURCE_REQUEST")
    private Long sourceRequest;
    @Column(name = "ACC_BANK")
    private String accBank;
    @Column(name = "ACC_BRANCH")
    private String accBranch;
    @Column(name = "ACC_NUMBER")
    private String accNumber;
    @Column(name = "ACC_NAME")
    private String accName;
    @Column(name = "STATUS")
    private Long status;
    @Column(name = "PAYMENT_BY")
    private String paymentBy;
    @Column(name = "PAYMENT_DATE")
    private Date paymentDate;
    @Column(name = "DESCRIPTION")
    private String description;
    @Column(name = "FEE")
    private Long fee;
    @Column(name = "REQ_CODE")
    private String reqCode;
    @Column(name = "WALLET_BALANCE")
    private Long walletBalance;
    @Transient
    private String authName;

    @Transient
    private FileUpload fileLst;

    @Transient
    private FileUpload filePayment;

    @Transient
    private Long accBalanceInTimeReq;

    @Transient
    private AffPayment payment;

    @Transient
    private Long bankInfoStatusVerify;

    @Transient
    private String fullName;

    @Transient
    private String mobilePartner;

    public AffReqPaymentView() {
    }

    public AffReqPaymentView(Long id, Long partnerId, String reqPartnerName, Date genDate, Long pocketMoney, Long amount, String content, Long sourceRequest, String accBank, String accBranch, String accNumber, String accName, Long status, String paymentBy, Date paymentDate, String description, FileUpload fileLst, Long pocketMoneyInTimeReq) {
        this.id = id;
        this.partnerId = partnerId;
        this.reqPartnerName = reqPartnerName;
        this.genDate = genDate;
        this.accBalance = pocketMoney;
        this.amount = amount;
        this.content = content;
        this.sourceRequest = sourceRequest;
        this.accBank = accBank;
        this.accBranch = accBranch;
        this.accNumber = accNumber;
        this.accName = accName;
        this.status = status;
        this.paymentBy = paymentBy;
        this.paymentDate = paymentDate;
        this.description = description;
        this.fileLst = fileLst;
        this.accBalanceInTimeReq = pocketMoneyInTimeReq;
    }

    public Long getAccBalanceInTimeReq() {
        return accBalanceInTimeReq;
    }

    public void setAccBalanceInTimeReq(Long accBalanceInTimeReq) {
        this.accBalanceInTimeReq = accBalanceInTimeReq;
    }

    public FileUpload getFileLst() {
        return fileLst;
    }

    public void setFileLst(FileUpload fileLst) {
        this.fileLst = fileLst;
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

    public String getReqPartnerName() {
        return reqPartnerName;
    }

    public void setReqPartnerName(String reqPartnerName) {
        this.reqPartnerName = reqPartnerName;
    }

    public Date getGenDate() {
        return genDate;
    }

    public void setGenDate(Date genDate) {
        this.genDate = genDate;
    }

    public Long getAccBalance() {
        return accBalance;
    }

    public void setAccBalance(Long accBalance) {
        this.accBalance = accBalance;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public Long getSourceRequest() {
        return sourceRequest;
    }

    public void setSourceRequest(Long sourceRequest) {
        this.sourceRequest = sourceRequest;
    }

    public String getAccBank() {
        return accBank;
    }

    public void setAccBank(String accBank) {
        this.accBank = accBank;
    }

    public String getAccBranch() {
        return accBranch;
    }

    public void setAccBranch(String accBranch) {
        this.accBranch = accBranch;
    }

    public String getAccNumber() {
        return accNumber;
    }

    public void setAccNumber(String accNumber) {
        this.accNumber = accNumber;
    }

    public String getAccName() {
        return accName;
    }

    public void setAccName(String accName) {
        this.accName = accName;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public String getPaymentBy() {
        return paymentBy;
    }

    public void setPaymentBy(String paymentBy) {
        this.paymentBy = paymentBy;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public FileUpload getFilePayment() {
        return filePayment;
    }

    public void setFilePayment(FileUpload filePayment) {
        this.filePayment = filePayment;
    }

    public AffPayment getPayment() {
        return payment;
    }

    public void setPayment(AffPayment payment) {
        this.payment = payment;
    }

    public Long getBankInfoStatusVerify() {
        return bankInfoStatusVerify;
    }

    public void setBankInfoStatusVerify(Long bankInfoStatusVerify) {
        this.bankInfoStatusVerify = bankInfoStatusVerify;
    }

    public Long getFee() {
        return fee;
    }

    public void setFee(Long fee) {
        this.fee = fee;
    }

    public String getReqCode() {
        return reqCode;
    }

    public void setReqCode(String reqCode) {
        this.reqCode = reqCode;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getMobilePartner() {
        return mobilePartner;
    }

    public void setMobilePartner(String mobilePartner) {
        this.mobilePartner = mobilePartner;
    }

    public String getAuthName() {
        return authName;
    }

    public void setAuthName(String authName) {
        this.authName = authName;
    }

    public String getReqPartnerUsername() {
        return reqPartnerUsername;
    }

    public void setReqPartnerUsername(String reqPartnerUsername) {
        this.reqPartnerUsername = reqPartnerUsername;
    }

    public Long getWalletBalance() {

        return walletBalance;
    }

    public void setWalletBalance(Long walletBalance) {
        this.walletBalance = walletBalance;
    }
}
