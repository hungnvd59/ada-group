package com.ada.model;

import com.ada.model.view.FileUpload;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "aff_payment")
public class AffPayment {
    private static final long serialVersionUID = -8299255898396933698L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Long id;
    @Column(name = "REQ_PAYMENT_ID")
    private Long reqPaymentId;
    @Column(name = "AMOUNT")
    private Long amount;
    @Column(name = "DESCRIPTION")
    private String description;
    @Column(name = "STATUS")
    private Long status;
    @Column(name = "PAYMENT_BY")
    private String paymentBy;
    @Column(name = "PAYMENT_DATE")
    private Date paymentDate;
    @Column(name = "GEN_DATE")
    private Date genDate;
    @Column(name = "LAST_UPDATED")
    private Date lastUpdated;
    @Column(name = "CREATE_BY")
    private String createBy;
    @Column(name = "UPDATE_BY")
    private String updateBy;

    @Transient
    private List<FileUpload> listFile;

    public AffPayment() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getReqPaymentId() {
        return reqPaymentId;
    }

    public void setReqPaymentId(Long reqPaymentId) {
        this.reqPaymentId = reqPaymentId;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
}
