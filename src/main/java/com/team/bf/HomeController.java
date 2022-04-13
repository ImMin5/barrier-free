package com.team.bf;

import java.util.ArrayList;

import javax.inject.Inject;

import com.team.bf.service.OpenApiService;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HomeController {
    @Inject
    OpenApiService openApiService;
    @GetMapping("/")
    public ModelAndView home(){
        ModelAndView mav = new ModelAndView();
        System.out.println("ddd");
        mav.setViewName("home");
        return mav;
    }

    @GetMapping("/intro")
    public ModelAndView intro(){
    	 ModelAndView mav = new ModelAndView();
    	 mav.setViewName("introduction");
        return mav;
    }
}
