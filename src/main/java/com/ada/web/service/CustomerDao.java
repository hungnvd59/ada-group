package com.ada.web.service;

import com.ada.common.PagingResult;
import com.ada.model.User;

import java.util.Optional;

public interface CustomerDao {
    Optional<PagingResult> page(PagingResult page, String fullName, String mobile, Long status, String presenter, Long provinceId, Long districtId, String comingDate, String leaveDate, User user);
}
