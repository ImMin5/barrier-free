package com.team.bf.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.bf.service.HeartService;
import com.team.bf.service.LikeService;
import com.team.bf.service.OpenApiService;
import com.team.bf.service.PlannerService;
import com.team.bf.service.ReviewService;
import com.team.bf.vo.PlannerLocationVO;
import com.team.bf.vo.PlannerVO;

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
	@Inject
	PlannerService plannerService;
	
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
        	jObj.put("reviewCount", reviewService.reviewSelectByContentid(cid).size());
        
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
    //여행 계획 생성 요청
    @PostMapping("/planView")
    public ResponseEntity<HashMap<String,String>> planCreate(PlannerVO pvo, HttpSession session) {
    	String userid = (String)session.getAttribute("logId");
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		//작성자 등록
    		pvo.setUserid(userid);
    		//넘버링과 넘어온 contentid 수가 다를 경우
    		if(pvo.getContentidList().size() != pvo.getOrderList().size()) {
    			result.put("msg","잘못된 형식 입니다.");
    			result.put("status", "200");
    			result.put("redirect", "/planView");
    		}
    		else if(plannerService.plannerInsert(pvo) > 0){
    			//장소 정보 가공
    			List<PlannerLocationVO> pvoList = new ArrayList<PlannerLocationVO>();
    			for(int i=0; i<pvo.getOrderList().size(); i++) {
    				String contentid = pvo.getContentidList().get(i);
    				int order = pvo.getOrderList().get(i);
            		pvoList.add(new PlannerLocationVO(pvo.getNo(),contentid, order));
            	}
    			//여행 장소 생성
    			if(pvoList != null && pvoList.size() > 0)
    				plannerService.plannerLocationInsert(pvoList,pvo.getNo());
    			result.put("msg","여행계획 생성 성공!");
    			result.put("status", "200");
    			result.put("redirect", "/planView");
    		}
    		else {
    			//생성 실패 
    			result.put("msg","잘못된 형식 입니다.");
    			result.put("status", "200");
    			result.put("redirect", "/planView");
    		}
    		
    		
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
        	
    	}catch(Exception e) {
    		//로그아웃 상태
    		e.printStackTrace();
    		result.put("msg","여행 계획 생성 에러...Error");
			result.put("status", "400");
			result.put("redirect", "/planView");
			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
    	}
    
    	return entity;
    }
    
    //여행플랜 수정 요청
    @PutMapping("/planView")
    public ResponseEntity<HashMap<String,String>> planUpdate(PlannerVO pvo, HttpSession session){
    	String userid = (String)session.getAttribute("logId");
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		//플랜 정보가 있을 경우
    		if(plannerService.plannerSelectByNo(pvo.getNo(), userid) != null) {
    			//여행플랜 업데이트
    			int r = plannerService.plannerUpdate(pvo);
    			if(r>0 && pvo.getOrderList() != null && pvo.getContentidList() != null) {
    				//여행 플랜 장소 제거
    				int deleteCount = plannerService.plannerLocationDeleteByPlannerNo(pvo.getNo());
    				System.out.println("deleteCount : " + deleteCount);
    				//장소 정보 가공
        			List<PlannerLocationVO> pvoList = new ArrayList<PlannerLocationVO>();
        			for(int i=0; i<pvo.getOrderList().size(); i++) {
        				String contentid = pvo.getContentidList().get(i);
        				int order = pvo.getOrderList().get(i);
                		pvoList.add(new PlannerLocationVO(pvo.getNo(),contentid, order));
                	}
        			//여행 장소 생성
        			plannerService.plannerLocationInsert(pvoList,pvo.getNo());
        			
        			result.put("status", "200");
        			result.put("msg", "여행 정보 업데이트 성공!");
        			result.put("redirect","/planView");
    			}
    		}
    		else {
    			//일치하는 여행플랜이 없을 경우 
    			result.put("status", "200");
    			result.put("msg", "여행플랜 업데이트 실패!");
    			result.put("redirect","/planView");
    		}
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    		result.put("status", "400");
			result.put("msg", "여행플랜 업데이트 에러...Error");
			result.put("redirect","/planView");
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
    	}
    	
    	return entity;
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
