package com.team.bf.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class MapAndPlannerController {
    
    @GetMapping("/planView")
    public ModelAndView planView(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("map/plan");
        return mav;
    }

    @GetMapping("/mapView")
    public ModelAndView mapView(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("plan/plan");
        return mav;
    }

    @GetMapping("/mypage/myplan")
    public ModelAndView myPlanView(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mypage/myplan");
        return mav;
    }
}
