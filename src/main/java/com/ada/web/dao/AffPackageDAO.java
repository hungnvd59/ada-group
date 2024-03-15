package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.model.AffPackage;

import java.util.Optional;

public interface AffPackageDAO {
    Optional<PagingResult> page(PagingResult page, String packCode, String packName, Long status, String fromGenDate, String toGenDate, String type, String loaiGoiCuoc, String giaGoi, String chuKy);
    AffPackage findById(Long id);
    AffPackage add(AffPackage bo);
    boolean update(AffPackage bo);
    boolean delete(Long id);
}
