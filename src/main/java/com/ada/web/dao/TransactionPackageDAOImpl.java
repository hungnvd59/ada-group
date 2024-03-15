package com.ada.web.dao;

import com.ada.model.TransactionPackage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Repository
@Transactional(value = "transactionManager")
public class TransactionPackageDAOImpl implements TransactionPackageDAO{
    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager em;

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public TransactionPackage findById(int id){
        return em.find(TransactionPackage.class, id);
    }

    @Override
    public TransactionPackage findByTransCode(String transCode){
        TransactionPackage transactionPackage = null;
        try {
            String sql = "SELECT trans_p.*, p.`partner_name`, p.`mobile`, t.`source`, t.`status` , t.`share_type`, t.`share_value`, t.`user_name`, t.`review_status`, t.`review_date`, t.`amount`, t.`osp_value`" +
                    " FROM ctvosp.`aff_trans_package` trans_p" +
                    " LEFT JOIN `ctvosp`.`aff_partner` p ON p.`USERNAME`=(SELECT trans.`user_name` FROM `ctvosp`.`aff_trans` trans WHERE trans.`trans_code`= :transCode)" +
                    " LEFT JOIN `ctvosp`.`aff_trans` t ON t.`trans_code`=trans_p.`trans_code`" +
                    " WHERE trans_p.`trans_code`= :transCode";
            transactionPackage = (TransactionPackage) em.createNativeQuery(sql, TransactionPackage.class).setParameter("transCode", transCode).getSingleResult();
        } catch (Exception e){
            logger.error(String.format("GET_REQUEST_PAYMENT-ERROR: %s - %s", e.getMessage(), e.getCause()));
        }finally {
            em.close();
        }
        return transactionPackage;
    }
}
