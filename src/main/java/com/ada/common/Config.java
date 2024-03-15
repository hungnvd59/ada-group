/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ada.common;

import org.springframework.stereotype.Component;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

/**
 * @author xonv
 */
@Component
public class Config {
    public static String filename = "config.properties";
    //------------------------------------------------------------------------------------------------------------------
    //-----------------------------CHONSO_VNPAY-------------------------------------------------------------------------
    public static String vnp_HashSecret = com.ada.common.ConfigProperties.getConfigProperties("vnp_HashSecret", filename);
    //------------------------------------------------------------------------------------------------------------------
    //-----------------------------CHONSO_API_PARAMS--------------------------------------------------------------------
    public static String api_v2_url = com.ada.common.ConfigProperties.getConfigProperties("api_v2_path", filename);
    public static String api_v2_username = com.ada.common.ConfigProperties.getConfigProperties("api_v2_login_username", filename);
    public static String api_v2_password = com.ada.common.ConfigProperties.getConfigProperties("api_v2_login_pwd", filename);
    public static String api_v2_firebase_token = com.ada.common.ConfigProperties.getConfigProperties("api_v2_login_firebase_token", filename);
    public static String api_v2_device_id = com.ada.common.ConfigProperties.getConfigProperties("api_v2_login_device_id", filename);
    public static String api_v2_guest = com.ada.common.ConfigProperties.getConfigProperties("api_v2_login_user_type", filename);
    //------------------------------------------------------------------------------------------------------------------
    //-----------------------------CHONSO_API_V2_FUNCTION---------------------------------------------------------------
    public static String api_v2_url_login = "/users/login";
    //------------------------------------------------------------------------------------------------------------------
    //-------------------------------------PACKAGE-------------------------
    public static String api_v2_url_package_detail = "/package/detail";

    //-------------------------------------COMMON--------------------------
    public static String api_ctvosp = com.ada.common.ConfigProperties.getConfigProperties("api_ctvosp", filename);
    public static String api_ctvosp_common_place = "/common/place";
    public static String api_ctvosp_login = "/users/login";
    public static String api_ctvosp_balance_his = "/payment/balanceHistory";

    //-----------------------------CTVOSP_API_PARAMS--------------------------------------------------------------------
    public static String api_ctvosp_login_username = com.ada.common.ConfigProperties.getConfigProperties("api_ctvosp_login_username", filename);
    public static String api_ctvosp_login_pwd = com.ada.common.ConfigProperties.getConfigProperties("api_ctvosp_login_pwd", filename);
    public static String api_ctvosp_login_firebase_token = com.ada.common.ConfigProperties.getConfigProperties("api_ctvosp_login_firebase_token", filename);
    public static String api_ctvosp_login_device_id = com.ada.common.ConfigProperties.getConfigProperties("api_ctvosp_login_device_id", filename);
    public static String api_ctvosp_login_user_type = com.ada.common.ConfigProperties.getConfigProperties("api_ctvosp_login_user_type", filename);
    public static String api_ctvosp_login_src_rq = com.ada.common.ConfigProperties.getConfigProperties("api_ctvosp_login_src_rq", filename);

    //-------------------------------------BOOKING-------------------------
    public static String api_v2_url_booking_detail = "/stock/booking/detail";
    //------------------------------------------------------------------------------------------------------------------
    //-------------------------------------MSISDN-------------------------
    public static String api_v2_url_msisdn_detail = "/stock/msisdnDetail";
    //-------------------------------------MSISDN-------------------------
    public static String api_v2_url_common_msisdn_group = "/catalog/searchFilter";

    public static List<Map<String, String>> banners = null;


    public static String md5(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(message.getBytes("UTF-8"));
            // converting byte array to Hexadecimal String
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (UnsupportedEncodingException ex) {
            digest = "";
            // Logger.getLogger(StringReplace.class.getName()).log(Level.SEVERE,
            // null, ex);
        } catch (NoSuchAlgorithmException ex) {
            // Logger.getLogger(StringReplace.class.getName()).log(Level.SEVERE,
            // null, ex);
            digest = "";
        }
        return digest;
    }

    public static String hashMd5Password(String oldPass) {
        String myHash = "";
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(oldPass.getBytes());
            byte[] digest = md.digest();
            myHash = DatatypeConverter.printHexBinary(digest).toLowerCase();
            return myHash;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return myHash;
    }

    public static String Sha256(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(message.getBytes("UTF-8"));

            // converting byte array to Hexadecimal String
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }

            digest = sb.toString();

        } catch (UnsupportedEncodingException ex) {
            digest = "";
            // Logger.getLogger(StringReplace.class.getName()).log(Level.SEVERE,
            // null, ex);
        } catch (NoSuchAlgorithmException ex) {
            // Logger.getLogger(StringReplace.class.getName()).log(Level.SEVERE,
            // null, ex);
            digest = "";
        }
        return digest;
    }

    public static String hmacSHA512(final String key, final String data) {
        try {

            if (key == null || data == null) {
                throw new NullPointerException();
            }
            final Mac hmac512 = Mac.getInstance("HmacSHA512");
            byte[] hmacKeyBytes = key.getBytes();
            final SecretKeySpec secretKey = new SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            hmac512.init(secretKey);
            byte[] dataBytes = data.getBytes(StandardCharsets.UTF_8);
            byte[] result = hmac512.doFinal(dataBytes);
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();

        } catch (Exception ex) {
            return "";
        }
    }

    //Util for VNPAY
    public static String hashAllFields(Map fields) {
        // create a list and sort it
        List fieldNames = new ArrayList(fields.keySet());
        Collections.sort(fieldNames);
        // create a buffer for the md5 input and add the secure secret first
        StringBuilder sb = new StringBuilder();

        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                sb.append(fieldName);
                sb.append("=");
                sb.append(fieldValue);
            }
            if (itr.hasNext()) {
                sb.append("&");
            }
        }
        return hmacSHA512(vnp_HashSecret, sb.toString());
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAdress;
        try {
            ipAdress = request.getHeader("X-FORWARDED-FOR");
            if (ipAdress == null) {
                ipAdress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAdress = "Invalid IP:" + e.getMessage();
        }
        return ipAdress;
    }

    public static String getRandomNumber(int len) {
        Random rnd = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        System.out.println("dsdsdddddđ");
    }
}
