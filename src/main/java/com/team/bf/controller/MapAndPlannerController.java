package com.team.bf.controller;

import java.util.List;

import javax.inject.Inject;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.bf.service.HeartService;
import com.team.bf.service.LikeService;
import com.team.bf.service.OpenApiService;
import com.team.bf.service.ReviewService;

@RestController
public class MapAndPlannerController {
	private String areaCode = "39";
	@Inject
	OpenApiService openApiService;
	@Inject
	LikeService likeService;
	@Inject
	HeartService heartService;
	@Inject
	ReviewService reviewService;
	
    @GetMapping("/planView")
    public ModelAndView planView(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("plan/planView");
        return mav;
    }

    @GetMapping("/mapView")
    public ModelAndView mapView(@RequestParam(value = "pageNo", required = false, defaultValue = "1")String pageNo, @RequestParam(value = "pageCount",required = false,  defaultValue = "3")String pageCount, @RequestParam(value = "searchWord",required = false,  defaultValue = "")String searchWord){
        ModelAndView mav = new ModelAndView();
        List<JSONObject> tourList = openApiService.searchKeyword(pageNo, pageCount, "all", searchWord);
        
        for(JSONObject jObj : tourList) {
        	JSONObject Opt = openApiService.detailCommon(jObj.get("contentid").toString(),areaCode);
        	String cid = jObj.get("contentid").toString();
        	jObj.put("title",Opt.get("title").toString());
        	jObj.put("overview",Opt.get("overview").toString());
        	jObj.put("firstimage",Opt.get("firstimage").toString());
        	jObj.put("firstimage2",Opt.get("firstimage2").toString());
        	jObj.put("homepage", Opt.get("homepage").toString());
        	jObj.put("likeCount", likeService.likeSelectAll(cid));
        	jObj.put("heartCount", heartService.heartSelectAll(cid));
        	jObj.put("reviewCount", reviewService.reviewSelectByContentid(cid));
        
        	Float avgScore = reviewService.reviewSelectAvgScore(cid); 	
        	if(avgScore == null)
        		jObj.put("avgScore", "0");
        	else 
        		jObj.put("avgScore", String.format("%.2f",avgScore));
        }
        mav.addObject("tourList", tourList);
        mav.setViewName("map/mapView");
        return mav;
    }
    
    @GetMapping("/api/test/detailCommon")
    public String apiTest(@RequestParam(value="contentid")String contentid) {
    	JSONObject Opt = openApiService.detailCommon(contentid, areaCode);
    	return Opt.toString();
    }

    @GetMapping("/mypage/myplan")
    public ModelAndView myPlanView(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mypage/myplan");
        return mav;
    }
}
