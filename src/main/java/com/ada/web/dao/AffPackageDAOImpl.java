package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.model.AffPackage;
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
public class AffPackageDAOImpl implements AffPackageDAO {
    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager em;

    @Override
    public Optional<PagingResult> page(PagingResult page, String packCode, String packName, Long status, String fromDate, String toDate, String type, String loaiGoiCuoc, String giaGoi, String chuKy) {
        int offset = 0;

        try {
            StringBuilder sqlCount = new StringBuilder("SELECT COUNT(*) FROM ctvosp.aff_package pack WHERE 1=1 ");
            StringBuilder sqlBuffer = new StringBuilder("SELECT * FROM ctvosp.aff_package pack WHERE 1=1  ");

            if (packCode != null && !"".equals(packCode)) {
                sqlBuffer.append(" AND upper(pack.PACK_CODE) LIKE :packCode");
                sqlCount.append(" AND upper(pack.PACK_CODE) LIKE :packCode");
            }
            if (packName != null && !"".equals(packName)) {
                sqlBuffer.append(" AND upper(pack.PACK_NAME) LIKE :packName");
                sqlCount.append(" AND upper(pack.PACK_NAME) LIKE :packName");
            }
            if (status != null && status != -1) {
                sqlBuffer.append(" AND pack.STATUS = :status");
                sqlCount.append(" AND pack.STATUS = :status");
            }
            if (fromDate != null && !fromDate.equals("")) {
                sqlBuffer.append(" AND pack.GEN_DATE >= STR_TO_DATE(:fromDate,'%d/%m/%Y')");
                sqlCount.append(" AND pack.GEN_DATE >= STR_TO_DATE(:fromDate,'%d/%m/%Y')");
            }

            if (toDate != null && !toDate.equals("")) {
                sqlBuffer.append(" AND pack.GEN_DATE <= STR_TO_DATE(:toDate,'%d/%m/%Y') + 1 ");
                sqlCount.append(" AND pack.GEN_DATE <= STR_TO_DATE(:toDate,'%d/%m/%Y') + 1 ");
            }

            //----------------- TK Nâng cao -----------------

            if (type != null && !type.equals("-1")) {
                sqlBuffer.append(" AND pack.type = :type");
                sqlCount.append(" AND pack.type = :type");
            }
            if (loaiGoiCuoc != null && !loaiGoiCuoc.equals("-1")) {
                sqlBuffer.append(" AND pack.PACK_TYPE = :loaiGoiCuoc");
                sqlCount.append(" AND pack.PACK_TYPE = :loaiGoiCuoc");
            }
            if (giaGoi != null && !giaGoi.equals("-1")) {
                if (giaGoi.equals("0")) {
                    sqlBuffer.append(" AND pack.AMOUNT < 50000");
                    sqlCount.append(" AND pack.AMOUNT < 50000");
                } else if (giaGoi.equals("1")) {
                    sqlBuffer.append(" AND pack.AMOUNT BETWEEN 50000 AND 100000");
                    sqlCount.append(" AND pack.AMOUNT BETWEEN 50000 AND 100000");
                } else if (giaGoi.equals("2")) {
                    sqlBuffer.append(" AND pack.AMOUNT BETWEEN 100000 AND 200000");
                    sqlCount.append(" AND pack.AMOUNT BETWEEN 100000 AND 200000");
                } else if (giaGoi.equals("3")) {
                    sqlBuffer.append(" AND pack.AMOUNT BETWEEN 200000 AND 500000");
                    sqlCount.append(" AND pack.AMOUNT BETWEEN 200000 AND 500000");
                } else if (giaGoi.equals("4")) {
                    sqlBuffer.append(" AND pack.AMOUNT BETWEEN 500000 AND 1000000");
                    sqlCount.append(" AND pack.AMOUNT BETWEEN 500000 AND 1000000");
                } else if (giaGoi.equals("5")) {
                    sqlBuffer.append(" AND pack.AMOUNT > 1000000");
                    sqlCount.append(" AND pack.AMOUNT > 1000000");
                }
            }
            if (chuKy != null && !chuKy.equals("-1")) {
                if (chuKy.equals("0")) {
                    sqlBuffer.append(" AND pack.NUM_EXPIRED < 7");
                    sqlCount.append(" AND pack.NUM_EXPIRED < 7");
                } else if (chuKy.equals("1")) {
                    sqlBuffer.append(" AND pack.NUM_EXPIRED BETWEEN 7 AND 30");
                    sqlCount.append(" AND pack.NUM_EXPIRED BETWEEN 7 AND 30");
                } else if (chuKy.equals("2")) {
                    sqlBuffer.append(" AND pack.NUM_EXPIRED BETWEEN 30 AND 90");
                    sqlCount.append(" AND pack.NUM_EXPIRED BETWEEN 30 AND 90");
                } else if (chuKy.equals("3")) {
                    sqlBuffer.append(" AND pack.NUM_EXPIRED BETWEEN 90 AND 180");
                    sqlCount.append(" AND pack.NUM_EXPIRED BETWEEN 90 AND 180");
                } else if (chuKy.equals("4")) {
                    sqlBuffer.append(" AND pack.NUM_EXPIRED BETWEEN 180 AND 270");
                    sqlCount.append(" AND pack.NUM_EXPIRED BETWEEN 180 AND 270");
                } else if (chuKy.equals("5")) {
                    sqlBuffer.append(" AND pack.NUM_EXPIRED BETWEEN 270 AND 360");
                    sqlCount.append(" AND pack.NUM_EXPIRED BETWEEN 270 AND 360");
                } else if (chuKy.equals("6")) {
                    sqlBuffer.append(" AND pack.NUM_EXPIRED > 360");
                    sqlCount.append(" AND pack.NUM_EXPIRED > 360");
                }
            }
            //-------------------- END TK Nâng cao --------------------
            sqlBuffer.append(" ORDER BY pack.GEN_DATE DESC");

            System.out.println("sql " + sqlBuffer);

            Query queryCount = em.createNativeQuery(sqlCount.toString());
            Query queryExcute = em.createNativeQuery(sqlBuffer.toString(), AffPackage.class);
            if (packCode != null && !"".equals(packCode)) {
                queryExcute.setParameter("packCode", "%" + packCode.trim().toUpperCase() + "%");
                queryCount.setParameter("packCode", "%" + packCode.trim().toUpperCase() + "%");
            }
            if (packName != null && !"".equals(packName)) {
                queryExcute.setParameter("packName", "%" + packName.trim().toUpperCase() + "%");
                queryCount.setParameter("packName", "%" + packName.trim().toUpperCase() + "%");
            }
            if (status != -1 && status != null) {
                queryExcute.setParameter("status", status);
                queryCount.setParameter("status", status);
            }
            if (fromDate != null && !fromDate.equals("")) {
                queryExcute.setParameter("fromDate", fromDate);
                queryCount.setParameter("fromDate", fromDate);
            }
            if (toDate != null && !toDate.equals("")) {
                queryExcute.setParameter("toDate", toDate);
                queryCount.setParameter("toDate", toDate);
            }

            if (type != null && !type.equals("-1")) {
                queryExcute.setParameter("type", type);
                queryCount.setParameter("type", type);
            }
            if (loaiGoiCuoc != null && !loaiGoiCuoc.equals("-1")) {
                queryExcute.setParameter("loaiGoiCuoc", loaiGoiCuoc);
                queryCount.setParameter("loaiGoiCuoc", loaiGoiCuoc);
            }
            if (giaGoi != null && !giaGoi.equals("-1")) {
                //đã xử lý phía trên
            }
            if (chuKy != null && !chuKy.equals("-1")) {
                //đã xử lý phía trên
            }
            int rowCount = Integer.parseInt(queryCount.getSingleResult().toString());
            page.setRowCount(rowCount);

            if (page.getPageNumber() > 0) {
                if (page.getNumberPerPage() != 10000) {
                    offset = (page.getPageNumber() - 1) * page.getNumberPerPage();
                    queryExcute = queryExcute.setFirstResult(offset).setMaxResults(page.getNumberPerPage());
                }
            }
            List<AffPackage> result = queryExcute.getResultList();
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
    public AffPackage findById(Long id) {
        try {
            AffPackage affPackage = em.find(AffPackage.class, id);
            return affPackage;
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public AffPackage add(AffPackage bo) {
        try {
            em.persist(bo);
            em.flush();
            return bo;
        } catch (Exception e) {
        } finally {
            em.close();
        }
        return bo;
    }

    @Override
    public boolean update(AffPackage bo) {
        try {
            em.merge(bo);
            em.flush();
            return true;
        } catch (Exception e) {
        } finally {
            em.close();
        }
        return false;
    }

    @Override
    public boolean delete(Long id) {
        try {
            AffPackage affPackage = em.find(AffPackage.class, id);
            if(affPackage != null) {
                em.remove(affPackage);
                em.flush();
                return true;
            }
        } catch (Exception e) {
        } finally {
            em.close();
        }
        return false;
    }
}
