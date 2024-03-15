package com.ada.web.service.chonsoApi;

import com.google.gson.Gson;
import com.ada.common.Config;
import com.ada.web.service.APIService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class MsisdnApiService {
    private Gson gson = new Gson();
    private static final Logger logger = LoggerFactory.getLogger(PackageApiService.class);

    @Autowired
    private APIService apiService;

    public MsisdnDetailResponse detail(MsisdnDetailRequest request, String token) {
        MsisdnDetailResponse response = null;
        try {
            String result = apiService.callAPI(Config.api_v2_url_msisdn_detail, new HashMap<>(), gson.toJson(request), token);
            if (result != null && !result.equals("")) {
                response = gson.fromJson(result, MsisdnDetailResponse.class);
            }

        } catch (Exception e) {
            logger.error(String.format("Get DETAIL_MSISDN-ERROR: %s", e.getMessage()));
        }
        return response;
    }

    public GroupMsisdnResponse groupMsisdn(GroupMsisdnRequest request, String token) {
        GroupMsisdnResponse response = null;
        try {
            String result = apiService.callAPI(Config.api_v2_url_common_msisdn_group, new HashMap<>(), gson.toJson(request), token);
            if (result != null && !result.equals("")) {
                response = gson.fromJson(result, GroupMsisdnResponse.class);
            }
        } catch (Exception e) {
            logger.error("UNLOCK_MSISDN-ERROR: %s", e.getMessage());
        }
        return response;
    }

}
