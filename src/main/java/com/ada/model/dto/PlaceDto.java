package com.ada.model.dto;

import java.util.Date;

public class PlaceDto {

    private Long id;

    private String type;

    private String name;

    private Long active;

    private String refId;

    private Long region;

    private String description;

    private Long lastUserId;

    private Date startDate;

    private Date endDate;

    private Date genDate;

    private Date lastUpdated;

    //----------------------Hiện không dùng----------------------

    private Long feeShip;

    private Long ghnId;

    private Long communeCode;

    private Long districtCode;

    private Long provinceCode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getActive() {
        return active;
    }

    public void setActive(Long active) {
        this.active = active;
    }

    public String getRefId() {
        return refId;
    }

    public void setRefId(String refId) {
        this.refId = refId;
    }

    public Long getRegion() {
        return region;
    }

    public void setRegion(Long region) {
        this.region = region;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getLastUserId() {
        return lastUserId;
    }

    public void setLastUserId(Long lastUserId) {
        this.lastUserId = lastUserId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
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

    public Long getFeeShip() {
        return feeShip;
    }

    public void setFeeShip(Long feeShip) {
        this.feeShip = feeShip;
    }

    public Long getGhnId() {
        return ghnId;
    }

    public void setGhnId(Long ghnId) {
        this.ghnId = ghnId;
    }

    public Long getCommuneCode() {
        return communeCode;
    }

    public void setCommuneCode(Long communeCode) {
        this.communeCode = communeCode;
    }

    public Long getDistrictCode() {
        return districtCode;
    }

    public void setDistrictCode(Long districtCode) {
        this.districtCode = districtCode;
    }

    public Long getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(Long provinceCode) {
        this.provinceCode = provinceCode;
    }
}
