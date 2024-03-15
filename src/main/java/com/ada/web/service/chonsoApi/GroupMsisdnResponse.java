package com.ada.web.service.chonsoApi;

public class GroupMsisdnResponse extends ChonsoApiBaseResponse {
    private GroupMsisdnView data;

    public GroupMsisdnView getData() {
        return data;
    }

    public void setData(GroupMsisdnView data) {
        this.data = data;
    }
}
