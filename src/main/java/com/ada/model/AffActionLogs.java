package com.ada.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "aff_action_logs")
public class AffActionLogs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Long id;
    @Column(name = "user_name")
    private String user_name;
    @Column(name = "info")
    private String info;
    @Column(name = "action")
    private String action;
    @Column(name = "fields_name")
    private String fields_name;
    @Column(name = "object_id")
    private Long object_id;
    @Column(name = "source_logs")
    private String source_logs;
    @Column(name = "ip")
    private String ip;
    @Column(name = "user_type")
    private String user_type;
    @Column(name = "gen_date")
    private Date gen_date;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getFields_name() {
        return fields_name;
    }

    public void setFields_name(String fields_name) {
        this.fields_name = fields_name;
    }

    public Long getObject_id() {
        return object_id;
    }

    public void setObject_id(Long object_id) {
        this.object_id = object_id;
    }

    public String getSource_logs() {
        return source_logs;
    }

    public void setSource_logs(String source_logs) {
        this.source_logs = source_logs;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUser_type() {
        return user_type;
    }

    public void setUser_type(String user_type) {
        this.user_type = user_type;
    }

    public Date getGen_date() {
        return gen_date;
    }

    public void setGen_date(Date gen_date) {
        this.gen_date = gen_date;
    }
}
