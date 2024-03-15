package com.ada.web.dao;

import com.ada.model.AffActionLogs;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface ActionLogDAO {
    void createFullLogInsert(AffActionLogs bo, Object object, HttpServletRequest req);
    boolean addActionLog(AffActionLogs bo);
    boolean addActionLogFull(AffActionLogs bo, String action, String info, Long objectID);
    List<AffActionLogs> getListActionLogByObjectId(Long objectID);
}
