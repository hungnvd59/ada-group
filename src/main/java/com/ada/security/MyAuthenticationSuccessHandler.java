package com.ada.security;

import com.ada.common.Constants;
import com.ada.common.Utils;
import com.ada.model.User;
import com.ada.web.dao.LogAccessDAO;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MyAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    @Autowired
    LogAccessDAO logAccessDao;
    private Logger logger= LogManager.getLogger(MyAuthenticationSuccessHandler.class);
    @Override
    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
        try{
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            httpServletRequest.getSession().setAttribute("userId",user.getId());
            String ip= Utils.getIpClient(httpServletRequest);
            httpServletRequest.getSession().setAttribute("ipClient",ip);
             logAccessDao.addLogWithUserId(user.getId(),"Đăng nhập hệ thống",Constants.Log.system,ip);
        }catch (Exception e){
            logger.error("Have an error onAuthenticationSuccess:"+e.getMessage());
        }
        httpServletResponse.setStatus(HttpServletResponse.SC_OK);
        String urlRedirect=httpServletRequest.getContextPath()+"/";
        httpServletResponse.sendRedirect(urlRedirect);
    }
}
