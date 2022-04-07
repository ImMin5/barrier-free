package com.team.bf.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class BoardController {
    
    @GetMapping("/board/boardList")
    public ModelAndView boardView(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("community/board");
        return mav;
    }
}
