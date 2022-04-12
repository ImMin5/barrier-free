package com.team.bf.controller;

import javax.inject.Inject;

import com.team.bf.service.OpenApiService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
        System.out.println("pagNO "+ pageNo);
        mav.addObject("accomoList", openApiService.searchKeyword(pageNo, pageCount, "32",searchWord));
        mav.setViewName("accommodation/accommodationPage");
        return mav;
    }
    
    @GetMapping("/accommodation/{contentid}")
    public ModelAndView accomodationInfo(@PathVariable("contentid") String contentid) {
    	ModelAndView mav = new ModelAndView();
    	System.out.println("ddd");
    	mav.addObject("vo", openApiService.detailIntro(contentid, "32"));
    	mav.setViewName("accommodation/accommodationPageView");
    	return mav;
    }
}
