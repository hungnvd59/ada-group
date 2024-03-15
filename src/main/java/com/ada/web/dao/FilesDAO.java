package com.ada.web.dao;

import com.ada.model.AffFiles;
import com.ada.model.view.FileUpload;

import java.util.List;

public interface FilesDAO {
    AffFiles add(AffFiles affFiles);
    List<?> getListFile(Long objectId, Long typeFile);
    FileUpload getFileByPath(String path);
    List<?> getListFileChangePolicy(Long objectId, Long typeFile);
    int removeFileById(Long id);
}
