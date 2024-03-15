package com.ada.web.service;

import com.ada.common.PagingResult;
import com.ada.model.AffPartner;

import java.util.Optional;

public interface PartnerService {
    public Optional<PagingResult> page(PagingResult page, String mobile, Long status, String toDate, String fromDate);

    public AffPartner findById(Long id);

    public Boolean editPartner(AffPartner affPartner);

}
