package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.model.AffPartner;

import java.util.Optional;

public interface PartnerDao {
    Optional<PagingResult> page(PagingResult page, String mobile, Long status, String fromDate, String toDate);

    AffPartner findById(Long id);

    Boolean editPartner(AffPartner affPartner);

    boolean updatePocketMoneyPartner(String userName, Long shareValue);

    boolean updateConfigForPartner(Long partnerId, Long configId);

    Optional<PagingResult> searchAll();

}
