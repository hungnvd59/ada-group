package com.ada.model.view;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Objects;


@Entity
public class FileUploadChangePolicy {

    @Id
    @Column(name = "FILE_ID")
    private Long idFile;
    @Column(name = "NAME")
    private String name;
    @Column(name = "LINK_FILE")
    private String linkFile;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        FileUploadChangePolicy that = (FileUploadChangePolicy) o;
        return Objects.equals(idFile, that.idFile) &&
                Objects.equals(name, that.name) &&
                Objects.equals(linkFile, that.linkFile);
    }

    @Override
    public int hashCode() {

        return Objects.hash(idFile, name, linkFile);
    }

    public Long getIdFile() {
        return idFile;
    }

    public void setIdFile(Long idFile) {
        this.idFile = idFile;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLinkFile() {
        return linkFile;
    }

    public void setLinkFile(String linkFile) {
        this.linkFile = linkFile;
    }
}
