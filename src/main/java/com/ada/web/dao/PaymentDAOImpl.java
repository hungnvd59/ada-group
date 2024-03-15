package com.ada.web.dao;

import com.ada.common.Constants;
import com.ada.common.PagingResult;
import com.ada.model.AffLogsAddBonus;
import com.ada.model.AffPartner;
import com.ada.model.AffPayment;
import com.ada.model.AffReqPayment;
import com.ada.model.view.AffReqPaymentView;
import com.ada.model.view.ReqPaymentView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.text.SimpleDateFormat;
import java.util.*;

@Repository
@Transactional
public class PaymentDAOImpl implements PaymentDAO {
    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager entityManager;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private PartnerDao partnerDao;

    @Override
    public AffReqPayment getReqPaymentById(Long id) {
        AffReqPayment result = null;
        try {
            result = entityManager.find(AffReqPayment.class, id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }

    @Override
    public AffReqPaymentView getInfoReqPaymentById(Long idReqPayment, Long statusPayment) {
        AffReqPaymentView result = null;
        try {
            StringBuffer sqlBuffer = null;
            if (Objects.equals(statusPayment, Constants.REQUEST_STATUS.DA_DUYET)) {
                sqlBuffer = new StringBuffer(" SELECT " +
                        " a.id," +
                        " a.partner_id," +
                        " b.partner_name as req_partner_name," +
                        " b.username," +
                        " a.gen_date, " +
                        " b.acc_balance, " +
                        " a.amount," +
                        " a.content," +
                        " a.source_request, " +
                        " a.acc_bank, " +
                        " a.acc_branch, " +
                        " a.acc_number," +
                        " a.acc_name," +
                        " a.status, " +
                        " c.payment_by," +
                        " c.payment_date, " +
                        " a.fee, " +
                        " a.REQ_CODE, " +
                        " a.description, a.WALLET_BALANCE " +
                        "FROM" +
                        " aff_req_payment a, " +
                        " aff_partner b, " +
                        " aff_payment c" +
                        " WHERE " +
                        " a.partner_id = b.id " +
                        " AND  c.req_payment_id = a.id " +
                        " and  a.id = :id_req_payment ");
            } else {
                sqlBuffer = new StringBuffer("SELECT " +
                        " a.id," +
                        " a.partner_id," +
                        " b.partner_name as req_partner_name," +
                        " b.username," +
                        " a.gen_date," +
                        " b.acc_balance," +
                        " a.amount," +
                        " a.content," +
                        " a.source_request," +
                        " a.acc_bank," +
                        " a.acc_branch," +
                        " a.acc_number," +
                        " a.acc_name," +
                        " a.status," +
                        " a.acc_name as payment_by," +
                        " a.gen_date as payment_date, " +
                        " a.fee, " +
                        " a.REQ_CODE, " +
                        " a.description, a.WALLET_BALANCE " +
                        " FROM " +
                        " aff_req_payment a," +
                        " aff_partner b" +
                        " WHERE " +
                        " a.partner_id = b.id " +
                        " and a.id = :id_req_payment");
            }
            Query query = entityManager.createNativeQuery(sqlBuffer.toString(), AffReqPaymentView.class);
            query.setParameter("id_req_payment", idReqPayment);
            if (query.getResultList() != null && query.getResultList().size() > 0) {
                result = (AffReqPaymentView) query.getResultList().get(0);
            } else {
                result = null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            entityManager.close();
        }
        return result;
    }

    @Override
    public AffPayment getPaymentById(Long id) {
        AffPayment result = null;
        try {
            result = entityManager.find(AffPayment.class, id);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            entityManager.close();
        }
        return result;
    }

    @Override
    public AffReqPayment addReqPayment(AffReqPayment bo) {
        try {
            entityManager.persist(bo);
            entityManager.flush();
            return bo;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return bo;
    }

    @Override
    public AffPayment addPayment(AffPayment bo) {
        try {
            entityManager.persist(bo);
            entityManager.flush();
            return bo;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return bo;
    }

    @Override
    public Optional<PagingResult> pageReqPayment(PagingResult pageRs, String mobile, Long status, Date fromDate, Date toDate, Date fromPaymentDate, Date toPaymentDate, String reqCode, String typeExport) {
        int page = pageRs.getPageNumber();
        int sizeOfPage = pageRs.getNumberPerPage();

        int from = (page - 1) * sizeOfPage;
        int to = page * sizeOfPage + 1;

        try {

            StringBuffer strWhere = new StringBuffer();
            if (mobile != null && !"".equals(mobile)) {
                strWhere.append(" and UPPER(b.mobile) like :mobile");
            }
            if (reqCode != null && !"".equals(reqCode)) {
                strWhere.append(" and UPPER(a.REQ_CODE) like :reqCode");
            }
            if (status != null) {
                strWhere.append(" and a.status = :status");
            }
            if (typeExport != null && "1".equals(typeExport) && status == null) {
                strWhere.append(" and a.status in (1,3)");
            }
            if (fromDate != null) {
                strWhere.append(" and a.gen_date >= :fromDate");
            }
            if (toDate != null) {
                strWhere.append(" and a.gen_date <= :toDate");
            }
            if (fromPaymentDate != null) {
                strWhere.append(" and a.APPROVE_DATE >= :fromPaymentDate");
            }
            if (toPaymentDate != null) {
                strWhere.append(" and a.APPROVE_DATE <= :toPaymentDate");
            }
/*
            strWhere.append(" order by CASE\n" +
                    "    WHEN a.status =3 THEN 1\n" +
                    "    WHEN a.status =1 THEN 2\n" +
                    "    WHEN a.status =0 THEN 3\n" +
                    "    WHEN a.status =2 THEN 4\n" +
                    "    ELSE 5\n" +
                    "END ,a.gen_date desc");
*/

            strWhere.append(" order by a.gen_date desc");

            StringBuilder sqlBuffer = new StringBuilder("SELECT a.id,a.REQ_CODE,a.partner_id,a.status,b.partner_name req_partner_name,b.username,a.gen_date,c.payment_date,c.amount,a.source_request, a.amount as req_amount, a.last_updated, b.ACC_NUMBER, b.ACC_BRANCH, b.ACC_NAME, b.ACC_BANK, a.fee, a.APPROVE_DATE, a.DESCRIPTION " +
                    " FROM  aff_req_payment a left join aff_partner b on a.partner_id = b.id left join aff_payment c on a.id = c.req_payment_id " +
                    " where 1 = 1");

            sqlBuffer.append(strWhere.toString());
            Query query = entityManager.createNativeQuery(sqlBuffer.toString(), ReqPaymentView.class);
            if (mobile != null & !"".equals(mobile)) {
                query.setParameter("mobile", "%" + mobile + "%");
            }
            if (reqCode != null && !"".equals(reqCode)) {
                query.setParameter("reqCode", "%" + reqCode.trim().toUpperCase() + "%");
            }
            if (status != null) {
                query.setParameter("status", status);
            }
            if (fromDate != null) {
                query.setParameter("fromDate", fromDate);
            }
            if (toDate != null) {
                query.setParameter("toDate", toDate);
            }
            if (fromPaymentDate != null) {
                query.setParameter("fromPaymentDate", fromPaymentDate);
            }
            if (toPaymentDate != null) {
                query.setParameter("toPaymentDate", toPaymentDate);
            }
            pageRs.setRowCount(query.getResultList().size());
            List<Object[]> list = query.setFirstResult(from).setMaxResults(to).getResultList();
            byte checkLast = 0;
            if (list.size() <= sizeOfPage) {
                checkLast = 1;
            } else {
                list = list.subList(0, sizeOfPage);
            }
            if (list.size() > 0) {
                pageRs.setItems(list);
            }
            pageRs.setCheckLast(checkLast);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return Optional.of(pageRs);
    }

    @Override
    public Optional<PagingResult> pagePayment(PagingResult pageRs, Long partnerId, Long status, Date fromDate, Date toDate) {
        int page = pageRs.getPageNumber();
        int sizeOfPage = pageRs.getNumberPerPage();

        int from = (page - 1) * sizeOfPage;
        int to = page * sizeOfPage + 1;

        try {

            StringBuffer strWhere = new StringBuffer();
            if (partnerId != null) {
                strWhere.append(" and p.partnerId = :partnerId");
            }
            if (status != null) {
                strWhere.append(" and p.status = :status");
            }
            if (fromDate != null) {
                strWhere.append(" and p.genDate >= :fromDate");
            }
            if (toDate != null) {
                strWhere.append(" and p.genDate <= :toDate");
            }

            StringBuffer sqlBuffer = new StringBuffer("SELECT p FROM AffPayment p where 1 = 1 ");
            sqlBuffer.append(strWhere.toString());
            Query query = entityManager.createQuery(sqlBuffer.toString());
            if (partnerId != null) {
                query.setParameter("partnerId", partnerId);
            }
            if (status != null) {
                query.setParameter("status", status);
            }
            if (fromDate != null) {
                query.setParameter("fromDate", fromDate);
            }
            if (toDate != null) {
                query.setParameter("toDate", toDate);
            }
            List<Object[]> list = query.setFirstResult(from).setMaxResults(to).getResultList();

            byte checkLast = 0;
            if (list.size() <= sizeOfPage) {
                checkLast = 1;
            } else {
                list = list.subList(0, sizeOfPage);
            }

            if (list.size() > 0) {
                pageRs.setItems(list);
            }
            pageRs.setCheckLast(checkLast);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return Optional.of(pageRs);
    }

    @Override
    public boolean editReqPayment(AffReqPayment bo) {
        try {
            entityManager.merge(bo);
            entityManager.flush();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean editPayment(AffPayment bo) {
        try {
            entityManager.merge(bo);
            entityManager.flush();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return false;
    }

    @Override
    public Long getTotalAmountByIdPartner(Long id) {
        Long totalAmount = 0l;
        try {
            Query query = entityManager.createNativeQuery("select sum(a.amount) from aff_payment a, aff_req_payment b where a.REQ_PAYMENT_ID = b.id and b.PARTNER_ID=:id");
            query.setParameter("id", id);
            Object result = query.getSingleResult();
            if (result != null) {
                totalAmount = Long.valueOf(result.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return totalAmount;
    }

    @Override
    public Long getAccBalanceInTimeReq(Long idPartner, Date genDate) {
        Long accBalanceInTimeReq = -1l;
        Long accBalanceNow = 0l;
        Long totalAmountPayment = 0l;
        AffPartner user = partnerDao.findById(idPartner);
        if (user != null && !user.equals("")) {
            totalAmountPayment = getTotalAmountByIdPartner(user.getId());
            if (user.getAccBalance() != null) {
                accBalanceNow = user.getAccBalance();
            }
            Long totalAmount = 0l;
            try {
                Query query = entityManager.createNativeQuery("select sum(a.amount) from aff_payment a, aff_req_payment b where a.REQ_PAYMENT_ID = b.id and b.PARTNER_ID=:id and b.gen_date < :genDate");
                query.setParameter("id", idPartner);
                query.setParameter("genDate", genDate);
                Object objects = query.getSingleResult();
                if (objects != null) {
                    totalAmount = Long.valueOf(objects.toString());
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                entityManager.close();
            }
            accBalanceInTimeReq = totalAmountPayment + accBalanceNow - totalAmount;
        }
        return accBalanceInTimeReq;
    }

    @Override
    public AffPayment getPaymentByReqPaymentId(Long reqPaymentId) {
        AffPayment result = null;
        try {
            Query query = entityManager.createNativeQuery("select * from aff_payment where REQ_PAYMENT_ID=:reqId", AffPayment.class);
            query.setParameter("reqId", reqPaymentId);
            if (query.getResultList() != null && query.getResultList().size() > 0) {
                result = (AffPayment) query.getResultList().get(0);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            entityManager.close();
        }
        return result;
    }

    @Override
    public Optional<PagingResult> pageReqPaymentCtv(PagingResult pageRs, String partnerName, String username, Long status, Date fromDate, Date toDate) {
        int page = pageRs.getPageNumber();
        int sizeOfPage = pageRs.getNumberPerPage();

        int from = (page - 1) * sizeOfPage;
        int to = page * sizeOfPage + 1;

        try {

            StringBuffer strWhere = new StringBuffer();
            if (partnerName != null && !"".equals(partnerName)) {
                strWhere.append(" and b.partner_name like :partnerName");
            }
            if (username != null) {
                strWhere.append(" and b.mobile = :mobile");
            }
            if (status != null) {
                strWhere.append(" and a.status = :status");
            }
            if (fromDate != null) {
                strWhere.append(" and a.gen_date >= :fromDate");
            }
            if (toDate != null) {
                strWhere.append(" and a.gen_date <= :toDate");
            }
            strWhere.append(" Order by a.gen_date desc");

            StringBuffer sqlBuffer = new StringBuffer(" SELECT a.id, a.REQ_CODE, a.partner_id,a.status,b.partner_name req_partner_name,b.username,a.gen_date,c.payment_date as payment_date,c.amount as amount,a.source_request, a.amount as req_amount, a.last_updated as last_updated , b.ACC_NUMBER, b.ACC_BRANCH, b.ACC_NAME, b.ACC_BANK, a.fee, a.APPROVE_DATE, a.DESCRIPTION " +
                    " FROM  aff_req_payment a left join aff_partner b on a.partner_id = b.id left join aff_payment c on c.req_payment_id = a.id " +
                    " where  a.partner_id = b.id ");
            sqlBuffer.append(strWhere.toString());
            Query query = entityManager.createNativeQuery(sqlBuffer.toString(), ReqPaymentView.class);
            if (partnerName != null & !"".equals(partnerName)) {
                query.setParameter("partnerName", "%" + partnerName + "%");
            }
            if (username != null) {
                query.setParameter("mobile", "%" + username + "%");
            }
            if (status != null) {
                query.setParameter("status", status);
            }
            if (fromDate != null) {
                query.setParameter("fromDate", fromDate);
            }
            if (toDate != null) {
                query.setParameter("toDate", toDate);
            }
            pageRs.setRowCount(query.getResultList().size());
            List<Object[]> list = query.setFirstResult(from).setMaxResults(to).getResultList();
            byte checkLast = 0;
            if (list.size() <= sizeOfPage) {
                checkLast = 1;
            } else {
                list = list.subList(0, sizeOfPage);
            }
            if (list.size() > 0) {
                pageRs.setItems(list);
            }
            pageRs.setCheckLast(checkLast);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return Optional.of(pageRs);
    }

    @Override
    public Long countRequest(Long idPartner) {
        Long total = 0L;
        try {
            Query query = entityManager.createNativeQuery("select count(1) from aff_req_payment a where a.PARTNER_ID = :id and TRUNC(a.GEN_DATE) = TRUNC(sysdate) ");
            query.setParameter("id", idPartner);
//            query.setParameter("status", Constants.REQUEST_STATUS.CHO_DUYET);
            Object result = query.getSingleResult();
            if (result != null) {
                total = Long.valueOf(result.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return total;
    }

    @Override
    public Long checkRequestDoing(Long idPartner) {
        Long total = 0L;
        try {
            Query query = entityManager.createNativeQuery(" select count(1) from aff_req_payment a where a.PARTNER_ID = :id and a.STATUS = 3 ");
            query.setParameter("id", idPartner);
//            query.setParameter("status", Constants.REQUEST_STATUS.CHO_DUYET);
            Object result = query.getSingleResult();
            if (result != null) {
                total = Long.valueOf(result.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return total;
    }

    @Override
    public Long checkRequestWait(Long idPartner) {
        Long total = 0L;
        try {
            Query query = entityManager.createNativeQuery(" select count(1) from aff_req_payment a where a.PARTNER_ID = :id and a.STATUS = 1 ");
            query.setParameter("id", idPartner);
//            query.setParameter("status", Constants.REQUEST_STATUS.CHO_DUYET);
            Object result = query.getSingleResult();
            if (result != null) {
                total = Long.valueOf(result.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return total;
    }

    @Override
    public AffReqPayment getReqPaymentByReqCode(String reqCode) {
        List<AffReqPayment> packageList = new ArrayList<>();
        try {
            String sql = " select * from aff_req_payment where UPPER(REQ_CODE) = :reqCode ";
            Query query = entityManager.createNativeQuery(sql, AffReqPayment.class);
            query.setParameter("reqCode", reqCode.trim().toUpperCase());
            packageList = query.getResultList();
            if (packageList.size() > 0) {
                return packageList.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            entityManager.close();
        }
        return null;
    }

    @Override
    public AffReqPayment getReqPaymentByStatus(Long idPartner, Long status) {
        try {
            Query query = entityManager.createNativeQuery(" select * from aff_req_payment a where a.PARTNER_ID = :id and a.STATUS = :status order by id desc ", AffReqPayment.class);
            query.setParameter("id", idPartner);
            query.setParameter("status", status);
            List<AffReqPayment> result = query.getResultList();
            if (result != null && result.size() > 0) {
                return result.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return null;
    }

    @Override
    @Transactional
    public AffLogsAddBonus addLogsAddBonus(AffLogsAddBonus affLogsAddBonus) {
        try {
            entityManager.persist(affLogsAddBonus);
            entityManager.flush();
            return affLogsAddBonus;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return affLogsAddBonus;
    }

    @Override
    public boolean deleteLogAddBonus(String username, Long transId, Long transType) {
        try {
            Query query = entityManager.createQuery("delete from AffLogsAddBonus c where c.userName = :userName and c.transId  = :transId and c.transType = :transType")
                    .setParameter("userName", username)
                    .setParameter("transId", transId)
                    .setParameter("transType", transType);
            query.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return false;
    }

    @Override
    public List<AffPartner> getPartner() {
        try {
            Query query = entityManager.createNativeQuery(" select * from aff_partner a where 1=1 order by id desc ", AffPartner.class);

            List<AffPartner> result = query.getResultList();
            if (result != null && result.size() > 0) {
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return null;
    }

    @Override
    public String genReqCode() {
        String configCode = null;
        boolean flagGenEndConfigCode = true;
        try {
            String createDate = new SimpleDateFormat("YYMMdd").format(new Date());
            Query queryCount = entityManager.createNativeQuery("SELECT COUNT(*) FROM ctvosp.aff_req_payment config");

            int rowCount = Integer.parseInt(queryCount.getSingleResult().toString());
            Long numSeq = Long.valueOf(rowCount) + 1;
            while (flagGenEndConfigCode) {
                String seqOrderToday = "";
                if (numSeq != null) {
                    if (numSeq < 10) {
                        seqOrderToday = "000" + numSeq;
                    } else if (numSeq >= 10 && numSeq < 100) {
                        seqOrderToday = "00" + numSeq;
                    } else if (numSeq >= 100 && numSeq < 1000) {
                        seqOrderToday = "0" + numSeq;
                    } else if (numSeq >= 1000 && numSeq < 10000) {
                        seqOrderToday = "" + numSeq;
                    } else {
                        seqOrderToday = String.valueOf(numSeq);
                        seqOrderToday = seqOrderToday.substring(seqOrderToday.length() - 5, seqOrderToday.length());
                    }
                }

                configCode = Constants.CONFIG_NAME.YC + createDate + seqOrderToday;

                Query query = entityManager.createNativeQuery(" select * from aff_req_payment a where a.REQ_CODE LIKE :reqCode ", AffReqPayment.class);
                query.setParameter("reqCode", configCode);

                AffReqPayment result = (AffReqPayment) query.getSingleResult();

            }
        } catch (NoResultException ex) {
            //ex.printStackTrace();
            flagGenEndConfigCode = false;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return configCode.toUpperCase();
    }

    public Optional<AffLogsAddBonus> getLogsAddBonus(Long transId, Long transType) {
        List<AffLogsAddBonus> affLogsAddBonuses = new ArrayList<>();
        AffLogsAddBonus logsAddBonus = null;
        try {
            affLogsAddBonuses = entityManager.createQuery("SELECT u from AffLogsAddBonus u where u.transId =:transId and u.transType = :transType ", AffLogsAddBonus.class)
                    .setParameter("transId", transId)
                    .setParameter("transType", transType)
                    .getResultList();
            if (affLogsAddBonuses.size() > 0) {
                logsAddBonus = affLogsAddBonuses.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return Optional.ofNullable(logsAddBonus);
    }
}
