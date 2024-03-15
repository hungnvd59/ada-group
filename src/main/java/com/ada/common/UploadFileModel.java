package com.ada.common;

public class UploadFileModel {

    private String linkFile;
    private String fileName;
    private boolean status;

    public UploadFileModel() {
    }

    public UploadFileModel(String linkFile, String fileName, boolean status) {
        this.linkFile = linkFile;
        this.fileName = fileName;
        this.status = status;
    }

    public String getLinkFile() {
        return linkFile;
    }

    public void setLinkFile(String linkFile) {
        this.linkFile = linkFile;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
