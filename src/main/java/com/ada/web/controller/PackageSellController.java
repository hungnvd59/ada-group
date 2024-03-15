package com.ada.web.controller;

import com.ada.web.service.chonsoApi.AffPackageDetailRequest;
import com.ada.web.service.chonsoApi.AffPackageDetailResponse;
import com.ada.web.service.chonsoApi.PackageApiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/goi-cuoc")
public class PackageSellController {

    //    @Autowired
//    private PackageSellService packageSellService;
    @Autowired
    private PackageApiService packageApiService;


    @RequestMapping(value = "/detail", method = RequestMethod.POST)
    public ResponseEntity<AffPackageDetailResponse> getDetail(@RequestBody AffPackageDetailRequest request, HttpServletRequest rq) {
        if (request == null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        if (request.getPckCode() == null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        AffPackageDetailResponse response = null;
        try {
            String token = null;
            response = packageApiService.getPackageDetail(request, token);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

}
