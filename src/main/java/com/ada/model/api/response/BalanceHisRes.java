package com.ada.model.api.response;

import com.ada.model.dto.BalanceHistoryDTO;

import java.util.List;

public class BalanceHisRes {
    private int rowCount;
    private List<BalanceHistoryDTO> items;

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public List<BalanceHistoryDTO> getItems() {
        return items;
    }

    public void setItems(List<BalanceHistoryDTO> items) {
        this.items = items;
    }
}
