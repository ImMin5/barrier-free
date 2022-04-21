package com.team.bf.controller;

import java.util.List;

import javax.inject.Inject;

import com.team.bf.service.HeartService;
import com.team.bf.service.LikeService;
import com.team.bf.service.OpenApiService;
import com.team.bf.service.ReviewService;
import com.team.bf.vo.ReviewVO;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class TourLocationController {
    @Inject
    OpenApiService openApiService;
    @Inject 
    LikeService likeService;
    @Inject
    HeartService heartService;
    @Inject
    ReviewService reviewService;
    
    private String areaCode = "39";//제주도
    //여행지 정보 리스트 뷰
    @GetMapping("/travel_information")
    public ModelAndView travelInfo(@RequestParam(value = "contentTypeId", 
    required = false, defaultValue = "12")String contentTypeId, 
    		@RequestParam(value = "pageNo", required = false, defaultValue = "1")String pageNo, 
    		@RequestParam(value = "pageCount", required = false, defaultValue = "5")String pageCount, 
    		@RequestParam(value = "searchWord", required = false, defaultValue = "")String searchWord,
    		@RequestParam(value = "sigunguCode",required = false,  defaultValue = "")String sigunguCode){
        
    	ModelAndView mav = new ModelAndView();
        List<JSONObject> tourList = openApiService.searchKeyword(pageNo, pageCount,contentTypeId,searchWord,sigunguCode);
        for(JSONObject jObj : tourList) {
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
        	ReviewVO rvo = reviewService.reviewSelectOneByContentid(searchWord);
        	//점수가 가장 높은 대표 리뷰 선정
        	if(rvo != null) {
        		jObj.put("thumbnailReviewTitle", rvo.getTitle());
	        	jObj.put("thumbnailReviewScore", rvo.getScore());
	        	jObj.put("thumbnailReviewScore", rvo.getContent());
        	}
        }
        mav.addObject("areaList",openApiService.AreaInfo()); //남제주군,  북제주군 , 서귀포시 , 제주시
        mav.addObject("tourList", tourList); //12,14,15,38
        mav.setViewName("travel_information/travel_informationPage");
        return mav;
    }
    
    //여행지 상세 정보 뷰
    @GetMapping("/travel_information/{contentid}")
    public ModelAndView travelInfoDetail(@PathVariable("contentid") String contentid) {
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
    		mav.setViewName("travel_information/travel_informationView");
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return mav;
    }
}
