package com.team.bf.controller;

import javax.inject.Inject;

import com.team.bf.service.OpenApiService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class AccommodationController {
    @Inject
    OpenApiService openApiService;

    @GetMapping("/accommodation")
    public ModelAndView main(@RequestParam(value = "pageNo", required = false, defaultValue = "1")String pageNo, @RequestParam(value = "pageCount",required = false,  defaultValue = "10")String pageCount, @RequestParam(value = "searchWord",required = false,  defaultValue = "")String searchWord){
        ModelAndView mav = new ModelAndView();
        System.out.println("pagNO "+ pageNo);
        
        //System.out.println(openApiService.detailIntro("", searchWord))
        mav.addObject("accomoList", openApiService.TourTypeInfo(pageNo, pageCount, "32",searchWord));
        mav.setViewName("accommodation/accommodationPage");
        return mav;
    }
}
