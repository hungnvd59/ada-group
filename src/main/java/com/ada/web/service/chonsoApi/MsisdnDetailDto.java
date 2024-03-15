package com.ada.web.service.chonsoApi;

import java.util.List;

public class MsisdnDetailDto {
    private String msisdn;
    private Integer status;
    private Integer type;
    private Integer groupId;
    private String groupName;
    private Integer minPrice;
    private Integer blockTime;
    private String statusStr;
    private String typeStr;
    private String isLockStr;
    private String amDuongStr;
    private String nguHanhStr;
    private String msisdnType;
    private String msisdnFee;
    private String monthFee;
    private String msisdnTimeCK;
    private Integer roamingFee;
    private Integer extendPrice;
    private Integer serviceFee;
    private String regionStr;
    private Long dwType;
    private List<MsisdnPackageDto> packages;

    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public Integer getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Integer minPrice) {
        this.minPrice = minPrice;
    }

    public Integer getBlockTime() {
        return blockTime;
    }

    public void setBlockTime(Integer blockTime) {
        this.blockTime = blockTime;
    }

    public String getStatusStr() {
        return statusStr;
    }

    public void setStatusStr(String statusStr) {
        this.statusStr = statusStr;
    }

    public String getTypeStr() {
        return typeStr;
    }

    public void setTypeStr(String typeStr) {
        this.typeStr = typeStr;
    }

    public String getIsLockStr() {
        return isLockStr;
    }

    public void setIsLockStr(String isLockStr) {
        this.isLockStr = isLockStr;
    }

    public String getAmDuongStr() {
        return amDuongStr;
    }

    public void setAmDuongStr(String amDuongStr) {
        this.amDuongStr = amDuongStr;
    }

    public String getNguHanhStr() {
        return nguHanhStr;
    }

    public void setNguHanhStr(String nguHanhStr) {
        this.nguHanhStr = nguHanhStr;
    }

    public String getMsisdnType() {
        return msisdnType;
    }

    public void setMsisdnType(String msisdnType) {
        this.msisdnType = msisdnType;
    }

    public String getMsisdnFee() {
        return msisdnFee;
    }

    public void setMsisdnFee(String msisdnFee) {
        this.msisdnFee = msisdnFee;
    }

    public String getMonthFee() {
        return monthFee;
    }

    public void setMonthFee(String monthFee) {
        this.monthFee = monthFee;
    }

    public String getMsisdnTimeCK() {
        return msisdnTimeCK;
    }

    public void setMsisdnTimeCK(String msisdnTimeCK) {
        this.msisdnTimeCK = msisdnTimeCK;
    }

    public Integer getRoamingFee() {
        return roamingFee;
    }

    public void setRoamingFee(Integer roamingFee) {
        this.roamingFee = roamingFee;
    }

    public Integer getExtendPrice() {
        return extendPrice;
    }

    public void setExtendPrice(Integer extendPrice) {
        this.extendPrice = extendPrice;
    }

    public Integer getServiceFee() {
        return serviceFee;
    }

    public void setServiceFee(Integer serviceFee) {
        this.serviceFee = serviceFee;
    }

    public String getRegionStr() {
        return regionStr;
    }

    public void setRegionStr(String regionStr) {
        this.regionStr = regionStr;
    }

    public Long getDwType() {
        return dwType;
    }

    public void setDwType(Long dwType) {
        this.dwType = dwType;
    }

    public List<MsisdnPackageDto> getPackages() {
        return packages;
    }

    public void setPackages(List<MsisdnPackageDto> packages) {
        this.packages = packages;
    }
}
