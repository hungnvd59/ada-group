/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ada.web.service;

import com.ada.common.Constants;
import com.ada.common.PagingResult;
import com.ada.model.Authority;
import com.ada.model.User;
import com.ada.web.dao.LogAccessDAO;
import com.ada.web.dao.AuthorityDAO;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @created_by hungnv
 * @time 12/7/2024.
 */
@Service
public class AuthorityServiceImpl implements AuthorityService {

    @Autowired
    AuthorityDAO authorityDAO;
    @Autowired
    LogAccessDAO logAccessDao;

    @Override
    public Optional<PagingResult> page(PagingResult page, String authKey) {

        return authorityDAO.page(page, authKey);
    }

    @Override
    @Transactional(value = "transactionManager")
    public boolean addAuthority(Authority authoItem, String ipClient) {
        try {
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            authoItem.setGenDate(new Date());
            authoItem.setLastUpdated(new Date());
            authoItem.setCreateBy(user.getUsername());
            authoItem.setUpdateBy(user.getUsername());
            authoItem.setAuthority(authoItem.getAuthority().trim().toUpperCase());
            boolean isUpdate = authorityDAO.addAuthority(authoItem);
            if (isUpdate) {
                logAccessDao.addLog("Thêm mới chức năng với mã chức năng " + authoItem.getAuthKey().trim().toUpperCase(),Constants.Log.system,  ipClient);
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean isExits(Authority authoItem) {
        return authorityDAO.isExits(authoItem);
    }

    @Override
    @Transactional(value = "transactionManager")
    public boolean editAuthority(Authority authoItem, String ipClient) {
        try {
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            authoItem.setLastUpdated(new Date());
            authoItem.setUpdateBy(user.getUsername());
            authoItem.setDescription(authoItem.getDescription().trim());
            boolean isUpdate = authorityDAO.editAuthority(authoItem);
            if (isUpdate) {
                logAccessDao.addLog("Sửa thông chức năng " + authoItem.getAuthKey().trim().toUpperCase(),Constants.Log.system,  ipClient);
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Authority getAuthorityById(Long id) {
        return authorityDAO.getAuthorityById(id);
    }

    @Override
    public boolean deleteAuthority(Authority authDel, String ipClient) {
        try {
            boolean isUpdate = authorityDAO.deleteAuthority(authDel);
            if (isUpdate) {
                logAccessDao.addLog( "Xóa chức năng " + authDel.getAuthKey().trim().toUpperCase(),Constants.Log.system, ipClient);
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean checkAuthorityAssigned(long authId) {
        return authorityDAO.checkAuthorityAssigned(authId);
    }

    @Override
    public List<Authority> getListAuthParent(long authId) {
        return authorityDAO.getListAuthParent(authId);
    }

    @Override
    public List<Authority> getAuthorityChildrenById(long authId) {
        return authorityDAO.getAuthorityChildrenById(authId);
    }

}
