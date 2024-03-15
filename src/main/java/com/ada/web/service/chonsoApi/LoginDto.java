package com.ada.web.service.chonsoApi;

public class LoginDto {
    private String userName;
    private AccessTokenInfo accessTokenInfo;
    private String rights;
    private String authorities;
    private String[] enablePayment;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public AccessTokenInfo getAccessTokenInfo() {
        return accessTokenInfo;
    }

    public void setAccessTokenInfo(AccessTokenInfo accessTokenInfo) {
        this.accessTokenInfo = accessTokenInfo;
    }

    public String getRights() {
        return rights;
    }

    public void setRights(String rights) {
        this.rights = rights;
    }

    public String getAuthorities() {
        return authorities;
    }

    public void setAuthorities(String authorities) {
        this.authorities = authorities;
    }

    public String[] getEnablePayment() {
        return enablePayment;
    }

    public void setEnablePayment(String[] enablePayment) {
        this.enablePayment = enablePayment;
    }
}
