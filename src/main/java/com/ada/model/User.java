package com.ada.model;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * Created by Admin on 12/26/2017.
 */
@Entity
@Table(name = "adm_users")
public class User implements Serializable, UserDetails {

    private static final long serialVersionUID = -8299255898396933698L;
    @Id
    @SequenceGenerator(name = "ADM_USERS_SEQ", sequenceName = "ADM_USERS_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ADM_USERS_SEQ")
    @Column(name = "ID", unique = true, nullable = false)
    private Long id;
    @Column(name = "USERNAME", nullable = false, unique = true)
    private String username;
    @Column(name = "PASSWORD", nullable = false, length = 100)
    private String password;
    @Column(name = "FULLNAME", nullable = false, length = 100)
    private String fullName;
    @Getter
    @Column(name = "PHONE", nullable = false, length = 10)
    private String phone;
    @Getter
    @Column(name = "EMAIL", nullable = false, length = 100)
    private String email;
    @Column(name = "DESCRIPTION", length = 200)
    private String description;
    @Getter
    @Column(name = "ID_WARD")
    private Long idWard;
    @Getter
    @Column(name = "ID_DISTRICT")
    private Long idDistrict;
    @Getter
    @Column(name = "ID_PROVINCE")
    private Long idProvince;
    @Column(name = "LAST_ACCESS_TIME")
    private Date lastAccessTime;
    @Getter
    @Column(name = "ADDRESS")
    private String address;
    @Column(name = "STATUS")
    private int status;
    @Column(name = "GEN_DATE")
    private Date genDate;
    @Column(name = "LAST_UPDATED")
    private Date lastUpdated;
    @Getter
    @Column(name = "TYPE")
    private Long type;

    private transient List<GrantedAuthority> grantedAuths;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return grantedAuths;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return this.status == 1;
    }

    public List<GrantedAuthority> getGrantedAuths() {
        return grantedAuths;
    }

    public void setGrantedAuths(List<GrantedAuthority> grantedAuths) {
        this.grantedAuths = grantedAuths;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getLastAccessTime() {
        return lastAccessTime;
    }

    public void setLastAccessTime(Date lastAccessTime) {
        this.lastAccessTime = lastAccessTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getGenDate() {
        return genDate;
    }

    public void setGenDate(Date genDate) {
        this.genDate = genDate;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setIdWard(Long idWard) {
        this.idWard = idWard;
    }

    public void setIdDistrict(Long idDistrict) {
        this.idDistrict = idDistrict;
    }

    public void setIdProvince(Long idProvince) {
        this.idProvince = idProvince;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setType(Long type) {
        this.type = type;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public Long getIdWard() {
        return idWard;
    }

    public Long getIdDistrict() {
        return idDistrict;
    }

    public Long getIdProvince() {
        return idProvince;
    }

    public String getAddress() {
        return address;
    }

    public Long getType() {
        return type;
    }
}
