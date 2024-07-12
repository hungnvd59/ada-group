package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.common.QueryBuilder;
import com.ada.model.LogAccess;
import com.ada.model.User;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * @created_by hungnv
 * @time 12/7/2024.
 */
@Repository
@Transactional
public class LogAccessDAO {

    @PersistenceContext(unitName = "appAdmin")
    private EntityManager entityManager;
    private Logger logger = LogManager.getLogger(LogAccessDAO.class);

    @Transactional(value = "transactionManager")
    public Optional<Boolean> addLog(String action, String module, String ipClient) {
        try {
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            LogAccess log = new LogAccess();
            log.setActions(action);
            log.setModule(module);
            log.setUserId(user.getId());
            log.setIp(ipClient);
            log.setGenDate(new Date());
            entityManager.persist(log);
            entityManager.flush();
            return Optional.of(true);
        } catch (Exception e) {
            logger.error("Have error in LogAccessDaoImpl.addLog: " + e.getMessage());
            return Optional.of(Boolean.valueOf(false));
        }
    }

    @Transactional(value = "transactionManager")
    public Optional<Boolean> addLogWithUserId(Long userId, String action, String module, String ipClient) {
        try {
            LogAccess log = new LogAccess();
            log.setActions(action);
            log.setModule(module);
            log.setUserId(userId);
            log.setIp(ipClient);
            log.setGenDate(new Date());
            entityManager.persist(log);
            entityManager.flush();
            return Optional.of(true);
        } catch (Exception e) {
            logger.error("Have error in LogAccessDaoImpl.addLogWithUserId: " + e.getMessage());
            return Optional.of(Boolean.valueOf(false));
        }
    }

    public Optional<PagingResult> page(PagingResult page, String username) {
        int offset = 0;
        if (page.getPageNumber() > 0) {
            offset = (page.getPageNumber() - 1) * page.getNumberPerPage();
        }

        StringBuffer sqlBuffer = new StringBuffer("SELECT DISTINCT log.id,log.userId,log.module,log.ip,log.actions,log.genDate,u.username,to_char(log.genDate,'DD/MM/YYYY hh24:mi:ss') "
                + "from LogAccess log LEFT JOIN User u ON log.userId=u.id ");
        StringBuffer sqlBufferCount = new StringBuffer("SELECT count(DISTINCT log.id) "
                + "from LogAccess log LEFT JOIN User u ON log.userId=u.id ");

        StringBuilder sql = new StringBuilder("SELECT log.ID, log.USER_ID, log.MODULE_ID, log.IP, log.ACTIONS, log.GEN_DATE, u.USER_NAME " +
                "FROM ctvosp.adm_log_access log LEFT JOIN ctvosp.adm_users u ON log.USER_ID = u.ID WHERE u.USER_NAME LIKE :username ORDER BY log.GEN_DATE DESC");
        StringBuilder sqlCount = new StringBuilder("SELECT COUNT(*) " +
                "FROM ctvosp.adm_log_access log LEFT JOIN ctvosp.adm_users u ON log.USER_ID = u.ID WHERE u.USER_NAME LIKE :username");

        Query query = entityManager.createNativeQuery(sql.toString()).setParameter("username", username);
        List<Object[]> list = (page.getPageNumber() == 0) ? query.getResultList() : query.setFirstResult(offset).setMaxResults(page.getNumberPerPage()).getResultList();
        if (list != null && list.size() > 0) {
            page.setItems(list);
        }
        Query queryCount = entityManager.createNativeQuery(sqlCount.toString()).setParameter("username", username);
        int rowCount = Integer.parseInt(queryCount.getSingleResult().toString());
        if (rowCount != 0) {
            page.setRowCount(rowCount);
        }
        return Optional.ofNullable(page);
    }

    private Query filterBuilderSingle(StringBuffer stringBuffer, boolean order, String username) {
        Query result = null;
        try {
            QueryBuilder builder = new QueryBuilder(entityManager, stringBuffer);
            if (StringUtils.isNotBlank(username)) {
                builder.and(QueryBuilder.LIKE, "u.username", "%" + username + "%");
            }
            builder.addOrder("log.genDate", QueryBuilder.DESC);
            result = builder.initQuery(order);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }

    public Optional<PagingResult> getByUserId(PagingResult page, Long userId) {
        int offset = 0;
        if (page.getPageNumber() > 0) {
            offset = (page.getPageNumber() - 1) * page.getNumberPerPage();
        }
        List<LogAccess> items = entityManager.createQuery("Select log from LogAccess log where log.userId=:userId order by log.genDate desc ", LogAccess.class).setParameter("userId", userId)
                .setFirstResult(offset).setMaxResults(page.getNumberPerPage()).getResultList();
        Long rowCount = (Long) entityManager.createQuery("Select count(log.id) from LogAccess log where log.userId=:userId").setParameter("userId", userId).getSingleResult();
        if (items != null && items.size() > 0) {
            page.setItems(items);
        }
        if (rowCount != null && rowCount.longValue() > 0) {
            page.setRowCount(rowCount.longValue());
        }
        return Optional.of(page);
    }
}
