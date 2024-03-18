package com.ada.web.service;

import com.ada.common.PagingResult;
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
    public Optional<PagingResult> page(PagingResult page, String fullName, String mobile, Long status, String presenter, Long provinceId, Long districtId, String comingDate, String leaveDate, User user) {
        int offset = 0;
        List<CustomerView> listCustomer = null;//9-1046
        try {
            StringBuffer sql = new StringBuffer("SELECT u, cat.name, cata.name from User u" + " JOIN Catalogy cat ON u.idProvince = cat.id" + " JOIN Catalogy cata ON u.idDistrict = cata.id " + " WHERE 1=1 AND u.type = 3");
            StringBuffer sqlCount = new StringBuffer("SELECT COUNT(*) from User u" + " JOIN Catalogy cat ON u.idProvince = cat.id" + " JOIN Catalogy cata ON u.idDistrict = cata.id " + " WHERE 1=1 AND u.type = 3");

            Map<String, Object> vals = new HashMap<>();

            if (Integer.parseInt(user.getType().toString()) == 3) {
                sql.append(" AND u.presenter = :refCode");
                sqlCount.append(" AND u.presenter = :refCode");
                vals.put("refCode", user.getRefCode());
            }
            if (fullName != null && !StringUtils.isEmpty(fullName)) {
                sql.append(" AND u.fullName = :fullName");
                sqlCount.append(" AND u.fullName = :fullName");
                vals.put("fullName", fullName);
            }
            if (mobile != null && !StringUtils.isEmpty(mobile)) {
                sql.append(" AND u.phone = :mobile");
                sqlCount.append(" AND u.phone = :mobile");
                vals.put("mobile", mobile);
            }
            if (presenter != null && !StringUtils.isEmpty(presenter)) {
                sql.append(" AND u.presenter = :presenter");
                sqlCount.append(" AND u.presenter = :presenter");
                vals.put("presenter", presenter);
            }
            if (provinceId != null && provinceId != -1L) {
                sql.append(" AND u.idProvince = :provinceId");
                sqlCount.append(" AND u.idProvince = :provinceId");
                vals.put("provinceId", provinceId);
            }
            if (districtId != null && districtId != -1L) {
                sql.append(" AND u.idDistrict = :districtId");
                sqlCount.append(" AND u.idDistrict = :districtId");
                vals.put("districtId", districtId);
            }
            if (comingDate != null && !StringUtils.isEmpty(comingDate)) {
                sql.append(" AND trunc(u.comingDate) >= to_date(:comingDate, 'dd/MM/yyyy') ");
                sqlCount.append(" AND trunc(u.comingDate) >= to_date(:comingDate, 'dd/MM/yyyy') ");
                vals.put("comingDate", comingDate);
            }
            if (leaveDate != null && !StringUtils.isEmpty(leaveDate)) {
                sql.append(" AND trunc(u.leaveDate) <= to_date(:leaveDate, 'dd/MM/yyyy') ");
                sqlCount.append(" AND trunc(u.leaveDate) <= to_date(:leaveDate, 'dd/MM/yyyy') ");
                vals.put("leaveDate", leaveDate);
            }

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
                    User userView = (User) item[0];
                    CustomerView customerView = new CustomerView();
                    customerView.setId(userView.getId());
                    customerView.setUsername(userView.getUsername());
                    customerView.setPassword(userView.getPassword());
                    customerView.setFullName(userView.getFullName());
                    customerView.setPhone(userView.getPhone());
                    customerView.setEmail(userView.getEmail());
                    customerView.setDescription(userView.getDescription());
                    customerView.setIdWard(userView.getIdWard());
                    customerView.setIdDistrict(userView.getIdDistrict());
                    customerView.setIdProvince(userView.getIdProvince());
                    customerView.setAddress(userView.getAddress());
                    customerView.setLastAccessTime(userView.getLastAccessTime());
                    customerView.setStatus(userView.getStatus());
                    customerView.setGenDate(userView.getGenDate());
                    customerView.setLastUpdated(userView.getLastUpdated());
                    customerView.setType(userView.getType());
                    customerView.setRefCode(userView.getRefCode());
                    customerView.setStatusCust(userView.getStatusCust());
                    customerView.setComingDate(userView.getComingDate());
                    customerView.setLeaveDate(userView.getLeaveDate());
                    customerView.setPresenter(userView.getPresenter());
                    customerView.setEmpCode(userView.getEmpCode());
                    customerView.setEmpAvt(userView.getEmpAvt());
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
}
