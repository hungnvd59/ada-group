package com.ada.web.dao;

import com.ada.common.PagingResult;

import java.util.Date;

public interface TransactionDAO {
    PagingResult page(PagingResult page, String itemType, String itemName, String msisdnContact, String mobile, String status, String type, String transCode, Date fromGenDate, Date toGenDate,
                      String msisdnType, String group_id, String doiTuongGiuSo,
                      String loaiGoiCuoc, String giaGoi, String chuKy);
}
