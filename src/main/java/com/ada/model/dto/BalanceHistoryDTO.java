package com.ada.model.dto;import java.util.Date;public class BalanceHistoryDTO {    private int stt;    private String username;    private String transCode;    private Long transType;    private Double amount;    private int status;    private int level;    private String description;    private String itemName;    private int shareType;    private String shareTypeStr;    private String accNumber;    private String accName;    private String accBank;    private String accBranch;    private Date genDate;    private String genDateStr;    private String statusStr;    private String transTypeStr;    private String levelStr;    public BalanceHistoryDTO() {    }    public int getStt() {        return stt;    }    public void setStt(int stt) {        this.stt = stt;    }    public String getUsername() {        return username;    }    public void setUsername(String username) {        this.username = username;    }    public String getTransCode() {        return transCode;    }    public void setTransCode(String transCode) {        this.transCode = transCode;    }    public Long getTransType() {        return transType;    }    public void setTransType(Long transType) {        this.transType = transType;    }    public Double getAmount() {        return amount;    }    public void setAmount(Double amount) {        this.amount = amount;    }    public int getStatus() {        return status;    }    public void setStatus(int status) {        this.status = status;    }    public int getLevel() {        return level;    }    public void setLevel(int level) {        this.level = level;    }    public String getDescription() {        return description;    }    public void setDescription(String description) {        this.description = description;    }    public String getItemName() {        return itemName;    }    public void setItemName(String itemName) {        this.itemName = itemName;    }    public int getShareType() {        return shareType;    }    public void setShareType(int shareType) {        this.shareType = shareType;    }    public String getShareTypeStr() {        return shareTypeStr;    }    public void setShareTypeStr(String shareTypeStr) {        this.shareTypeStr = shareTypeStr;    }    public String getAccNumber() {        return accNumber;    }    public void setAccNumber(String accNumber) {        this.accNumber = accNumber;    }    public String getAccName() {        return accName;    }    public void setAccName(String accName) {        this.accName = accName;    }    public String getAccBank() {        return accBank;    }    public void setAccBank(String accBank) {        this.accBank = accBank;    }    public String getAccBranch() {        return accBranch;    }    public void setAccBranch(String accBranch) {        this.accBranch = accBranch;    }    public Date getGenDate() {        return genDate;    }    public void setGenDate(Date genDate) {        this.genDate = genDate;    }    public String getGenDateStr() {        return genDateStr;    }    public void setGenDateStr(String genDateStr) {        this.genDateStr = genDateStr;    }    public String getStatusStr() {        return statusStr;    }    public void setStatusStr(String statusStr) {        this.statusStr = statusStr;    }    public String getTransTypeStr() {        return transTypeStr;    }    public void setTransTypeStr(String transTypeStr) {        this.transTypeStr = transTypeStr;    }    public String getLevelStr() {        return levelStr;    }    public void setLevelStr(String levelStr) {        this.levelStr = levelStr;    }}