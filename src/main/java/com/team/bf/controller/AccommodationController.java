package com.team.bf.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.team.bf.service.HeartService;
import com.team.bf.service.LikeService;
import com.team.bf.service.OpenApiService;
import com.team.bf.service.ReviewService;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class AccommodationController {
    @Inject
    OpenApiService openApiService;
    @Inject 
    LikeService likeService;
    @Inject
    HeartService heartService;
    @Inject
    ReviewService reviewService;
    
    private String areaCode = "39";//제주도
    
    //숙박정보 리스트 뷰
    @GetMapping("/accommodation")
    public ModelAndView accomodationList(@RequestParam(value = "pageNo", required = false, defaultValue = "1")String pageNo, @RequestParam(value = "pageCount",required = false,  defaultValue = "2")String pageCount, @RequestParam(value = "searchWord",required = false,  defaultValue = "")String searchWord){
        ModelAndView mav = new ModelAndView();
        try {
	        List<JSONObject> accomoList = openApiService.searchKeyword(pageNo, pageCount, "32" , searchWord); //숙박정보 32 
	        
	        for(JSONObject jObj : accomoList) {
	        	JSONObject Opt = openApiService.detailCommon(jObj.get("contentid").toString(),areaCode);
	        	String cid = jObj.get("contentid").toString();
	        	jObj.put("title",Opt.get("title").toString());
	        	jObj.put("overview",Opt.get("overview").toString());
	        	jObj.put("firstimage",Opt.get("firstimage").toString());
	        	jObj.put("firstimage2",Opt.get("firstimage2").toString());
	        	if(Opt.has("homepage"))
	        		jObj.put("homepage", Opt.get("homepage").toString());
	        	else
	        		jObj.put("homepage", "");
	        	jObj.put("likeCount", likeService.likeSelectAll(cid));
	        	jObj.put("heartCount", heartService.heartSelectAll(cid));
	        	jObj.put("reviewCount", reviewService.reviewSelectByContentid(cid).size());
	        	
	        	Float avgScore = reviewService.reviewSelectAvgScore(cid); 	
	        	if(avgScore == null)
	        		jObj.put("avgScore", "0");
	        	else 
	        		jObj.put("avgScore", String.format("%.2f",avgScore));
	        }
	        mav.addObject("areaList",openApiService.AreaInfo()); //남제주군,  북제주군 , 서귀포시 , 제주시
	        mav.addObject("accommoList", openApiService.searchKeyword(pageNo, pageCount, "32",searchWord));
        }catch(Exception e) {
        	e.printStackTrace();
        }
        mav.setViewName("accommodation/accommodationPage");
        return mav;
    }
    
    //숙박 상세 정보 요청
    @GetMapping("/accommodation/{contentid}")
    public ModelAndView accomodationInfo(@PathVariable("contentid") String contentid) {
    	ModelAndView mav = new ModelAndView();
    	JSONObject jObj = null;
    	try{
    		JSONObject Opt = openApiService.detailWithTour(contentid);
    		jObj = openApiService.detailCommon(contentid,"32");
    		//데이터 추가
    		jObj.put("route",Opt.has("route")? "1" : "0");
    		jObj.put("parking",Opt.has("parking")? "1" : "0");
    		jObj.put("publictransport",Opt.has("publictransport")? "1" : "0");
    		jObj.put("wheelchair",Opt.has("wheelchair")? "1" : "0");
    		jObj.put("exit",Opt.has("exit")? "1" : "0");
    		jObj.put("elevator",Opt.has("elevator")? "1" : "0");
    		jObj.put("restroom",Opt.has("restroom")? "1" : "0");
    		jObj.put("braileblock",Opt.has("braileblock")? "1" : "0");
    		jObj.put("helpdog",Opt.has("helpdog")? "1" : "0");
    		jObj.put("guidehuman",Opt.has("guidehuman")? "1" : "0");
    		jObj.put("audioguide",Opt.has("audioguide")? "1" : "0");
    		jObj.put("brailepromotion",Opt.has("brailepromotion")? "1" : "0");
    		jObj.put("likeCount", likeService.likeSelectAll(contentid)); //좋아요 숫자
    		jObj.put("heartCount", heartService.heartSelectAll(contentid)); //찜 숫자
    		jObj.put("reviewCount", reviewService.reviewSelectByContentid(contentid).size());//리뷰 숫자
    		Float avgScore = reviewService.reviewSelectAvgScore(contentid);    
            if(avgScore == null)
               jObj.put("avgScore", "0");
            else 
            	jObj.put("avgScore", String.format("%.2f",avgScore));
    		
            mav.addObject("reviewList", reviewService.reviewSelectByContentid(contentid));
    		mav.addObject("acvo",jObj);
    		mav.setViewName("/accommodation/accommodationView");
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return mav;
    }
}
