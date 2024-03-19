package com.ada.model;

import com.ada.model.view.CustomerView;
import lombok.Data;
import lombok.Getter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ada_customer")
@Data
public class AdaCustomer implements Serializable {
    private static final long serialVersionUID = -8299255898396933698L;
    @Id
    @Column(name = "ID", unique = true, nullable = false)
    private Long id;
    @Column(name = "FULLNAME", nullable = false, unique = true)
    private String fullName;
    @Column(name = "MOBILE", nullable = false)
    private String mobile;
    @Column(name = "EMAIL", nullable = false)
    private String email;
    @Getter
    @Column(name = "EMP_CODE", nullable = false)
    private String empCode;
    @Getter
    @Column(name = "TEAM", nullable = false)
    private Long team;
    @Column(name = "TYPE", nullable = false)
    private Long type;
    @Getter
    @Column(name = "STATUS")
    private Long status;
    @Getter
    @Column(name = "PROVINCE_ID")
    private Long provinceId;
    @Getter
    @Column(name = "DISTRICT_ID")
    private Long districtId;
    @Column(name = "WARD_ID")
    private Long wardId;
    @Getter
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

    public AdaCustomer() {
    }

    public AdaCustomer(CustomerView customerView) {
        this.id = customerView.getId();
        this.fullName = customerView.getFullName();
        this.mobile = customerView.getMobile();
        this.email = customerView.getEmail();
        this.empCode = customerView.getEmpCode();
        this.team = customerView.getTeam();
        this.type = customerView.getType();
        this.status = customerView.getStatus();
        this.provinceId = customerView.getProvinceId();
        this.districtId = customerView.getDistrictId();
        this.wardId = customerView.getWardId();
        this.address = customerView.getAddress();
        this.lastUpdated = customerView.getLastUpdated();
        this.empAvt = customerView.getEmpAvt();
        this.comingDate = customerView.getComingDate();
        this.leaveDate = customerView.getLeaveDate();
        this.link = customerView.getLink();
        this.birthday = customerView.getBirthday();
    }
}
