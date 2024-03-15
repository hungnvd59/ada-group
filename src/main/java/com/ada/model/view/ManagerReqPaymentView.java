package com.ada.model.view;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class ManagerReqPaymentView {
    @Id
    @Column(name = "ID")
    private Long id;
    @Column(name = "CREATE_BY")
    private String createBy;
    @Column(name = "PARTNER_NAME")
    private String partnerName;
    @Column(name = "EMAIL")
    private String email;
    @Column(name = "GEN_DATE")
    private Date genDate;
    @Column(name = "APPROVE_DATE")
    private Date approveDate;
    @Column(name = "PAYMENT_DATE")
    private Date paymentDate;
    @Column(name = "REQ_AMOUNT")
    private Long reqAmount;
    @Column(name = "PAY_AMOUNT")
    private Long payAmount;
    @Column(name = "STATUS")
    private Long status;
    @Column(name = "REQ_CODE")
    private String reqCode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getGenDate() {
        return genDate;
    }

    public void setGenDate(Date genDate) {
        this.genDate = genDate;
    }

    public Date getApproveDate() {
        return approveDate;
    }

    public void setApproveDate(Date approveDate) {
        this.approveDate = approveDate;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public Long getReqAmount() {
        return reqAmount;
    }

    public void setReqAmount(Long reqAmount) {
        this.reqAmount = reqAmount;
    }

    public Long getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(Long payAmount) {
        this.payAmount = payAmount;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public String getReqCode() {
        return reqCode;
    }

    public void setReqCode(String reqCode) {
        this.reqCode = reqCode;
    }
}
