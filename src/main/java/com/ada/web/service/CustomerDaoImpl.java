package com.ada.web.service;

import com.ada.common.PagingResult;
import com.ada.model.AdaCustomer;
import com.ada.model.User;
import com.ada.model.view.CustomerView;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigDecimal;
import java.util.*;

@Service
@Transactional(value = "transactionManager")
public class CustomerDaoImpl implements CustomerDao {

    private Logger logger = LogManager.getLogger(this.getClass());
    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager entityManager;

    @Override
    public Optional<PagingResult> page(PagingResult page, String fullName, String mobile, Long provinceId, Long districtId, Long team, User user) {
        int offset = 0;
        List<CustomerView> listCustomer = null;//9-1046
        try {
            StringBuffer sql = new StringBuffer("SELECT cust, cat.name, cata.name from AdaCustomer cust"
                    + " JOIN Catalogy cat ON cust.provinceId = cat.id"
                    + " JOIN Catalogy cata ON cust.districtId = cata.id "
                    + " WHERE 1=1 AND cust.status = 1");
            StringBuffer sqlCount = new StringBuffer("SELECT COUNT(*) from AdaCustomer cust"
                    + " JOIN Catalogy cat ON cust.provinceId = cat.id"
                    + " JOIN Catalogy cata ON cust.districtId = cata.id "
                    + " WHERE 1=1 AND cust.status = 1");

            Map<String, Object> vals = new HashMap<>();

            if (Integer.parseInt(user.getType().toString()) == 2) {
                sql.append(" AND cust.team = :team");
                sqlCount.append(" AND cust.team = :team");
                vals.put("team", user.getTeam());
            }
            if (fullName != null && !StringUtils.isEmpty(fullName)) {
                sql.append(" AND UPPER(cust.fullName) like UPPER(:fullName)");
                sqlCount.append(" AND UPPER(cust.fullName) like UPPER(:fullName)");
                vals.put("fullName", "%" + fullName + "%");
            }
            if (mobile != null && !StringUtils.isEmpty(mobile)) {
                sql.append(" AND cust.mobile = :mobile");
                sqlCount.append(" AND cust.mobile = :mobile");
                vals.put("mobile", mobile);
            }
            if (provinceId != null && provinceId != -1L) {
                sql.append(" AND cust.provinceId = :provinceId");
                sqlCount.append(" AND cust.provinceId = :provinceId");
                vals.put("provinceId", provinceId);
            }
            if (districtId != null && districtId != -1L) {
                sql.append(" AND cust.districtId = :districtId");
                sqlCount.append(" AND cust.districtId = :districtId");
                vals.put("districtId", districtId);
            }
            if (team != null && team != -1L) {
                sql.append(" AND cust.team = :team");
                sqlCount.append(" AND cust.team = :team");
                vals.put("team", team);
            }

            sql.append(" ORDER BY cust.id DESC");

            Query query = entityManager.createQuery(sql.toString());
            Query queryCount = entityManager.createQuery(sqlCount.toString());
            for (String key : vals.keySet()) {
                query.setParameter(key, vals.get(key));
                queryCount.setParameter(key, vals.get(key));
            }

            if (page.getPageNumber() > 0) {
                Object rowCount = queryCount.getSingleResult();
                page.setRowCount(Integer.parseInt(rowCount + ""));
                offset = (page.getPageNumber() - 1) * page.getNumberPerPage();
                query.setFirstResult(offset).setMaxResults(page.getNumberPerPage());
            }

            List<Object[]> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                listCustomer = new ArrayList<>();

                for (Object[] item : list) {
                    AdaCustomer userView = (AdaCustomer) item[0];
                    CustomerView customerView = new CustomerView();
                    customerView.setId(userView.getId());
                    customerView.setFullName(userView.getFullName());
                    customerView.setMobile(userView.getMobile());
                    customerView.setEmail(userView.getEmail());
                    customerView.setWardId(userView.getWardId());
                    customerView.setDistrictId(userView.getDistrictId());
                    customerView.setProvinceId(userView.getProvinceId());
                    customerView.setAddress(userView.getAddress());
                    customerView.setStatus(userView.getStatus());
                    customerView.setGenDate(userView.getGenDate());
                    customerView.setLastUpdated(userView.getLastUpdated());
                    customerView.setType(userView.getType());
                    customerView.setTeam(userView.getTeam());
                    customerView.setComingDate(userView.getComingDate());
                    customerView.setLeaveDate(userView.getLeaveDate());
                    customerView.setEmpCode(userView.getEmpCode());
                    customerView.setEmpAvt(userView.getEmpAvt());
                    customerView.setBirthday(userView.getBirthday());
                    customerView.setProvinceName((String) item[1]);
                    customerView.setDistrictName((String) item[2]);

                    listCustomer.add(customerView);
                }
                page.setItems(listCustomer);
            }
            return Optional.ofNullable(page);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public AdaCustomer getCustomerByMobile(String mobile) {
        try {
            Query query = entityManager.createNativeQuery("SELECT * FROM  ada_customer cust WHERE 1=1 AND  cust.mobile = :mobile", AdaCustomer.class)
                    .setParameter("mobile", mobile);
            List<AdaCustomer> adaCustomers = query.getResultList();
            if (adaCustomers != null && adaCustomers.size() > 0) {
                return adaCustomers.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
