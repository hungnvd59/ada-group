package com.ada.web.dao;

import com.ada.model.TransactionSim;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Repository
@Transactional(value = "transactionManager")
public class TransactionSimDAOImpl implements TransactionSimDAO {
    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager em;

    @Override
    public TransactionSim findById(int id) {
        return em.find(TransactionSim.class, id);
    }

    @Override
    public TransactionSim findByTransCode(String transCode) {
        TransactionSim transactionSim = null;
        try {
            String sql = "SELECT trans_s.*, p.partner_name, p.mobile, t.status, t.`share_type`, t.`share_value`, t.`review_status`, t.`review_date`, t.`amount`, t.`osp_value`" +
                    " FROM ctvosp.aff_trans_sim trans_s" +
                    " LEFT JOIN `ctvosp`.`aff_partner` p ON p.`USERNAME`=(SELECT trans.`user_name` FROM `ctvosp`.`aff_trans` trans WHERE trans.`trans_code`= :transCode)" +
                    " LEFT JOIN `ctvosp`.`aff_trans` t ON t.`trans_code`=trans_s.`trans_code`" +
                    " WHERE trans_s.`trans_code`= :transCode";
            Query query = em.createNativeQuery(sql, TransactionSim.class).setParameter("transCode", transCode);
            transactionSim = (TransactionSim) query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return transactionSim;
    }
}
