package com.ada.web.dao;

import com.ada.model.AffFiles;
import com.ada.model.view.FileUpload;
import com.ada.model.view.FileUploadChangePolicy;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

@Repository
@Transactional(value = "transactionManager")
public class FilesDAOImpl implements FilesDAO {
    @PersistenceContext(unitName = "appAdmin")
    @Qualifier(value = "transactionManager")
    private EntityManager entityManager;

    @Override
    public AffFiles add(AffFiles affFiles) {
        try {
            entityManager.persist(affFiles);
            entityManager.flush();
            return affFiles;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return affFiles;
    }

    @Override
    public List<?> getListFile(Long objectId, Long typeFile) {
        StringBuilder sql = new StringBuilder("");
        sql.append(" SELECT f.ID as FILE_ID, f.FILE_TITLE AS FILE_NAME, f.PATH AS LINK_FILE ");
        sql.append(" FROM aff_files f ");
        sql.append(" WHERE f.FILE_TITLE IS NOT NULL AND f.FILE_TYPE = :typeFile and f.OBJECT_ID = :objectId");
        sql.append("  ORDER BY f.ID DESC ");
        Query query = entityManager.createNativeQuery(sql.toString(), FileUpload.class);
        query.setParameter("typeFile", typeFile);
        query.setParameter("objectId", objectId);
        List<Object[]> list = new ArrayList<Object[]>();
        try {
            list = query.getResultList();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            entityManager.close();
        }
        return list;
    }

    @Override
    public FileUpload getFileByPath(String path) {
        FileUpload fileUpload = null;
        if (path != null && !path.equals("") && StringUtils.isNoneBlank(path)) {
            StringBuilder file = new StringBuilder();
            file.append(" SELECT f.ID as FILE_ID, f.FILE_TITLE AS FILE_NAME, f.PATH AS LINK_FILE ");
            file.append(" FROM aff_files f ");
            file.append(" WHERE f.PATH = :path");
            Query query = entityManager.createNativeQuery(file.toString(), FileUpload.class);
            query.setParameter("path", path);
            try {
                fileUpload = (FileUpload) query.getResultList().get(0);
                ;
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                entityManager.close();
            }
        }
        return fileUpload;
    }

    @Override
    public List<?> getListFileChangePolicy(Long objectId, Long typeFile) {
        StringBuilder sql = new StringBuilder("");
        sql.append(" SELECT f.ID as FILE_ID, f.FILE_TITLE AS NAME, f.PATH AS LINK_FILE ");
        sql.append(" FROM aff_files f ");
        sql.append(" WHERE f.FILE_TITLE IS NOT NULL AND f.FILE_TYPE = :typeFile and f.OBJECT_ID = :objectId");
        sql.append("  ORDER BY f.ID DESC ");
        Query query = entityManager.createNativeQuery(sql.toString(), FileUploadChangePolicy.class);
        query.setParameter("typeFile", typeFile);
        query.setParameter("objectId", objectId);
        List<Object[]> list = new ArrayList<Object[]>();
        try {
            list = query.getResultList();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            entityManager.close();
        }
        return list;
    }

    @Override
    public int removeFileById(Long id) {
        int isSuccessful = 0;
        try {
            isSuccessful = entityManager.createQuery("delete from AffFiles p where p.id= :id")
                    .setParameter("id", id)
                    .executeUpdate();
            return isSuccessful;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return isSuccessful;
    }
}
