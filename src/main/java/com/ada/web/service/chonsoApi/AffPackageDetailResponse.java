package com.ada.web.service.chonsoApi;

public class AffPackageDetailResponse extends ChonsoApiBaseResponse {
    private ItemsView<AffPackageDetailDto> data;

    public ItemsView<AffPackageDetailDto> getData() {
        return data;
    }

    public void setData(ItemsView<AffPackageDetailDto> data) {
        this.data = data;
    }
}
