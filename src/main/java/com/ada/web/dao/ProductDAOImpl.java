package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.model.Product;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;
import java.util.Optional;

@Repository
public class ProductDAOImpl implements ProductDAO {

    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager entityManager;
    private Logger logger = LogManager.getLogger(ProductDAOImpl.class);

    @Override
    public Optional<PagingResult> page(PagingResult page, String name, String category, String status, String toDate, String fromDate) {
        int offset = 0;
        StringBuilder sqlCount = new StringBuilder("SELECT COUNT(*) FROM ctvosp.aff_partner WHERE 1=1");
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM ctvosp.aff_partner WHERE 1 = 1 ");



        Query query = entityManager.createNamedQuery(sqlBuilder.toString(), Product.class);

        List<Product> result = query.getResultList();
        if (result != null && result.size() > 0) {
            page.setItems(result);
        }
        entityManager.close();

        return Optional.ofNullable(page);
    }
}
