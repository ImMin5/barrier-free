package com.team.bf.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.bf.service.HeartService;
import com.team.bf.service.LikeService;
import com.team.bf.service.OpenApiService;
import com.team.bf.service.PlannerService;
import com.team.bf.service.ReviewService;
import com.team.bf.vo.PlannerLocationVO;
import com.team.bf.vo.PlannerMemberVO;
import com.team.bf.vo.PlannerVO;
import com.team.bf.vo.ResponseVO;

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
	
	@GetMapping("/mapView")
    public ModelAndView mapView2(@RequestParam(value="planner_no", required=false) Integer planner_no, HttpSession session){
        String userid = (String)session.getAttribute("logId");
       ModelAndView mav = new ModelAndView();
       if(planner_no == null) {
           planner_no = -1;
       }
       if(userid != null) {
           mav.addObject("planner_no", planner_no);
           mav.addObject("planList", plannerService.plannerSelectById(userid));
       }
       else {
           mav.addObject("planner_no", "-1");
       }
       
        mav.setViewName("map/mapView");
        return mav;
    }	
	 //마이페이지 나의 플래너 뷰
    @GetMapping("/mypage/myplanner")
    public ModelAndView ModelAndView(HttpSession session) {
    	ModelAndView mav = new ModelAndView();
    	String userid = (String)session.getAttribute("logId");
    	try {
    		if(userid != null) {
    			mav.addObject("planList", plannerService.plannerSelectById(userid));
    			mav.setViewName("mypage/myplan");
    		}
    		else {
    			mav.setViewName("redirect:/login");
    		}
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    		mav.setViewName("redirect:/");
    	}
    	
    	
    	return mav;
    }
    //여행정보 불러오기
    @PostMapping("/mapInfo/load")
    public String load_planner(PlannerVO pvo) {
    	JSONArray jsonArray = new JSONArray();
    	try {
    		int seq = 1;
    		for(String cid :pvo.getContentidList()) {
    			System.out.println("cid " + cid);
    			JSONObject jObj = openApiService.detailCommon(cid, areaCode); 
    			jObj.put("likeCount", likeService.likeSelectAll(cid));
    			jObj.put("heartCount", heartService.heartSelectAll(cid));
    			jObj.put("reviewCount", reviewService.reviewSelectByContentid(cid).size());
    			jObj.put("seq", seq++);
    			Float avgScore = reviewService.reviewSelectAvgScore(cid);    
    			if(avgScore == null)
    				jObj.put("avgScore", "0");
    			else 
    				jObj.put("avgScore", String.format("%.2f",avgScore));
    			jsonArray.put(jObj);
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return jsonArray.toString();
    }
    
    //0.여행지 정보 요청
    @PostMapping("/mapInfo")
    public String mapInfo( String pageNo,String pageCount, String searchWord, HttpSession session){
        String userid = (String)session.getAttribute("logId");
       
        System.out.println(pageNo + " " + pageCount);
        if(pageNo == null) pageNo = "1";
        if(pageCount == null) pageCount = "10";
        if(searchWord == null) searchWord = "";
        JSONArray jsonArray = openApiService.searchKeyword2(pageNo, pageCount, "all", searchWord); 
        for(int i=0; i<jsonArray.length(); i++){
           String cid = jsonArray.getJSONObject(i).get("contentid").toString();
           JSONObject Opt = openApiService.detailCommon(cid,areaCode);
           if(Opt != null) {
        	   jsonArray.getJSONObject(i).put("title",Opt.get("title").toString());
               jsonArray.getJSONObject(i).put("overview",Opt.get("overview").toString());
               jsonArray.getJSONObject(i).put("firstimage",Opt.has("firstimage") ? Opt.get("firstimage").toString() : "");
               jsonArray.getJSONObject(i).put("firstimage2",Opt.has("firstimage2") ? Opt.get("firstimage2").toString() : "");
               if(Opt.has("homepage"))
                  jsonArray.getJSONObject(i).put("homepage", Opt.get("homepage").toString());
               else
                  jsonArray.getJSONObject(i).put("homepage", "");
           }
           jsonArray.getJSONObject(i).put("likeCount", likeService.likeSelectAll(cid));
           jsonArray.getJSONObject(i).put("heartCount", heartService.heartSelectAll(cid));
           jsonArray.getJSONObject(i).put("reviewCount", reviewService.reviewSelectByContentid(cid).size());
     
           Float avgScore = reviewService.reviewSelectAvgScore(cid);    
           if(avgScore == null)
              jsonArray.getJSONObject(i).put("avgScore", "0");
           else 
              jsonArray.getJSONObject(i).put("avgScore", String.format("%.2f",avgScore));
        }      
        //로그인 했을 경우 여행 플래너 정보
        if(userid != null) {
           //jsonArray.put("plannerList",plannerService.plannerSelectById(userid));
        }
        return jsonArray.toString();
    }
    //1.여행 계획 생성 요청
    @PostMapping("/planView")
    public ResponseEntity<HashMap<String,String>> planCreate(PlannerVO pvo, HttpSession session) {
    	String userid = (String)session.getAttribute("logId");
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		
    		//작성자 등록
    		if(userid == null) {
    			result.put("status", "201");
    			result.put("msg", "로그인 후 이용해 주세요");
    			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
    		}
    		pvo.setUserid(userid);
    		result.put("status", "200");
    		//넘버링과 넘어온 contentid 수가 다를 경우
    		if(pvo.getContentidList().size() != pvo.getSeqList().size()) {
    			result.put("msg","잘못된 형식 입니다.");
    			result.put("redirect", "/mapView");
    		}
    		else if(plannerService.plannerInsert(pvo) > 0){
    			//장소 정보 가공
    			List<PlannerLocationVO> pvoList = new ArrayList<PlannerLocationVO>();
    			for(int i=0; i<pvo.getSeqList().size(); i++) {
    				String contentid = pvo.getContentidList().get(i);
    				int order = pvo.getSeqList().get(i);
            		pvoList.add(new PlannerLocationVO(pvo.getNo(),contentid, order));
            	}
    			//여행 장소 생성
    			if(pvoList != null && pvoList.size() > 0)
    				plannerService.plannerLocationInsert(pvoList,pvo.getNo());
    			result.put("msg","여행 플랜 생성 성공!");
    			result.put("redirect", "/mapView");
    			result.put("planner_no", Integer.toString(pvo.getNo()));
    		}
    		else {
    			//생성 실패 
    			result.put("msg","여행 플랜 생성 실패.");
    			result.put("redirect", "/mapView");
    		}
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
        	
    	}catch(Exception e) {
    		//로그아웃 상태
    		e.printStackTrace();
    		result.put("msg","여행 계획 생성 에러...Error");
			result.put("status", "400");
			result.put("redirect", "/mapView");
			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
    	}
    
    	return entity;
    }
    
    //2.여행플랜 수정 요청
    @PutMapping("/planView")
    public ResponseEntity<HashMap<String,String>> planUpdate(PlannerVO pvo, HttpSession session){
    	String userid = (String)session.getAttribute("logId");
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	System.out.println("여행 수정");
    	try {
    		//플랜 정보가 있을 경우
    		System.out.println(pvo.getNo());
    		if(plannerService.plannerSelectByNoId(pvo.getNo(), userid) != null) {
    			
    			//여행플랜 업데이트
    			pvo.setUserid(userid);
    			int r = plannerService.plannerUpdate(pvo);
    			System.out.println("여행 정보 없데이트 십작 "+r);
    			System.out.println(pvo.getContentidList().size());
    			System.out.println(pvo.getSeqList().size());
    			System.out.println(pvo.getStart_date());
    			System.out.println(pvo.getEnd_date());
    			if(r>0 && pvo.getSeqList() != null && pvo.getContentidList() != null) {
    				//여행 플랜 장소 제거
    				int deleteCount = plannerService.plannerLocationDeleteByPlannerNo(pvo.getNo());
    				System.out.println("deleteCount : " + deleteCount);
    				//장소 정보 가공
        			List<PlannerLocationVO> pvoList = new ArrayList<PlannerLocationVO>();
        			for(int i=0; i<pvo.getSeqList().size(); i++) {
        				String contentid = pvo.getContentidList().get(i);
        				int seq = pvo.getSeqList().get(i);
                		pvoList.add(new PlannerLocationVO(pvo.getNo(),contentid, seq));
                	}
        			//여행 장소 생성
        			plannerService.plannerLocationInsert(pvoList,pvo.getNo());
        			result.put("status", "200");
        			result.put("msg", "여행 정보 업데이트 성공!");
        			result.put("redirect","/mapView");
    			}
    		}
    		else {
    		//일치하는 여행플랜이 없을 경우 
    		//자기 플랜이 아닐 경우.
    			result.put("status", "200");
    			result.put("msg", "여행 플랜 수정 권한이 업습니다.");
    			result.put("redirect","/mapView");
    		}
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    		result.put("status", "400");
			result.put("msg", "여행플랜 업데이트 에러...Error");
			result.put("redirect","/mapView");
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
    	}
    	
    	return entity;
    }
    
    //3.예행 계획 삭제 요청
    @DeleteMapping("/planView")
    public ResponseEntity<HashMap<String,String>> planDelete(int no, HttpSession session){
    	String userid = (String)session.getAttribute("logId");
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		PlannerVO pvo = plannerService.plannerSelectByNoId(no, userid);
    		result.put("staus", "200");
    		if(userid == null){
    			//로그인을 안함
    			result.put("msg", "로그인 후 이용해 주세요.");
    			result.put("redirect","/login");
    		}
    		else if(pvo == null) {
    			//일치하는 정보가 없음
    			result.put("msg", "일치하느 정보가 없습니다.");
    			result.put("redirect","/login");
    		}
    		else {
    			System.out.println("삭제한 데이터 : "+ plannerService.plannerDelete(no));
    			result.put("msg", "여행계획 삭제 완료!");
    			result.put("redirect","/mapView");
    		}
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
    	}catch(Exception e) {
    		e.printStackTrace();
    		result.put("staus", "400");
    		result.put("msg", "여행계획 삭제 에러...Error");
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
    	}
    	
    	return entity;
    }
    
    //4.여행계획 조회 
    @PostMapping("/planView/detail/{planner_no}")
    public ResponseEntity<HashMap<String,String>>  planDetailInfo(@PathVariable(value="planner_no") int no, HttpSession session){
    	String userid = (String)session.getAttribute("logId");
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		PlannerVO pvo = plannerService.plannerSelectOne(no,userid);
    		result.put("status", "200");
    		
    		if(userid == null) {	
    			result.put("msg","로그인 후 이용해 주세요.");
    			result.put("redirect","/mapView");
    		}
    		else if(pvo == null) {
    			result.put("msg","일치하는 정보가 없습니다.");
    			result.put("redirect","/mapView");
    		}
    		else {
        		//JSON객체 만들기
        		JSONObject jObj = new JSONObject();
        		JSONObject planObj =new JSONObject();
        		JSONArray contentList = new JSONArray();
        		JSONArray seqList = new JSONArray();
        		JSONArray memberList = new JSONArray();
        		
        		if(pvo.getSeqList().size() > 0) {
        			contentList.putAll(plannerService.plannerLocationSelectByNo(no));
            		seqList.putAll(pvo.getSeqList());
            		
        		}
        		memberList.putAll(plannerService.plannerMemberSelectByNo(pvo.getNo()));
        		planObj.put("no", pvo.getNo());
        		planObj.put("title", pvo.getTitle());
        		planObj.put("start_date", pvo.getStart_date());
        		planObj.put("end_date", pvo.getEnd_date());
        		planObj.put("contendList", contentList);
        		planObj.put("seqList",seqList);
        		
        		jObj.put("pvo", planObj);
        		//데이터 삽입
        		result.put("data", jObj.toString());
        		result.put("msg","여행 플랜 불러오기 성공");
    			result.put("redirect","/mapView");
    		}
    		
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
    	}catch(Exception e) {
    		e.printStackTrace();
    		result.put("status", "400");
    		result.put("msg","여행 플랜 불러오기 에러...Error");
			result.put("redirect","/mapView");
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
    	}
    	return entity;
    	
    }
    
    //5.여행 플랜 멤버 초대 
    @PostMapping("/planView/member")
    public ResponseEntity<HashMap<String,String>> planMemberInvite(int planner_no, String useridInvite, HttpSession session){
    	String userid = (String)session.getAttribute("logId");
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		
    		result.put("status", "200");
    		PlannerVO pvo = plannerService.plannerSelectByNoId(planner_no,userid);
    		if(userid.equals(useridInvite)) {
    			result.put("msg","본인에게 초대를 보낼 수 없습니다.");
    			result.put("redirect","/mapView");
    		}
    		else if(!pvo.getUserid().equals(userid)){
    			//여행 플랜을 생성한 사람만 초대할 수 있음
    			result.put("msg","초대 권한이 없습니다.");
    			result.put("redirect","/mapView");
    		}
    	
    		else if(plannerService.plannerMemberSelectByNoId(planner_no, useridInvite) > 0 || pvo.getUserid().equals(useridInvite)) {
    			result.put("msg","이미 추가 되었습니다.");
    			result.put("redirect","/mapView");
    		}
    		else {
    			plannerService.plannerMemberInsert(planner_no, useridInvite);
    			result.put("msg",useridInvite+" 멤버 초대 완료!");
    			result.put("redirect","/mapView");
    		}
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
    	}catch(Exception e) {
    		//userid 값들이 null 일경우
    		e.printStackTrace();
    		result.put("status", "400");
    		result.put("msg","여행 플랜 멤버 초대 에러...Error");
			result.put("redirect","/mapView");
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
    	}
    	return entity;
		
    	
    }
    
    //6. 여행 플랜 멤버 삭제
    @DeleteMapping("/planView/member")
    public ResponseEntity<HashMap<String,String>> planMemberDelete(int planner_no, String useridDelete, HttpSession session){
    	String userid = (String)session.getAttribute("logId");
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		result.put("status", "200");
    		System.out.println("userid : " + useridDelete);
    		PlannerMemberVO pmvo = plannerService.plannerMemberSelectById(planner_no, useridDelete);
    		if(userid == null) {
    			result.put("msg", "로그인 후 이용해 주세요.");
    			result.put("redirect","/mapView");
    		}
    		else {
    			if(plannerService.plannerMemberDeleteByNo(pmvo.getNo()) > 0) {
    				result.put("msg", "멤버 삭제 성공.");
    				result.put("redirect","/mapView");
    			}
    			else{
    				result.put("msg", "멤버 삭제 실패.");
    				result.put("redirect","/mapView");
    			}
    		}
    		
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
    	}catch(Exception e) {
    		//userid 값들이 null 일경우
    		e.printStackTrace();
    		result.put("status", "400");
    		result.put("msg","여행 플랜 멤버 초대 에러...Error");
			result.put("redirect","/mapView");
    		entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
    	}
    	return entity;
		
    	
    }
    
    //여행 플랜의 멤버 리스트 
    @PostMapping("/planView/memberList")
    public List<String> plannerMemberList(HttpSession session, int planner_no){
    	List<String> memberList = null;
    	String userid = (String)session.getAttribute("logId");
    	
    	try{
    		System.out.println("planner_no : " + planner_no);
    		if(userid != null)
    			memberList = plannerService.plannerMemberSelectByNo(planner_no);
    		for(String str : memberList) {
    			System.out.println(str);
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return memberList;
    	
    }
    
    //여행 목록 반환
    @PostMapping("/planView/plannerList")
    public List<PlannerVO> getPlannerList(HttpSession session) {
    	String userid = (String)session.getAttribute("logId");
    	List<PlannerVO> plannerTitleList = new ArrayList<PlannerVO>();
    	try {
    		if(userid != null)
    			plannerTitleList = plannerService.plannerSelectById(userid);
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	return plannerTitleList;
    }
	    
}