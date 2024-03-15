package com.ada.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Data
@Table(name = "aff_trans",schema = "ctvosp")
public class Transaction implements Serializable {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "trans_code")
    private String trans_code;

    @Column(name = "user_name")
    private String user_name;

    @Column(name = "item_name")
    private String item_name;

    @Column(name = "msisdn_contact")
    private String msisdn_contact;

    @Column(name = "source")
    private String source;

    @Column(name = "item_type")
    private String item_type;

    @Column(name = "status")
    private Integer status;

    @Column(name = "share_type")
    private Integer share_type;

    @Column(name = "share_value")
    private Integer share_value;

    @Column(name = "refer_value")
    private Integer refer_value;

    @Column(name = "review_status")
    private Integer review_status;

    @Column(name = "review_date")
    private Date review_date;

    @Column(name = "create_by")
    private String create_by;

    @Column(name = "update_by")
    private String update_by;

    @Column(name = "gen_date")
    private Date gen_date;

    @Column(name = "last_updated")
    private Date last_updated;

    @Column(name = "amount")
    private Integer amount;

    @Column(name = "mobile")
    private String mobile;

    @Column(name = "osp_value")
    private String osp_value;

    @Column(name = "type_telco_sim")
    private Long type_telco_sim;

    @Column(name = "type_telco_pack")
    private Long type_telco_pack;

    @Transient
    private String typeTelcoStr;

    public String getTypeTelcoStr() {
        Long typeTelco = null;
        if(item_type != null && item_type.equals("SIMSO")){
            typeTelco = type_telco_sim;
        } else {
            typeTelco = type_telco_pack;
        }
        switch (typeTelco.toString()) {
            case "0":
                return "MobiFone";
            case "1":
                return "Viettel";
            case "2":
                return "Reddi";
            case "3":
                return "VinaPhone";
            default:
                return "-";
        }
    }
}
