package com.ada.web.dao;

import com.ada.model.AffActionLogs;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @created_by hungnv
 * @time 12/7/2024.
 */
public interface ActionLogDAO {
    void createFullLogInsert(AffActionLogs bo, Object object, HttpServletRequest req);
    boolean addActionLog(AffActionLogs bo);
    boolean addActionLogFull(AffActionLogs bo, String action, String info, Long objectID);
    List<AffActionLogs> getListActionLogByObjectId(Long objectID);
}
