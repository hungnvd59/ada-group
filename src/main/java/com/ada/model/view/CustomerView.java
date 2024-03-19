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
    @Id
    @Column(name = "ID", unique = true, nullable = false)
    private Long id;
    @Column(name = "FULLNAME", nullable = false, unique = true)
    private String fullName;
    @Column(name = "MOBILE", nullable = false)
    private String mobile;
    @Column(name = "EMAIL", nullable = false)
    private String email;
    @Column(name = "EMP_CODE", nullable = false)
    private String empCode;
    @Column(name = "TEAM", nullable = false)
    private Long team;
    @Column(name = "TYPE", nullable = false)
    private Long type;
    @Column(name = "STATUS")
    private Long status;
    @Column(name = "PROVINCE_ID")
    private Long provinceId;
    @Column(name = "DISTRICT_ID")
    private Long districtId;
    @Column(name = "WARD_ID")
    private Long wardId;
    @Column(name = "ADDRESS")
    private String address;
    @Column(name = "GEN_DATE")
    private Date genDate;
    @Column(name = "LAST_UPDATED")
    private Date lastUpdated;
    @Column(name = "EMP_AVT")
    private String empAvt;
    @Column(name = "COMMING_DATE")
    private Date comingDate;
    @Column(name = "LEAVE_DATE")
    private Date leaveDate;
    @Column(name = "LINK")
    private String link;
    @Column(name = "BIRTHDAY")
    private String birthday;
    private String provinceName;
    private String districtName;
}
