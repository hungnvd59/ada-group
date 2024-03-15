package com.ada.model;

import com.ada.model.api.response.PlaceResponse;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "aff_partner")
public class AffPartner implements Serializable {

    private static final long serialVersionUID = 1451508189162183268L;

    @Id
    @Column(name = "ID", nullable = false)
    private Long id;

    @Column(name = "USERNAME", nullable = false)
    private String userName;

    @Column(name = "PWD", nullable = false)
    private String pwd;

    @Column(name = "PARTNER_NAME", nullable = false)
    private String partnerName;

    @Column(name = "INFO", nullable = false)
    private String info;

    @Column(name = "STATUS", nullable = false)
    private Long status;

    @Column(name = "ROOT_ID", nullable = false)
    private Long rootId;

    @Column(name = "TYPE", nullable = false)
    private Long type;

    @Column(name = "GENDER", nullable = false)
    private String gender;

    @Column(name = "DATE_BIRTH", nullable = false)
    private Date dateBirth;

    @Column(name = "ID_NUMBER", nullable = false)
    private String idNumber;

    @Column(name = "IDENTITY_DATE", nullable = false)
    private Date identityDate;

    @Column(name = "IDENTITY_PLACE", nullable = false)
    private String identityPlace;

    @Column(name = "HOME_TOWN", nullable = false)
    private String homeTown;

    @Column(name = "PLACE_RESIDENCE", nullable = false)
    private String palaceResidence;

    @Column(name = "MOBILE", nullable = false)
    private String mobile;

    @Column(name = "ADDRESS", nullable = false)
    private String address;

    @Column(name = "EMAIL", nullable = false)
    private String email;

    @Column(name = "ACC_NUMBER", nullable = false)
    private String accNumber;

    @Column(name = "ACC_BRANCH", nullable = false)
    private String accBranch;

    @Column(name = "ACC_NAME", nullable = false)
    private String accName;

    @Column(name = "ACC_BANK", nullable = false)
    private String accBank;

    @Column(name = "SHOP_CODE", nullable = false)
    private Long shopCode;

    @Column(name = "SHOP_REGION", nullable = false)
    private Long shopRegion;

    @Column(name = "SHOP_BRANCH", nullable = false)
    private Long shopBranch;

    @Column(name = "PROVINCE_ID", nullable = false)
    private Long provinceId;

    @Column(name = "DISTRICT_ID", nullable = false)
    private Long districtId;

    @Column(name = "COMMUNE_ID", nullable = false)
    private Long communeId;

    @Column(name = "ACC_BALANCE", nullable = false)
    private Long accBalance;

    @Column(name = "LINK_AVATAR", nullable = false)
    private String linkAvt;

    @Column(name = "LINK_FRONT_ID_NUMBER", nullable = false)
    private String linkFrontIdNumber;

    @Column(name = "LINK_BACK_ID_NUMBER", nullable = false)
    private String linkBackIdNumber;

    @Column(name = "STATUS_CHANGE_BONUS", nullable = false)
    private Long statusChangeBonus;

    @Column(name = "IS_UPDATE_ADMIN", nullable = false)
    private Long isUpdateAdmin;

    @Column(name = "REF_CODE", nullable = false)
    private String refCode;

    @Column(name = "CONFIRM_PAYMENT", nullable = false)
    private Long confirmPayment;

    @Column(name = "MONEY_CONFIRM_PAYMENT", nullable = false)
    private Long moneyConfirmPayment;

    @Column(name = "NOTE", nullable = false)
    private String note;

    @Column(name = "STATUS_VERIFY", nullable = false)
    private Long statusVerify;

    @Column(name = "GEN_DATE", nullable = false)
    private Date genDate;

    @Column(name = "LAST_UPDATED", nullable = false)
    private Date lastUpdate;

    @Column(name = "CREATE_BY", nullable = false)
    private String createBy;

    @Column(name = "UPDATE_BY", nullable = false)
    private String updateBy;

    @Column(name = "JWT", nullable = false)
    private String jwt;

    @Column(name = "BANKINFO_STATUS_VERIFY")
    private Long bankInfoStatusVerify;

    @Column(name = "CONFIG_ID")
    private Long configId;

    @Column(name = "IDENTITY_TYPE", nullable = false)
    private Long identityType;

    @Transient
    private Long totalAmount;

    @Transient
    private String linkSell;

    @Transient
    private Long fee;

    @Transient
    private PlaceResponse palaceTT;

    @Transient
    private PlaceResponse palaceQH;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public Long getRootId() {
        return rootId;
    }

    public void setRootId(Long rootId) {
        this.rootId = rootId;
    }

    public Long getType() {
        return type;
    }

