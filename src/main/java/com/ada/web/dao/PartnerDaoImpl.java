package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.model.AffPartner;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;
import java.util.Optional;

@Repository
@Transactional(value = "transactionManager")
public class PartnerDaoImpl implements PartnerDao {

    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager em;
    private Logger logger = LogManager.getLogger(PartnerDaoImpl.class);

    @Override
    public Optional<PagingResult> page(PagingResult page, String mobile, Long status, String fromDate, String toDate) {
        int offset = 0;

        try {
            StringBuilder sqlCount = new StringBuilder("SELECT COUNT(*) FROM ctvosp.aff_partner partner WHERE partner.STATUS IN (0,1)");
            StringBuilder sqlBuffer = new StringBuilder("SELECT * FROM ctvosp.aff_partner partner WHERE partner.STATUS IN (0,1) ");

            if (!"".equals(mobile) && mobile != null) {
                sqlBuffer.append(" AND partner.MOBILE LIKE :mobile");
                sqlCount.append(" AND partner.MOBILE LIKE :mobile");
            }
            if (status != null && status != -1) {
                sqlBuffer.append(" AND partner.STATUS = :status");
                sqlCount.append(" AND partner.STATUS = :status");
            }
            if (fromDate != null && !fromDate.equals("")) {
                sqlBuffer.append(" AND partner.gen_date >= STR_TO_DATE(:fromDate,'%d/%m/%Y')");
                sqlCount.append(" AND partner.gen_date >= STR_TO_DATE(:fromDate,'%d/%m/%Y')");
            }

            if (toDate != null && !toDate.equals("")) {
                sqlBuffer.append(" AND partner.gen_date <= STR_TO_DATE(:toDate,'%d/%m/%Y')");
                sqlCount.append(" AND partner.gen_date <= STR_TO_DATE(:toDate,'%d/%m/%Y')");
            }
            sqlBuffer.append(" ORDER BY partner.GEN_DATE DESC");

            System.out.println("sql " + sqlBuffer);

            Query queryCount = em.createNativeQuery(sqlCount.toString());
            Query queryExcute = em.createNativeQuery(sqlBuffer.toString(), AffPartner.class);
            if (!"".equals(mobile) && mobile != null) {
                queryExcute.setParameter("mobile", "%" + mobile.trim() + "%");
                queryCount.setParameter("mobile", "%" + mobile.trim() + "%");
            }
            if (status != -1 && status != null) {
                queryExcute.setParameter("status", status);
                queryCount.setParameter("status", status);
            }
            if (!"".equals(fromDate) && fromDate != null) {
                queryExcute.setParameter("fromDate", fromDate);
                queryCount.setParameter("fromDate", fromDate);
            }
            if (!"".equals(toDate) && toDate != null) {
                queryExcute.setParameter("toDate", toDate);
                queryCount.setParameter("toDate", toDate);
            }
            int rowCount = Integer.parseInt(queryCount.getSingleResult().toString());
            page.setRowCount(rowCount);

            if (page.getPageNumber() > 0) {
                if (page.getNumberPerPage() != 10000) {
                    offset = (page.getPageNumber() - 1) * page.getNumberPerPage();
                    queryExcute = queryExcute.setFirstResult(offset).setMaxResults(page.getNumberPerPage());
                }
            }
            List<AffPartner> result = queryExcute.getResultList();
            if (result != null && result.size() > 0) {
                page.setItems(result);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
        return Optional.ofNullable(page);
    }

    @Override
    public Optional<PagingResult> searchAll() {
        PagingResult page = new PagingResult();
        StringBuilder sqlBuffer = new StringBuilder("SELECT * FROM ctvosp.aff_partner partner WHERE partner.STATUS IN (0,1) ");
        Query queryExcute = em.createNativeQuery(sqlBuffer.toString(), AffPartner.class);
        List<AffPartner> result = queryExcute.getResultList();
        if (result != null && result.size() > 0) {
            page.setItems(result);
        }
        return Optional.ofNullable(page);
    }

    @Override
    public AffPartner findById(Long id) {
        return em.find(AffPartner.class, id);
    }

    @Override
    public Boolean editPartner(AffPartner affPartner) {
        try {
            em.merge(affPartner);
            em.flush();
        } catch (Exception e) {
        } finally {
            em.close();
        }
        return true;
    }

    @Override
    public boolean updatePocketMoneyPartner(String userName, Long shareValue) {
        try {
            Query query = em.createNativeQuery("update ctvosp.aff_partner set acc_balance = (IFNULL(acc_balance,0) + IFNULL(:shareValue, 0)) where UPPER(USERNAME) = :userName ").setParameter("userName", userName.trim().toUpperCase()).setParameter("shareValue", shareValue);
            query.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    @Transactional
    public boolean updateConfigForPartner(Long partnerId, Long configId) {
        try {
            AffPartner partner = em.find(AffPartner.class, partnerId);
            if (partner != null) {
                partner.setConfigId(configId);
                em.merge(partner);
            }
            em.flush();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
