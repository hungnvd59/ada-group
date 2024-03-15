package com.ada.web.service;

import com.ada.common.PagingResult;
import com.ada.model.AffPartner;
import com.ada.web.dao.PartnerDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PartnerServiceImpl implements PartnerService {

    @Autowired
    PartnerDao partnerDao;

    @Override
    public Optional<PagingResult> page(PagingResult page, String mobile, Long status, String toDate, String fromDate) {
        return partnerDao.page(page, mobile, status, toDate, fromDate);
    }

    @Override
    public AffPartner findById(Long id) {
        return partnerDao.findById(id);
    }

    @Override
    public Boolean editPartner(AffPartner affPartner) {
        boolean isUpdate = partnerDao.editPartner(affPartner);
        if (isUpdate) return true;
        return false;
    }
}
