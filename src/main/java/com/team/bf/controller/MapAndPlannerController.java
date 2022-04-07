package com.team.bf.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class MapAndPlannerController {
    
    @GetMapping("/plan")
    public ModelAndView planView(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("map/plan");
        return mav;
    }
}
