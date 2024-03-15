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
public class PackageApiService {
    private Gson gson = new Gson();
    private static final Logger logger = LoggerFactory.getLogger(PackageApiService.class);

    @Autowired
    private APIService apiService;

    public AffPackageDetailResponse getPackageDetail(AffPackageDetailRequest request, String token) {
        AffPackageDetailResponse response = null;
        try {
            String result = apiService.callAPI(Config.api_v2_url_package_detail, new HashMap<>(), gson.toJson(request), token);

            if (result != null && !result.trim().equals("")) {
                response = gson.fromJson(result, AffPackageDetailResponse.class);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }

}
