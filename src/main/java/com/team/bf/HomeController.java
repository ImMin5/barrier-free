package com.team.bf;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import com.team.bf.service.HeartService;
import com.team.bf.service.LikeService;
import com.team.bf.service.OpenApiService;
import com.team.bf.service.ReviewService;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HomeController {
    @Inject
    OpenApiService openApiService;
    
    @Inject
    LikeService likeService;
    
    @Inject
    HeartService heartService;
    
    @Inject 
    ReviewService reviewService;
    @GetMapping("/")
    public ModelAndView home(){
        ModelAndView mav = new ModelAndView();
        JSONArray accomoList = openApiService.searchKeyword2("1", "6","32","");
        JSONArray tourList = openApiService.searchKeyword2("1", "3","12","");
        List<JSONObject> acList = new ArrayList<JSONObject>();
        List<JSONObject> tList = new ArrayList<JSONObject>();
        
        for(int i=0; i<accomoList.length(); i++){
        	 String cid = accomoList.getJSONObject(i).get("contentid").toString();
        	 accomoList.getJSONObject(i).put("likeCount", likeService.likeSelectAll(cid));
        	 accomoList.getJSONObject(i).put("heartCount", heartService.heartSelectAll(cid));
        	 accomoList.getJSONObject(i).put("reviewCount", reviewService.reviewSelectByContentid(cid).size());
             Float avgScore = reviewService.reviewSelectAvgScore(cid);    
             if(avgScore == null)
            	 accomoList.getJSONObject(i).put("avgScore", "0");
             else 
            	 accomoList.getJSONObject(i).put("avgScore", String.format("%.2f",avgScore));
             acList.add(accomoList.getJSONObject(i));
        }
        
        for(int i=0; i<tourList.length(); i++){
        	String cid = tourList.getJSONObject(i).get("contentid").toString();
	       	tourList.getJSONObject(i).put("likeCount", likeService.likeSelectAll(cid));
	       	tourList.getJSONObject(i).put("heartCount", heartService.heartSelectAll(cid));
	       	tourList.getJSONObject(i).put("reviewCount", reviewService.reviewSelectByContentid(cid).size());
            Float avgScore = reviewService.reviewSelectAvgScore(cid);    
            if(avgScore == null)
            	tourList.getJSONObject(i).put("avgScore", "0");
            else 
            	tourList.getJSONObject(i).put("avgScore", String.format("%.2f",avgScore));
            tList.add(tourList.getJSONObject(i));
        }
        mav.addObject("accomoList", acList);
        mav.addObject("tourList", tList);
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