    public void setType(Long type) {
        this.type = type;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateBirth() {
        return dateBirth;
    }

    public void setDateBirth(Date dateBirth) {
        this.dateBirth = dateBirth;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public Date getIdentityDate() {
        return identityDate;
    }

    public void setIdentityDate(Date identityDate) {
        this.identityDate = identityDate;
    }

    public String getIdentityPlace() {
        return identityPlace;
    }

    public void setIdentityPlace(String identityPlace) {
        this.identityPlace = identityPlace;
    }

    public String getHomeTown() {
        return homeTown;
    }

    public void setHomeTown(String homeTown) {
        this.homeTown = homeTown;
    }

    public String getPalaceResidence() {
        return palaceResidence;
    }

    public void setPalaceResidence(String palaceResidence) {
        this.palaceResidence = palaceResidence;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
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

    public Long getShopCode() {
        return shopCode;
    }

    public void setShopCode(Long shopCode) {
        this.shopCode = shopCode;
    }

    public Long getShopRegion() {
        return shopRegion;
    }

    public void setShopRegion(Long shopRegion) {
        this.shopRegion = shopRegion;
    }

    public Long getShopBranch() {
        return shopBranch;
    }

    public void setShopBranch(Long shopBranch) {
        this.shopBranch = shopBranch;
    }

    public Long getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Long provinceId) {
        this.provinceId = provinceId;
    }

    public Long getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Long districtId) {
        this.districtId = districtId;
    }

    public Long getCommuneId() {
        return communeId;
    }

    public void setCommuneId(Long communeId) {
        this.communeId = communeId;
    }

    public Long getAccBalance() {
        return accBalance;
    }

    public void setAccBalance(Long accBalance) {
        this.accBalance = accBalance;
    }

    public String getLinkAvt() {
        return linkAvt;
    }

    public void setLinkAvt(String linkAvt) {
        this.linkAvt = linkAvt;
    }

    public String getLinkFrontIdNumber() {
        return linkFrontIdNumber;
    }

    public void setLinkFrontIdNumber(String linkFrontIdNumber) {
        this.linkFrontIdNumber = linkFrontIdNumber;
    }

    public String getLinkBackIdNumber() {
        return linkBackIdNumber;
    }

    public void setLinkBackIdNumber(String linkBackIdNumber) {
        this.linkBackIdNumber = linkBackIdNumber;
    }

    public Long getStatusChangeBonus() {
        return statusChangeBonus;
    }

    public void setStatusChangeBonus(Long statusChangeBonus) {
        this.statusChangeBonus = statusChangeBonus;
    }

    public Long getIsUpdateAdmin() {
        return isUpdateAdmin;
    }

    public void setIsUpdateAdmin(Long isUpdateAdmin) {
        this.isUpdateAdmin = isUpdateAdmin;
    }

    public String getRefCode() {
        return refCode;
    }

    public void setRefCode(String refCode) {
        this.refCode = refCode;
    }

    public Long getConfirmPayment() {
        return confirmPayment;
    }

    public void setConfirmPayment(Long confirmPayment) {
        this.confirmPayment = confirmPayment;
    }

    public Long getMoneyConfirmPayment() {
        return moneyConfirmPayment;
    }

    public void setMoneyConfirmPayment(Long moneyConfirmPayment) {
        this.moneyConfirmPayment = moneyConfirmPayment;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Long getStatusVerify() {
        return statusVerify;
    }

    public void setStatusVerify(Long statusVerify) {
        this.statusVerify = statusVerify;
    }

    public Date getGenDate() {
        return genDate;
    }

    public void setGenDate(Date genDate) {
        this.genDate = genDate;
    }

    public Date getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(Date lastUpdate) {
        this.lastUpdate = lastUpdate;
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

    public Long getBankInfoStatusVerify() {
        return bankInfoStatusVerify;
    }

    public void setBankInfoStatusVerify(Long bankInfoStatusVerify) {
        this.bankInfoStatusVerify = bankInfoStatusVerify;
    }

    public Long getConfigId() {
        return configId;
    }

    public void setConfigId(Long configId) {
        this.configId = configId;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Long getFee() {
        return fee;
    }

    public void setFee(Long fee) {
        this.fee = fee;
    }

    public String getJwt() {
        return jwt;
    }

    public void setJwt(String jwt) {
        this.jwt = jwt;
    }

    public Long getIdentityType() {
        return identityType;
    }

    public void setIdentityType(Long identityType) {
        this.identityType = identityType;
    }

    public String getLinkSell() {
        return linkSell;
    }

    public void setLinkSell(String linkSell) {
        this.linkSell = linkSell;
    }

    public PlaceResponse getPalaceTT() {
        return palaceTT;
    }

    public void setPalaceTT(PlaceResponse palaceTT) {
        this.palaceTT = palaceTT;
    }

    public PlaceResponse getPalaceQH() {
        return palaceQH;
    }

    public void setPalaceQH(PlaceResponse palaceQH) {
        this.palaceQH = palaceQH;
    }
}
