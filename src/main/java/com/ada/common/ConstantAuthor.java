package com.ada.common;

import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

public class ConstantAuthor {

    public class User { //nguoi dung admin

        public static final String view = "ROLE_SYSTEM_USER_VIEW";
        public static final String add = "ROLE_SYSTEM_USER_ADD";
        public static final String edit = "ROLE_SYSTEM_USER_EDIT";
        public static final String author = "ROLE_SYSTEM_USER_AUTHORITY";
        public static final String delete = "ROLE_SYSTEM_USER_DELETE";
    }

    public class Group { // nhom quyen

        public static final String view = "ROLE_SYSTEM_GROUP_VIEW";
        public static final String add = "ROLE_SYSTEM_GROUP_ADD";
        public static final String edit = "ROLE_SYSTEM_GROUP_EDIT";
        public static final String delete = "ROLE_SYSTEM_GROUP_DELETE";
    }

    public class Log {//log

        public static final String view = "ROLE_SYSTEM_LOG_VIEW";
    }
    
    public class Parameter{
    	public static final String view="ROLE_SYSTEM_PARAMETER_VIEW";
    	public static final String update="ROLE_SYSTEM_PARAMETER_UPDATE";
    }
    
    public static class Authority {

       public static final String view="ROLE_SYSTEM_AUTHORITY_VIEW";
       public static final String edit="ROLE_SYSTEM_AUTHORITY_EDIT";
       public static final String add="ROLE_SYSTEM_AUTHORITY_ADD";
       public static final String delete="ROLE_SYSTEM_AUTHORITY_DELETE";
    }
	
	
	// Yêu cầu thanh toán adm
    public static class REQ_PAYMENT_ADM {
        public static final String view = "ROLE_REQ_PAYMENT_ADM_VIEW";
        public static final String edit = "ROLE_REQ_PAYMENT_ADM_EDIT";
        public static final String add = "ROLE_REQ_PAYMENT_ADM_ADD";
        public static final String delete = "ROLE_REQ_PAYMENT_ADM_DELETE";
        public static final String approve = "ROLE_REQ_PAYMENT_ADM_APPROVE";
    }

    // Thanh toán
    public static class PAYMENT {
        public static final String view = "ROLE_PAYMENT_VIEW";
        public static final String edit = "ROLE_PAYMENT_EDIT";
        public static final String add = "ROLE_PAYMENT_ADD";
        public static final String delete = "ROLE_PAYMENT_DELETE";
    }

    public static class TRANS {
        public static final String view = "ROLE_TRANS_VIEW";
    }

    public static class PACKAGE {
        public static final String view = "ROLE_PACKAGE_VIEW";
        public static final String edit = "ROLE_PACKAGE_EDIT";
    }


    public static boolean contain(String right) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Collection<? extends GrantedAuthority> checkRight = auth.getAuthorities();
        boolean authorized = checkRight.contains(new SimpleGrantedAuthority(right));
        if (!authorized) {
            return false;
        }
        return true;
    }

}
