package com.ada.web.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ada.common.Config;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@Service
public class APIService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public static HttpClient httpClient = null;
    private static String tokenString = null;
    private static long timeTokenAlive = 0;

    public APIService() {

        //            sf = new EasySSLProtocolSocketFactory();
//            Protocol p = new Protocol("https", sf, 443);
//            Protocol.registerProtocol("https", p);
        if (httpClient == null) {
            httpClient = getDefaultHttpClient();
        }
//        } catch (GeneralSecurityException e) {
//            e.printStackTrace();

    }

    public String getToken() {
        if (tokenString == null || timeTokenAlive > System.currentTimeMillis()) {
            return authenticate();
        }
        return tokenString;
    }

    public String getTokenCtvOsp() {
        if (tokenString == null || timeTokenAlive > System.currentTimeMillis()) {
            return authCtvOsp();
        }
        return tokenString;
    }

    private String authenticate() {

        String response = null;
        PostMethod method = new PostMethod(Config.api_v2_url + Config.api_v2_url_login);
        method.addRequestHeader("Accept", "*/*");
        method.addRequestHeader("Content-Type", "application/json");
//		method.setRequestHeader(HttpHeaders.AUTHORIZATION, response);
        method.getParams().setContentCharset("utf-8");

        Gson gson = new Gson();

//		String JSON_String = "{\n"
//				+ "    \"username\" : \"admin\",\n"
//				+ "    \"password\" : \"12345678\"\n"
//				+ "}";
        String JSON_String = "{\n" +
                "    \"username\": \"" + Config.api_v2_username + "\",\n" +
                "    \"password\": \"" + Config.api_v2_password + "\",\n" +
                "    \"firebaseToken\": \"" + Config.api_v2_firebase_token + "\",\n" +
                "    \"deviceId\": \"" + Config.api_v2_device_id + "\",\n" +
                "    \"userType\": \"" + Config.api_v2_guest + "\",\n" +
                "    \"appProductKey\":\"" + Config.api_v2_device_id + "\",\n" +
                "    \"appVersion\":\"" + Config.api_v2_device_id + "\"\n" +
                "}";

        StringRequestEntity requestEntity;
        try {
            requestEntity = new StringRequestEntity(JSON_String, "application/json", "UTF-8");
            method.setRequestEntity(requestEntity);

            int status = httpClient.executeMethod(method);
            if (status == 200) {
                response = method.getResponseBodyAsString();
                response = (response != null) ? response.trim() : response;

                JsonElement jelement = new JsonParser().parse(response);
                JsonObject jobject = jelement.getAsJsonObject();
                if (jobject.get("code") != null && jobject.get("code").getAsInt() == 1) {
                    jelement = jobject.get("data");
                    jobject = jelement.getAsJsonObject();

                    jelement = jobject.get("accessTokenInfo");
                    jobject = jelement.getAsJsonObject();

                    return jobject.get("accessToken").getAsString();
                } else {
                    return null;
                }

            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private String authCtvOsp() {

        String response = null;
        PostMethod method = new PostMethod(Config.api_ctvosp + Config.api_ctvosp_login);
        method.addRequestHeader("Accept", "*/*");
        method.addRequestHeader("Content-Type", "application/json");
//		method.setRequestHeader(HttpHeaders.AUTHORIZATION, response);
        method.getParams().setContentCharset("utf-8");
        Gson gson = new Gson();
        String JSON_String = "{\n" +
                "    \"username\": \"" + Config.api_ctvosp_login_username + "\",\n" +
                "    \"password\": \"" + Config.api_ctvosp_login_pwd + "\",\n" +
                "    \"firebaseToken\": \"" + Config.api_ctvosp_login_firebase_token + "\",\n" +
                "    \"deviceId\": \"" + Config.api_ctvosp_login_device_id + "\",\n" +
                "    \"userType\": \"" + Config.api_ctvosp_login_user_type + "\",\n" +
                "    \"srcRq\":\"" + Config.api_ctvosp_login_src_rq + "\"\n" +
                "}";

        StringRequestEntity requestEntity;
        try {
            requestEntity = new StringRequestEntity(JSON_String, "application/json", "UTF-8");
            method.setRequestEntity(requestEntity);

            int status = httpClient.executeMethod(method);
            if (status == 200) {
                response = method.getResponseBodyAsString();
                response = (response != null) ? response.trim() : response;

                JsonElement jelement = new JsonParser().parse(response);
                JsonObject jobject = jelement.getAsJsonObject();
                if (jobject.get("code") != null && jobject.get("code").getAsInt() == 1) {
                    jelement = jobject.get("data");
                    jobject = jelement.getAsJsonObject();

                    jelement = jobject.get("accessTokenInfo");
                    jobject = jelement.getAsJsonObject();

                    return jobject.get("accessToken").getAsString();
                } else {
                    return null;
                }

            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public String callAPI(String functionName, HashMap<String, String> headerParam, String jsonInput, String token) {
        try {
            System.out.println("========= Call API ===========:" + functionName);
            System.out.println("==== jsonInput ===:" + jsonInput);
            String response = null;
            PostMethod method = new PostMethod(Config.api_v2_url + functionName);
            if (token != null) {
                headerParam.put("Authorization", "Bearer " + token);
//				Đặt token null là chưa đăng nhập
            } else {
                headerParam.put("Authorization", "Bearer " + getToken());
            }
            headerParam.put("Accept", "application/json");
            headerParam.put("Content-Type", "application/json");
            for (Map.Entry<String, String> hdParam : headerParam.entrySet()) {
                method.addRequestHeader(hdParam.getKey(), hdParam.getValue());
            }
            method.getParams().setContentCharset("utf-8");
            StringRequestEntity requestEntity;
            requestEntity = new StringRequestEntity(jsonInput, "application/json", "UTF-8");
            method.setRequestEntity(requestEntity);
            int status = httpClient.executeMethod(method);
//			System.out.println("callAPI: "+functionName+", status : " + status +", ResponseBody " + method.getResponseBodyAsString());
            if (status == 200) {
                response = method.getResponseBodyAsString();
                response = (response != null) ? response.trim() : response;
                System.out.println("==== response ====:" + response);
                System.out.println("========= End Call API ===========");
                return response;
            } else {
                return null;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public String callAPICtv(String functionName, HashMap<String, String> headerParam, String jsonInput, String token) {
        try {
            System.out.println("========= Call API ===========:" + functionName);
            String response = null;
            PostMethod method = new PostMethod(Config.api_ctvosp + functionName);
            if (token != null) {
                headerParam.put("Authorization", "Bearer " + token);
//				Đặt token null là chưa đăng nhập
            } else {
                headerParam.put("Authorization", "Bearer " + getTokenCtvOsp());
            }
            headerParam.put("Accept", "application/json");
            headerParam.put("Content-Type", "application/json");
            for (Map.Entry<String, String> hdParam : headerParam.entrySet()) {
                method.addRequestHeader(hdParam.getKey(), hdParam.getValue());
            }
            method.getParams().setContentCharset("utf-8");
            StringRequestEntity requestEntity;
            requestEntity = new StringRequestEntity(jsonInput, "application/json", "UTF-8");
            method.setRequestEntity(requestEntity);
            int status = httpClient.executeMethod(method);
//			System.out.println("callAPI: "+functionName+", status : " + status +", ResponseBody " + method.getResponseBodyAsString());
            if (status == 200) {
                response = method.getResponseBodyAsString();
                response = (response != null) ? response.trim() : response;
                System.out.println("========= End Call API ===========");
                return response;
            } else {
                return null;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public String callAPI(String functionName, HashMap<String, String> headerParam, String jsonInput, HttpMethod methodStr, String token) {
        try {
            System.out.println("========= Call API ===========:" + functionName);
            System.out.println("==== jsonInput ===:" + jsonInput);
            String response = null;

            if (token != null) {
                headerParam.put("Authorization", "Bearer " + token);
//				Đặt token null là chưa đăng nhập
            } else {
                headerParam.put("Authorization", "Bearer " + getToken());
            }
            headerParam.put("Accept", "application/json");
            headerParam.put("Content-Type", "application/json");

            if (methodStr.equals(HttpMethod.POST)) {
                PostMethod method = new PostMethod(functionName);
                for (Map.Entry<String, String> hdParam : headerParam.entrySet()) {
                    method.addRequestHeader(hdParam.getKey(), hdParam.getValue());
                }
                method.getParams().setContentCharset("utf-8");
                StringRequestEntity requestEntity;
                requestEntity = new StringRequestEntity(jsonInput, "application/json", "UTF-8");
                method.setRequestEntity(requestEntity);
                int status = httpClient.executeMethod(method);
//                System.out.println("Status response: " + String.valueOf(status));
                logger.info("callAPI: " + functionName + ", status : " + status + ", ResponseBody " + method.getResponseBodyAsString());
                if (status == 200) {
                    response = method.getResponseBodyAsString();
                    response = (response != null) ? response.trim() : response;
//                    System.out.println("==== response ====:" + response);
                    return response;
                } else {
                    return null;
                }
            } else if (methodStr.equals(HttpMethod.GET)) {
                GetMethod method = new GetMethod(functionName);
//                headerParam.put("Authorization", "Bearer " + getToken());
//                headerParam.put("Accept", "application/json");
//                headerParam.put("Content-Type", "application/json");
                for (Map.Entry<String, String> hdParam : headerParam.entrySet()) {
                    method.addRequestHeader(hdParam.getKey(), hdParam.getValue());
                }
                method.getParams().setContentCharset("utf-8");

//                List<NameValuePair> valuePairs = new ArrayList<>();
                String param = "";

                if (jsonInput != null && !jsonInput.trim().equals("")) {
                    Map<String, String> inputs = new ObjectMapper().readValue(jsonInput, HashMap.class);

                    for (Map.Entry<String, String> input : inputs.entrySet()) {

                        if (param != null && param.trim().equals("")) {
                            param += String.format("?");
                        } else if (param != null && !param.trim().equals("")) {
                            param += String.format("&");
                        }

                        param += String.format("%s=%s", input.getKey(), URLEncoder.encode(String.valueOf(input.getValue()), "utf-8"));

                    }
                }
//                System.out.println(param);
                method.setQueryString(param);

                int status = httpClient.executeMethod(method);

                logger.info("callAPI: " + functionName + ", status : " + status + ", ResponseBody " + method.getResponseBodyAsString());
                if (status == 200) {
                    response = method.getResponseBodyAsString();
                    response = (response != null) ? response.trim() : response;
//                    System.out.println("==== response ====:" + response);
                    return response;
                } else {
                    return null;
                }
            }
//			System.out.println("callAPI: "+functionName+", status : " + status +", ResponseBody " + method.getResponseBodyAsString());
        } catch (Exception e) {
//            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public String callAPI(String functionName, HashMap<String, String> headerParam, String jsonInput, HttpMethod methodStr) {
        try {
            System.out.println("========= Call API ===========:" + functionName);
            System.out.println("==== jsonInput ===:" + jsonInput);
            String response = null;

            if (methodStr.equals(HttpMethod.POST)) {
                PostMethod method = new PostMethod(functionName);
                for (Map.Entry<String, String> hdParam : headerParam.entrySet()) {
                    method.addRequestHeader(hdParam.getKey(), hdParam.getValue());
                }
                method.getParams().setContentCharset("utf-8");
                StringRequestEntity requestEntity;
                requestEntity = new StringRequestEntity(jsonInput, "application/json", "UTF-8");
                method.setRequestEntity(requestEntity);
                int status = httpClient.executeMethod(method);
//                System.out.println("Status response: " + String.valueOf(status));
                logger.info("callAPI: " + functionName + ", status : " + status + ", ResponseBody " + method.getResponseBodyAsString());
                if (status == 200) {
                    response = method.getResponseBodyAsString();
                    response = (response != null) ? response.trim() : response;
                    System.out.println("==== response ====:" + response);
                    return response;
                } else {
                    return null;
                }
            } else if (methodStr.equals(HttpMethod.GET)) {
                GetMethod method = new GetMethod(functionName);
//                headerParam.put("Authorization", "Bearer " + getToken());
//                headerParam.put("Accept", "application/json");
//                headerParam.put("Content-Type", "application/json");
                for (Map.Entry<String, String> hdParam : headerParam.entrySet()) {
                    method.addRequestHeader(hdParam.getKey(), hdParam.getValue());
                }
                method.getParams().setContentCharset("utf-8");

//                List<NameValuePair> valuePairs = new ArrayList<>();
                String param = "";

                if (jsonInput != null && !jsonInput.trim().equals("")) {
                    Map<String, String> inputs = new ObjectMapper().readValue(jsonInput, HashMap.class);

                    for (Map.Entry<String, String> input : inputs.entrySet()) {

                        if (param != null && param.trim().equals("")) {
                            param += String.format("?");
                        } else if (param != null && !param.trim().equals("")) {
                            param += String.format("&");
                        }

                        param += String.format("%s=%s", input.getKey(), URLEncoder.encode(String.valueOf(input.getValue()), "utf-8"));

                    }
                }
//                System.out.println(param);
                method.setQueryString(param);

                int status = httpClient.executeMethod(method);

                logger.info("callAPI: " + functionName + ", status : " + status + ", ResponseBody " + method.getResponseBodyAsString());
                if (status == 200) {
                    response = method.getResponseBodyAsString();
                    response = (response != null) ? response.trim() : response;
//                    System.out.println("==== response ====:" + response);
                    return response;
                } else {
                    return null;
                }
            }
//			System.out.println("callAPI: "+functionName+", status : " + status +", ResponseBody " + method.getResponseBodyAsString());
        } catch (Exception e) {
//            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public String callAPI(String functionName, HashMap<String, String> headerParam, String jsonInput) {
        try {
            System.out.println("========= Call API ===========:" + functionName);
            System.out.println("==== jsonInput ===:" + jsonInput);
            String response = null;
            PostMethod method = new PostMethod(Config.api_v2_url + functionName);
            headerParam.put("Authorization", "Bearer " + getToken());
            headerParam.put("Accept", "application/json");
            headerParam.put("Content-Type", "application/json");
            for (Map.Entry<String, String> hdParam : headerParam.entrySet()) {
                method.addRequestHeader(hdParam.getKey(), hdParam.getValue());
            }
            method.getParams().setContentCharset("utf-8");
            StringRequestEntity requestEntity;
            requestEntity = new StringRequestEntity(jsonInput, "application/json", "UTF-8");
            method.setRequestEntity(requestEntity);
            int status = httpClient.executeMethod(method);
//			System.out.println("callAPI: "+functionName+", status : " + status +", ResponseBody " + method.getResponseBodyAsString());
            if (status == 200) {
                response = method.getResponseBodyAsString();
                response = (response != null) ? response.trim() : response;
                System.out.println("==== response ====:" + response);
                System.out.println("========= End Call API ===========");
                return response;
            } else {
                return null;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public static HttpClient getDefaultHttpClient() {
        HttpConnectionManagerParams params = new HttpConnectionManagerParams();
        params.setSoTimeout(120 * 1000);
        params.setConnectionTimeout(90 * 1000);
        params.setMaxTotalConnections(200);
        params.setDefaultMaxConnectionsPerHost(200);
        //create client pool
        MultiThreadedHttpConnectionManager connectionManager = new MultiThreadedHttpConnectionManager();
        connectionManager.setParams(params);

        return new HttpClient(connectionManager);
    }

}
