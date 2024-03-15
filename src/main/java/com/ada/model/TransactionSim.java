package com.ada.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "aff_trans_sim",schema = "ctvosp")
public class TransactionSim {
    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "booking_code")
    private String booking_code;

    @Column(name = "msisdn")
    private String msisdn;

    @Column(name = "msisdn_type")
    private Integer msisdn_type;

    @Column(name = "dw_type")
    private Integer dw_type;

    @Column(name = "group_id")
    private Integer group_id;

    @Column(name = "create_date")
    private Date create_date;

    @Column(name = "expried_date")
    private Date expried_date;

    @Column(name = "id_passpost")
    private String id_passpost;

    @Column(name = "full_name")
    private String full_name;

    @Column(name = "ip")
    private String ip;

    @Column(name = "msisdn_contact")
    private String msisdn_contact;

    @Column(name = "address")
    private String address;

    @Column(name = "email")
    private String email;

    @Column(name = "description")
    private String description;

    @Column(name = "type")
    private Integer type;

    @Column(name = "assign_time")
    private Date assign_time;

    @Column(name = "assign_place")
    private Integer assign_place;

    @Column(name = "connection_time")
    private Date connection_time;

    @Column(name = "connection_userid")
    private Integer connection_userid;

    @Column(name = "connection_address")
    private Integer connection_address;

    @Column(name = "payment_status")
    private Integer payment_status;

    @Column(name = "payment_expried_time")
    private Date payment_expried_time;

    @Column(name = "payment_type")
    private String payment_type;

    @Column(name = "sim_type")
    private String sim_type;

    @Column(name = "sim_serial")
    private String sim_serial;

    @Column(name = "mobishop_id")
    private Integer mobishop_id;

    @Column(name = "city_id")
    private Integer city_id;

    @Column(name = "district_id")
    private Integer district_id;

    @Column(name = "cus_pack_req")
    private String cus_pack_req;

    @Column(name = "last_updated")
    private Date last_updated;

    @Column(name = "trans_code", nullable = false)
    private String trans_code;

    @Column(name = "user_name")
    private String user_name;

    //@Transient
    @Column(name = "partner_name")
    private String partner_name;

    //@Transient
    @Column(name = "mobile")
    private String mobile;

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    //@Transient
    @Column(name = "status")
    private Integer status;

    //@Transient
    @Column(name = "share_type")
    private Integer share_type;

    //@Transient
    @Column(name = "share_value")
    private Integer share_value;

    @Column(name = "review_status")
    private Integer review_status;

    @Column(name = "review_date")
    private Date review_date;

    @Column(name = "amount")
    private Integer amount;

    @Column(name = "osp_value")
    private Integer osp_value;

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Integer getOsp_value() {
        return osp_value;
    }

    public void setOsp_value(Integer osp_value) {
        this.osp_value = osp_value;
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

    public Integer getShare_type() {
        return share_type;
    }

    public void setShare_type(Integer share_type) {
        this.share_type = share_type;
    }

    public Integer getShare_value() {
        return share_value;
    }

    public void setShare_value(Integer share_value) {
        this.share_value = share_value;
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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBooking_code() {
        return booking_code;
    }

    public void setBooking_code(String booking_code) {
        this.booking_code = booking_code;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public Integer getMsisdn_type() {
        return msisdn_type;
    }

    public void setMsisdn_type(Integer msisdn_type) {
        this.msisdn_type = msisdn_type;
    }

    public Integer getDw_type() {
        return dw_type;
    }

    public void setDw_type(Integer dw_type) {
        this.dw_type = dw_type;
    }

    public Integer getGroup_id() {
        return group_id;
    }

    public void setGroup_id(Integer group_id) {
        this.group_id = group_id;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public Date getExpried_date() {
        return expried_date;
    }

    public void setExpried_date(Date expried_date) {
        this.expried_date = expried_date;
    }

    public String getId_passpost() {
        return id_passpost;
    }

    public void setId_passpost(String id_passpost) {
        this.id_passpost = id_passpost;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getMsisdn_contact() {
        return msisdn_contact;
    }

    public void setMsisdn_contact(String msisdn_contact) {
        this.msisdn_contact = msisdn_contact;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Date getAssign_time() {
        return assign_time;
    }

    public void setAssign_time(Date assign_time) {
        this.assign_time = assign_time;
    }

    public Integer getAssign_place() {
        return assign_place;
    }

    public void setAssign_place(Integer assign_place) {
        this.assign_place = assign_place;
    }

    public Date getConnection_time() {
        return connection_time;
    }

    public void setConnection_time(Date connection_time) {
        this.connection_time = connection_time;
    }

    public Integer getConnection_userid() {
        return connection_userid;
    }

    public void setConnection_userid(Integer connection_userid) {
        this.connection_userid = connection_userid;
    }

    public Integer getConnection_address() {
        return connection_address;
    }

    public void setConnection_address(Integer connection_address) {
        this.connection_address = connection_address;
    }

    public Integer getPayment_status() {
        return payment_status;
    }

    public void setPayment_status(Integer payment_status) {
        this.payment_status = payment_status;
    }

    public Date getPayment_expried_time() {
        return payment_expried_time;
    }

    public void setPayment_expried_time(Date payment_expried_time) {
        this.payment_expried_time = payment_expried_time;
    }

    public String getPayment_type() {
        return payment_type;
    }

    public void setPayment_type(String payment_type) {
        this.payment_type = payment_type;
    }

    public String getSim_type() {
        return sim_type;
    }

    public void setSim_type(String sim_type) {
        this.sim_type = sim_type;
    }

    public String getSim_serial() {
        return sim_serial;
    }

    public void setSim_serial(String sim_serial) {
        this.sim_serial = sim_serial;
    }

    public Integer getMobishop_id() {
        return mobishop_id;
    }

    public void setMobishop_id(Integer mobishop_id) {
        this.mobishop_id = mobishop_id;
    }

    public Integer getCity_id() {
        return city_id;
    }

    public void setCity_id(Integer city_id) {
        this.city_id = city_id;
    }

    public Integer getDistrict_id() {
        return district_id;
    }

    public void setDistrict_id(Integer district_id) {
        this.district_id = district_id;
    }

    public String getCus_pack_req() {
        return cus_pack_req;
    }

    public void setCus_pack_req(String cus_pack_req) {
        this.cus_pack_req = cus_pack_req;
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

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
}
