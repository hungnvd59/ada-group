package com.ada.model;

import lombok.Data;
import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@Table(name = "aff_package")
public class AffPackage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Long id;

    @Column(name = "PACK_CODE")
    private String packCode;

    @Column(name = "PACK_ID")
    private String packId;

    @Column(name = "PACK_NAME")
    private String packName;

    @Column(name = "STATUS")
    private Long status;

    @Column(name = "AMOUNT")
    private Long amount;

    @Column(name = "TYPE")
    private Long type;

    @Column(name = "PACK_TYPE")
    private Long packType;

    @Column(name = "UNIT")
    private Long unit;

    @Column(name = "NUM_EXPIRED")
    private Long numExpired;

    @Column(name = "HH_OSP")
    private Double hhOsp;

    @Column(name = "RATIO_VALUE")
    private Long ratioValue;

    @Column(name = "PACK_DETAIL")
    private String packDetail;

    @Column(name = "GROUP_DESCRIPTION")
    private String groupDescription;

    @Column(name = "PACK_TYPE_DESCRIPTION")
    private String packTypeDescription;

    @Column(name = "CREATE_BY")
    private String createBy;

    @Column(name = "UPDATE_BY")
    private String updateBy;

    @Column(name = "GEN_DATE")
    private Date genDate;

    @Column(name = "LAST_UPDATED")
    private Date lastUpdated;

    @Column(name = "PACK_INFO")
    private String packInfo;

}
