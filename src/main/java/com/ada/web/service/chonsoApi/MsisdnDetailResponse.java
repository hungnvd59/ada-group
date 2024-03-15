package com.ada.web.service.chonsoApi;

public class MsisdnDetailResponse extends ChonsoApiBaseResponse {
    private MsisdnDetailView data;

    public MsisdnDetailView getData() {
        return data;
    }

    public void setData(MsisdnDetailView data) {
        this.data = data;
    }
}
