package com.ada.web.service;import com.ada.common.PagingResult;import com.ada.model.view.ReportPartnerView;import com.ada.model.view.TransByCTVView;import com.ada.model.view.TransByDayView;import com.ada.model.view.TransByDivuView;import com.ada.web.dao.ReportDao;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;import java.util.Date;import java.util.List;@Servicepublic class ReportServiceImpl implements ReportService {    @Autowired    ReportDao reportDao;    @Override    public PagingResult pageByDay(PagingResult page, String item_type, String item_name, String msisdn_contract, String user_name, Date fromDate, Date toDate) {        PagingResult pagingResult = reportDao.pageByDay(page, item_type, item_name, msisdn_contract, user_name, fromDate, toDate).orElse(new PagingResult());        List<TransByDayView> result = reportDao.getCountByDay((List<TransByDayView>) pagingResult.getItems(), item_type, item_name, msisdn_contract, user_name);        pagingResult.setItems(result);        return pagingResult;    }    @Override    public PagingResult pageByCtv(PagingResult page, String item_type, String item_name, String msisdn_contract, String user_name, Date fromDate, Date toDate) {        PagingResult pagingResult = reportDao.pageByCTV(page, item_type, item_name, msisdn_contract, user_name, fromDate, toDate).orElse(new PagingResult());        List<TransByCTVView> result = reportDao.getCountByCTV((List<TransByCTVView>) pagingResult.getItems(), item_type, item_name, msisdn_contract, user_name, fromDate, toDate);        pagingResult.setItems(result);        return pagingResult;    }    @Override    public PagingResult pageByDivu(PagingResult page, String item_type, String msisdn_contract, String user_name, Date fromDate, Date toDate) {        PagingResult pagingResult = reportDao.pageByDivu(page, item_type, msisdn_contract, user_name, fromDate, toDate).orElse(new PagingResult());        List<TransByDivuView> result = reportDao.getCountByDivu((List<TransByDivuView>) pagingResult.getItems(), item_type, msisdn_contract, user_name, fromDate, toDate);        pagingResult.setItems(result);        return pagingResult;    }    @Override    public PagingResult reportPartner(PagingResult page, Date fromDate, Date toDate) {        PagingResult pagingResult = reportDao.pageCtv(page, fromDate, toDate).orElse(new PagingResult());        List<ReportPartnerView> result = reportDao.getCountCtv((List<ReportPartnerView>) pagingResult.getItems());        pagingResult.setItems(result);        return pagingResult;    }    @Override    public Long reportTotalPartner(String fromDate, String toDate) {        return reportDao.getTotalPartner(fromDate, toDate);    }}