package com.ada.model;

import com.ada.model.view.FileUpload;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "aff_req_payment")
public class AffReqPayment implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Long id;
    @Column(name = "PARTNER_ID")
    private Long partnerId;
    @Column(name = "CONTENT")
    private String content;
    @Column(name = "STATUS")
    private Long status;
    @Column(name = "SOURCE_REQUEST")
    private Long sourceRequest;
    @Column(name = "DESCRIPTION")
    private String description;
    @Column(name = "AMOUNT")
    private Long amount;
    @Column(name = "APPROVE_BY")
    private String approveBy;
    @Column(name = "APPROVE_DATE")
    private Date approveDate;
    @Column(name = "ACC_NAME")
    private String accName;
    @Column(name = "ACC_BANK")
    private String accBank;
    @Column(name = "ACC_NUMBER")
    private String accNumber;
    @Column(name = "ACC_BRANCH")
    private String accBranch;
    @Column(name = "GEN_DATE")
    private Date genDate;
    @Column(name = "LAST_UPDATED")
    private Date lastUpdated;
    @Column(name = "CREATE_BY")
    private String createBy;
    @Column(name = "UPDATE_BY")
    private String updateBy;
    @Column(name = "REQ_CODE")
    private String reqCode;
    @Column(name = "FEE")
    private Long fee;
    @Column(name = "WALLET_BALANCE")
    private Long walletBalance;


    @Transient
    private String paymentBy;

    @Transient
    private String partnerName;

    @Transient
    private String paymentDate;

    @Transient
    private List<FileUpload> listFile;

    @Transient
    private List<FileUpload> listFilePayment;

    @Transient
    private Long payAmount;

    @Transient
    private String response;

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPaymentBy() {
        return paymentBy;
    }

    public void setPaymentBy(String paymentBy) {
        this.paymentBy = paymentBy;
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName;
    }

    public Long getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(Long partnerId) {
        this.partnerId = partnerId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public String getApproveBy() {
        return approveBy;
    }

    public void setApproveBy(String approveBy) {
        this.approveBy = approveBy;
    }

    public Date getApproveDate() {
        return approveDate;
    }

    public void setApproveDate(Date approveDate) {
        this.approveDate = approveDate;
    }

    public Date getGenDate() {
        return genDate;
    }

    public void setGenDate(Date genDate) {
        this.genDate = genDate;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public List<FileUpload> getListFile() {
        return listFile;
    }

    public void setListFile(List<FileUpload> listFile) {
        this.listFile = listFile;
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

    public Long getSourceRequest() {
        return sourceRequest;
    }

    public void setSourceRequest(Long sourceRequest) {
        this.sourceRequest = sourceRequest;
    }

    public List<FileUpload> getListFilePayment() {
        return listFilePayment;
    }

    public void setListFilePayment(List<FileUpload> listFilePayment) {
        this.listFilePayment = listFilePayment;
    }

    public String getReqCode() {
        return reqCode;
    }

    public void setReqCode(String reqCode) {
        this.reqCode = reqCode;
    }

    public Long getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(Long payAmount) {
        this.payAmount = payAmount;
    }

    public Long getFee() {
        return fee;
    }

    public void setFee(Long fee) {
        this.fee = fee;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public Long getWalletBalance() {
        return walletBalance;
    }

    public void setWalletBalance(Long walletBalance) {
        this.walletBalance = walletBalance;
    }
}

