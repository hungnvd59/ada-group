package com.ada.web.service.chonsoApi;

import java.util.List;

public class MsisdnDetailView {
    private String packageNote;
    private List<MsisdnDetailDto> items;
    private Long ssid;

    public String getPackageNote() {
        return packageNote;
    }

    public void setPackageNote(String packageNote) {
        this.packageNote = packageNote;
    }

    public List<MsisdnDetailDto> getItems() {
        return items;
    }

    public void setItems(List<MsisdnDetailDto> items) {
        this.items = items;
    }

    public Long getSsid() {
        return ssid;
    }

    public void setSsid(Long ssid) {
        this.ssid = ssid;
    }
}
