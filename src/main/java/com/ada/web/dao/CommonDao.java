package com.ada.web.dao;

import com.ada.model.Catalogy;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

/**
 * @created_by hungnv
 * @time 12/7/2024.
 */
@Service
@Transactional
public class CommonDao extends EntityDAOImpl {
    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager entityManager;

    public List<Catalogy> getALlProvince() {
        try {
            Query query = entityManager.createQuery(
                    "select ca from Catalogy ca where ca.type = 'TT'");
            List<Catalogy> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Catalogy> getDistrictByProvince(Long id) {
        try {
            Query query = entityManager.createQuery(
                    "select ca from Catalogy ca where ca.type = 'QH' and ca.parentId = :id").setParameter("id", id);
            List<Catalogy> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Catalogy> getWardByDistrict(Long id) {
        try {
            Query query = entityManager.createQuery(
                    "select ca from Catalogy ca where ca.type = 'PX' and ca.parentId = :id").setParameter("id", id);
            List<Catalogy> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
