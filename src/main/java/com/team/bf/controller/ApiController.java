package com.team.bf.controller;

import javax.inject.Inject;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.team.bf.service.OpenApiService;

@RestController
public class ApiController {
	
    @Value("${open-api.myKey}")
    private String myKey;
    
    @Inject
    OpenApiService openApiService;
    
    @PostMapping("/api/detailIntro")
    public JSONObject getDetailIntro(String contentid) {
    	return openApiService.detailIntro(myKey, contentid);
    }
    
}
