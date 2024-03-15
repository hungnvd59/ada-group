package com.ada.model.view;

import java.util.List;

public class ItemsView<T> {
    private List<T> items;
    private Long numberPerPage = 25L;
    private Long pageNumber = 1L;
    private String packageNote;
    private Long ssid;

    public List<T> getItems() {
        return items;
    }

    public void setItems(List<T> items) {
        this.items = items;
    }

    public Long getNumberPerPage() {
        return numberPerPage;
    }

    public void setNumberPerPage(Long numberPerPage) {
        this.numberPerPage = numberPerPage;
    }

    public Long getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(Long pageNumber) {
        this.pageNumber = pageNumber;
    }

    public String getPackageNote() {
        return packageNote;
    }

    public void setPackageNote(String packageNote) {
        this.packageNote = packageNote;
    }

    public Long getSsid() {
        return ssid;
    }

    public void setSsid(Long ssid) {
        this.ssid = ssid;
    }
}
