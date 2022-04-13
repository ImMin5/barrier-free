package com.team.bf.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ApiController {
    
    @Value("${open-api.myKey}")
    private String myKey;
    
}
