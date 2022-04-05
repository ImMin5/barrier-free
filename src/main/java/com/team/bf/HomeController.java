package com.team.bf;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home(){
        System.out.println("ekekek");
        return "home";
    }
}
