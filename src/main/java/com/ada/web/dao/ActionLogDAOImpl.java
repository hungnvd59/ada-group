package com.ada.web.dao;

import com.google.gson.Gson;
import com.ada.common.Utils;
import com.ada.model.AffActionLogs;
import com.ada.model.User;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Repository
@Transactional
public class ActionLogDAOImpl implements ActionLogDAO {
    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager entityManager;

    @Override
    public void createFullLogInsert(AffActionLogs bo, Object object, HttpServletRequest req) {
        try {
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            ;
            Gson gson = new Gson();
            if (user != null) {
                bo.setUser_name(user.getUsername());
            }
            bo.setIp(Utils.getIpClient(req));
            bo.setFields_name(gson.toJson(object));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @Transactional
    public boolean addActionLog(AffActionLogs bo) {
        try {
            entityManager.persist(bo);
            entityManager.flush();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    @Transactional
    public boolean addActionLogFull(AffActionLogs bo, String action, String info, Long objectID) {
        bo.setAction(action);
        bo.setInfo(info);
        bo.setObject_id(objectID);
        bo.setGen_date(new Date());
        try {
            entityManager.persist(bo);
            entityManager.flush();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<AffActionLogs> getListActionLogByObjectId(Long objectID) {
        List<AffActionLogs> lstActionLogs = new ArrayList<>();
        try {
            StringBuffer sqlBuffer = new StringBuffer("select * from AFF_ACTION_LOGS where object_id = :objectId Order by Gen_date desc");
            Query query = entityManager.createNativeQuery(sqlBuffer.toString(), AffActionLogs.class);
            query.setParameter("objectId", objectID);
            lstActionLogs = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lstActionLogs;
    }

}
