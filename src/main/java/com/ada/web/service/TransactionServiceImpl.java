package com.ada.web.service;

import com.ada.common.PagingResult;
import com.ada.web.dao.TransactionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class TransactionServiceImpl implements TransactionService {
    @Autowired
    TransactionDAO transactionDAO;

    @Override
    public PagingResult page(PagingResult page, String itemType, String itemName, String msisdnContact, String mobile, String status, String type, String transCode, Date fromGenDate, Date toGenDate,
                             String msisdnType, String group_id, String doiTuongGiuSo,
                             String loaiGoiCuoc, String giaGoi, String chuKy) {
        return transactionDAO.page(page, itemType, itemName, msisdnContact, mobile, status, type, transCode, fromGenDate, toGenDate,
                msisdnType,group_id, doiTuongGiuSo,
                loaiGoiCuoc, giaGoi, chuKy);
    }
}
