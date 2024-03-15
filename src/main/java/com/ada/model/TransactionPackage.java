package com.ada.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "aff_trans_package",schema = "ctvosp")
public class TransactionPackage {
    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "msisdn")
    private String msisdn;

    @Column(name = "type")
    private Integer type;

    @Column(name = "pack_code")
    private String pack_code;

    @Column(name = "reg_time")
    private Date reg_time;

    @Column(name = "resp_content")
    private String resp_content;

    @Column(name = "trans_id_get_otp")
    private String trans_id_get_otp;

    @Column(name = "otp")
    private String otp;

    @Column(name = "resp_status")
    private String resp_status;

    @Column(name = "last_updated")
    private Date last_updated;

    @Column(name = "trans_code")
    private String trans_code;

    //@Transient
    @Column(name = "partner_name")
    private String partner_name;

    //@Transient
    @Column(name = "mobile")
    private String mobile;

    //@Transient
    @Column(name = "status")
    private Integer status;

    //@Transient
    @Column(name = "source")
    private String source;

    //@Transient
    @Column(name = "share_type")
    private String share_type;

    //@Transient
    @Column(name = "share_value")
    private String share_value;

    @Column(name = "user_name")
    private String user_name;

    @Column(name = "review_status")
    private Integer review_status;

    @Column(name = "review_date")
    private Date review_date;

    @Column(name = "amount")
    private String amount;

    @Column(name = "osp_value")
    private String osp_value;

    @Column(name = "cycle")
    private Integer cycle;

    @Column(name = "pack_type")
    private Integer pack_type;

    public Integer getPack_type() {
        return pack_type;
    }

    public void setPack_type(Integer pack_type) {
        this.pack_type = pack_type;
    }

    public Integer getCycle() {
        return cycle;
    }

    public void setCycle(Integer cycle) {
        this.cycle = cycle;
    }

    public Integer getReview_status() {
        return review_status;
    }

    public void setReview_status(Integer review_status) {
        this.review_status = review_status;
    }

    public Date getReview_date() {
        return review_date;
    }

    public void setReview_date(Date review_date) {
        this.review_date = review_date;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getOsp_value() {
        return osp_value;
    }

    public void setOsp_value(String osp_value) {
        this.osp_value = osp_value;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }


    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getPartner_name() {
        return partner_name;
    }

    public void setPartner_name(String partner_name) {
        this.partner_name = partner_name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getShare_type() {
        return share_type;
    }

    public void setShare_type(String share_type) {
        this.share_type = share_type;
    }

    public String getShare_value() {
        return share_value;
    }

    public void setShare_value(String share_value) {
        this.share_value = share_value;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getPack_code() {
        return pack_code;
    }

    public void setPack_code(String pack_code) {
        this.pack_code = pack_code;
    }

    public Date getReg_time() {
        return reg_time;
    }

    public void setReg_time(Date reg_time) {
        this.reg_time = reg_time;
    }

    public String getResp_content() {
        return resp_content;
    }

    public void setResp_content(String resp_content) {
        this.resp_content = resp_content;
    }

    public String getTrans_id_get_otp() {
        return trans_id_get_otp;
    }

    public void setTrans_id_get_otp(String trans_id_get_otp) {
        this.trans_id_get_otp = trans_id_get_otp;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public String getResp_status() {
        return resp_status;
    }

    public void setResp_status(String resp_status) {
        this.resp_status = resp_status;
    }

    public Date getLast_updated() {
        return last_updated;
    }

    public void setLast_updated(Date last_updated) {
        this.last_updated = last_updated;
    }

    public String getTrans_code() {
        return trans_code;
    }

    public void setTrans_code(String trans_code) {
        this.trans_code = trans_code;
    }
}