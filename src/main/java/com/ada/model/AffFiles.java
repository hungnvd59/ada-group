package com.ada.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "aff_files")
public class AffFiles  implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", nullable = false)
    private Long id;
    @Column(name = "FILE_TITLE")
    private String fileTitle;
    @Column(name = "FILE_TYPE")
    private Long fileType;
    @Column(name = "OBJECT_ID")
    private Long objectId;
    @Column(name = "PATH")
    private String path;
    @Column(name = "STATUS")
    private Long status;
    @Column(name = "NAME_IN_SERVER")
    private String nameInServer;
    @Column(name = "GEN_DATE")
    private Date genDate;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFileTitle() {
        return fileTitle;
    }

    public void setFileTitle(String fileTitle) {
        this.fileTitle = fileTitle;
    }

    public Long getFileType() {
        return fileType;
    }

    public void setFileType(Long fileType) {
        this.fileType = fileType;
    }

    public Long getObjectId() {
        return objectId;
    }

    public void setObjectId(Long objectId) {
        this.objectId = objectId;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public String getNameInServer() {
        return nameInServer;
    }

    public void setNameInServer(String nameInServer) {
        this.nameInServer = nameInServer;
    }

    public Date getGenDate() {
        return genDate;
    }

    public void setGenDate(Date genDate) {
        this.genDate = genDate;
    }
}
