package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.model.Transaction;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.Date;
import java.util.List;

@Repository
@Transactional(value = "transactionManager")
public class TransactionDAOImpl implements TransactionDAO {

    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager em;

    @Override
    public PagingResult page(PagingResult page, String itemType, String itemName, String msisdnContact, String mobile, String status, String type, String transCode, Date fromGenDate, Date toGenDate,
                             String msisdnType, String group_id, String doiTuongGiuSo,
                             String loaiGoiCuoc, String giaGoi, String chuKy) {
        int offset = 0;

        try {
            StringBuilder sqlBuilder = new StringBuilder("SELECT t.*, p.mobile, trans_s.type as type_telco_sim, trans_p.type as type_telco_pack" +
                    " FROM ctvosp.aff_trans t " +
                    " LEFT JOIN ctvosp.`aff_partner` p ON t.`user_name` = p.`USERNAME`" +
                    " LEFT JOIN ctvosp.`aff_trans_sim` trans_s ON trans_s.`trans_code`=t.`trans_code`" +
                    " LEFT JOIN ctvosp.`aff_trans_package` trans_p ON trans_p.`trans_code`=t.`trans_code`");
            StringBuilder sqlCount = new StringBuilder("SELECT count(*) FROM ctvosp.aff_trans t" +
                    " LEFT JOIN ctvosp.`aff_partner` p ON t.`user_name` = p.`USERNAME`" +
                    " LEFT JOIN ctvosp.`aff_trans_sim` trans_s ON trans_s.`trans_code`=t.`trans_code`" +
                    " LEFT JOIN ctvosp.`aff_trans_package` trans_p ON trans_p.`trans_code`=t.`trans_code`");
            StringBuffer sqlAppend = new StringBuffer(" WHERE 1=1");

            if (itemType != null && !itemType.equals("-1")) {
                if (itemType.equals("0")) {
                    sqlAppend.append(" AND t.item_type = 'GOICUOC'");
                } else if (itemType.equals("1")) {
                    sqlAppend.append(" AND t.item_type = 'SIMSO'");
                }
            }
            if (itemName != null && !itemName.equals("")) {
                sqlAppend.append(" AND t.item_name like :itemName");
            }
            if (msisdnContact != null && !msisdnContact.equals("")) {
                sqlAppend.append(" AND t.msisdn_contact like :msisdnContact");
            }
            if (mobile != null && !mobile.equals("")) {
                sqlAppend.append(" AND p.mobile like :mobile");
            }
            if (status != null && !status.equals("-1")) {
                if (status.equals("0")) {
                    sqlAppend.append(" AND t.status in (0, 1, 2, 4, 5, 7)");
                } else if (status.equals("1")) {
                    sqlAppend.append(" AND t.status in (3, 6)");
                }
            }
            if (type != null && !type.equals("-1")) {
                sqlAppend.append(" AND trans_p.type = :type ");
            }
            if (transCode != null && !transCode.equals("")) {
                sqlAppend.append(" AND t.trans_code like :transCode");
            }
            if (fromGenDate != null) {
                sqlAppend.append(" AND t.gen_date >= :fromGenDate");
            }
            if (toGenDate != null) {
                sqlAppend.append(" AND t.gen_date <= :toGenDate");
            }
//==================================Tim Kiem nang cao ==================================
            if (msisdnType != null && !msisdnType.equals("-1")) {
                sqlAppend.append(" AND trans_s.msisdn_type = :msisdnType");
            }
            if (group_id != null && !group_id.equals("-1")) {
                sqlAppend.append(" AND trans_s.group_id = :group_id");
            }
            if (doiTuongGiuSo != null && !doiTuongGiuSo.equals("-1")) {
                if (doiTuongGiuSo.equals("0")) {
                    sqlAppend.append(" AND (trans_s.user_name IS NULL OR trans_s.user_name = '')");
                } else if (doiTuongGiuSo.equals("1")) {
                    sqlAppend.append(" AND (trans_s.user_name IS NOT NULL OR trans_s.user_name != '')");
                }
            }
            if ((msisdnType != null && !msisdnType.equals("-1"))
                    || (group_id != null && !group_id.equals("-1"))
                    || (doiTuongGiuSo != null && !doiTuongGiuSo.equals("-1"))) {
                sqlAppend.append(" AND t.item_type = 'SIMSO'");
            }

            if (loaiGoiCuoc != null && !loaiGoiCuoc.equals("-1")) {
                sqlAppend.append(" AND trans_p.pack_type = :loaiGoiCuoc");
            }
            if (giaGoi != null && !giaGoi.equals("-1")) {
                if (giaGoi.equals("0"))
                    sqlAppend.append(" AND t.amount < 50000");
                if (giaGoi.equals("1"))
                    sqlAppend.append(" AND t.amount BETWEEN 50000 AND 100000");
                if (giaGoi.equals("2"))
                    sqlAppend.append(" AND t.amount BETWEEN 100000 AND 200000");
                if (giaGoi.equals("3"))
                    sqlAppend.append(" AND t.amount BETWEEN 200000 AND 500000");
                if (giaGoi.equals("4"))
                    sqlAppend.append(" AND t.amount BETWEEN 500000 AND 1000000");
                if (giaGoi.equals("5"))
                    sqlAppend.append(" AND t.amount > 1000000");
            }
            if (chuKy != null && !chuKy.equals("-1")) {
                sqlAppend.append(" AND trans_p.cycle = :chuKy");
            }

            if ((loaiGoiCuoc != null && !loaiGoiCuoc.equals("-1"))
                    || (giaGoi != null && !giaGoi.equals("-1"))
                    || (chuKy != null && !chuKy.equals("-1"))) {
                sqlAppend.append(" AND t.item_type = 'GOICUOC'");
            }
//================================== KT Tìm kiếm nâng cao ==================================
            Query queryCount = em.createNativeQuery(sqlCount.append(sqlAppend).toString());
            sqlAppend.append(" order by t.gen_date DESC");
            if (page.getPageNumber() > 0) {
                offset = (page.getPageNumber() - 1) * page.getNumberPerPage();
                sqlAppend.append(" limit " + offset + ", " + page.getNumberPerPage());
            }
            Query query = em.createNativeQuery(sqlBuilder.append(sqlAppend).toString(), Transaction.class);

            if (itemType != null && !itemType.equals("-1")) {
                //đã xử lý phía trên
            }
            if (itemName != null && !itemName.equals("")) {
                queryCount.setParameter("itemName", "%" + itemName + "%");
                query.setParameter("itemName", "%" + itemName + "%");
            }
            if (msisdnContact != null && !msisdnContact.equals("")) {
                queryCount.setParameter("msisdnContact", "%" + msisdnContact + "%");
                query.setParameter("msisdnContact", "%" + msisdnContact + "%");
            }
            if (mobile != null && !mobile.equals("")) {
                queryCount.setParameter("mobile", "%" + mobile + "%");
                query.setParameter("mobile", "%" + mobile + "%");
            }
            if (status != null && !status.equals("-1")) {
                //đã xử lý phía trên
            }
            if (type != null && !type.equals("-1")) {
                queryCount.setParameter("type", type);
                query.setParameter("type", type);
            }
            if (transCode != null && !transCode.equals("")) {
                queryCount.setParameter("transCode", "%" + transCode + "%");
                query.setParameter("transCode", "%" + transCode + "%");
            }
            if (fromGenDate != null) {
                queryCount.setParameter("fromGenDate", fromGenDate);
                query.setParameter("fromGenDate", fromGenDate);
            }
            if (toGenDate != null) {
                queryCount.setParameter("toGenDate", toGenDate);
                query.setParameter("toGenDate", toGenDate);
            }

            if (msisdnType != null && !msisdnType.equals("-1")) {
                queryCount.setParameter("msisdnType", msisdnType);
                query.setParameter("msisdnType", msisdnType);
            }
            if (group_id != null && !group_id.equals("-1")) {
                queryCount.setParameter("group_id", group_id);
                query.setParameter("group_id", group_id);
            }
            if (doiTuongGiuSo != null && !doiTuongGiuSo.equals("-1")) {
                //đã xử lý phía trên
            }

            if (loaiGoiCuoc != null && !loaiGoiCuoc.equals("-1")) {
                queryCount.setParameter("loaiGoiCuoc", loaiGoiCuoc);
                query.setParameter("loaiGoiCuoc", loaiGoiCuoc);
            }
            if (giaGoi != null && !giaGoi.equals("-1")) {
                //đã xử lý phía trên
            }
            if (chuKy != null && !chuKy.equals("-1")) {
                queryCount.setParameter("chuKy", chuKy);
                query.setParameter("chuKy", chuKy);
            }

            Long rowCount = ((Number) queryCount.getSingleResult()).longValue();
            page.setRowCount(rowCount);

            List<Transaction> list = query.getResultList();
            if (list != null && list.size() > 0) {
                page.setItems(list);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return page;
    }

}
