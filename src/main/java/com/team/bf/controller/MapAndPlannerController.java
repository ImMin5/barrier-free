package com.team.bf.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.bf.service.OpenApiService;

@RestController
public class MapAndPlannerController {
	@Inject
	OpenApiService openApiService;
	
    @GetMapping("/planView")
    public ModelAndView planView(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("plan/planView");
        return mav;
    }

    @GetMapping("/mapView")
    public ModelAndView mapView(String pageNo, String pageCount, String contentTypeId, String searchWord){
        ModelAndView mav = new ModelAndView();
        mav.addObject("tourList", openApiService.searchKeyword(pageNo, pageCount, "all", searchWord));
        mav.setViewName("map/mapView");
        return mav;
    }

    @GetMapping("/mypage/myplan")
    public ModelAndView myPlanView(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mypage/myplan");
        return mav;
    }
}
