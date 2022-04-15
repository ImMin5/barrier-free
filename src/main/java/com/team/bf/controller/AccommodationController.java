package com.team.bf.controller;

import javax.inject.Inject;

import com.team.bf.service.OpenApiService;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class AccommodationController {
    @Inject
    OpenApiService openApiService;

    @GetMapping("/accommodation")
    public ModelAndView accomodationList(@RequestParam(value = "pageNo", required = false, defaultValue = "1")String pageNo, @RequestParam(value = "pageCount",required = false,  defaultValue = "10")String pageCount, @RequestParam(value = "searchWord",required = false,  defaultValue = "")String searchWord){
        ModelAndView mav = new ModelAndView();
        mav.addObject("areaList",openApiService.AreaInfo()); //남제주군,  북제주군 , 서귀포시 , 제주시
        mav.addObject("accomoList", openApiService.searchKeyword(pageNo, pageCount, "32",searchWord));
        mav.setViewName("accommodation/accommodationPage");
        return mav;
    }
    
    //숙박 상세 정보 요청
    @GetMapping("/accommodation/{contentid}")
    public String accomodationInfo(@PathVariable("contentid") String contentid) {
    	return openApiService.detailIntro(contentid,"32").toString();
    }
}
