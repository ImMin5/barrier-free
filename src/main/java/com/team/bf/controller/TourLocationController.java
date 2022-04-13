package com.team.bf.controller;

import javax.inject.Inject;

import com.team.bf.service.OpenApiService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class TourLocationController {
    @Inject
    OpenApiService openApiService;

    @GetMapping("/travel_information")
    public ModelAndView main(@RequestParam(value = "pageNo")String pageNo, @RequestParam(value = "pageCount")String pageCount, @RequestParam(value = "searchWord")String searchWord){
        ModelAndView mav = new ModelAndView();
        
        mav.addObject("tourList", openApiService.TourTypeInfo(pageNo, pageCount, "12",searchWord));
        mav.setViewName("");
        return mav;
    }
}
