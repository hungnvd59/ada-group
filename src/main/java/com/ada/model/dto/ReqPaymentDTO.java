package com.ada.model.dto;

import com.ada.common.UploadFileModel;
import com.ada.model.AffPayment;
import com.ada.model.AffReqPayment;
import com.ada.model.view.FileUpload;

import java.util.List;

public class ReqPaymentDTO {
    private AffReqPayment reqPayment;
    private UploadFileModel detailFileUpload;
    private List<FileUpload> fileUploads;
    private AffPayment payment;
    private String flagDelete;

    public AffReqPayment getReqPayment() {
        return reqPayment;
    }

    public void setReqPayment(AffReqPayment reqPayment) {
        this.reqPayment = reqPayment;
    }

    public List<FileUpload> getFileUploads() {
        return fileUploads;
    }

    public void setFileUploads(List<FileUpload> fileUploads) {
        this.fileUploads = fileUploads;
    }

    public UploadFileModel getDetailFileUpload() {
        return detailFileUpload;
    }

    public void setDetailFileUpload(UploadFileModel detailFileUpload) {
        this.detailFileUpload = detailFileUpload;
    }

    public AffPayment getPayment() {
        return payment;
    }

    public void setPayment(AffPayment payment) {
        this.payment = payment;
    }

    public String getFlagDelete() {
        return flagDelete;
    }

    public void setFlagDelete(String flagDelete) {
        this.flagDelete = flagDelete;
    }
}
