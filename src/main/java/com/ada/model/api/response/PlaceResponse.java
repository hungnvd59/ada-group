package com.ada.model.api.response;

import com.ada.model.dto.PlaceDto;
import com.ada.web.service.chonsoApi.ChonsoApiBaseResponse;

import java.util.List;


public class PlaceResponse extends ChonsoApiBaseResponse {
    private List<PlaceDto> data;

    public List<PlaceDto> getData() {
        return data;
    }

    public void setData(List<PlaceDto> data) {
        this.data = data;
    }
}
