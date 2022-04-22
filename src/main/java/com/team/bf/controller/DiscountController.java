package com.team.bf.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class DiscountController {
    
    @GetMapping("discountView")
    public ModelAndView discountView(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("discount/discountView");
        return mav;
    }
    
    @GetMapping("discountDetailView")
    public ModelAndView discountDetailView(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("discount/discountDetailView");
        return mav;
    }
}
