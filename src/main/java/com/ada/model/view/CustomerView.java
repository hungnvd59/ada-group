package com.ada.model.view;

import lombok.Data;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Data
public class CustomerView {
    private Long id;
    private String username;
    private String password;
    private String fullName;
    private String phone;
    private String email;
    private String description;
    private Long idWard;
    private Long idDistrict;
    private Long idProvince;
    private Date lastAccessTime;
    private String address;
    private Long status;
    private Date genDate;
    private Date lastUpdated;
    private Long type;
    private String empCode;
    private String empAvt;
    private String refCode;
    private Long statusCust;
    private Date comingDate;
    private Date leaveDate;
    private String presenter;
    private String provinceName;
    private String districtName;

}
