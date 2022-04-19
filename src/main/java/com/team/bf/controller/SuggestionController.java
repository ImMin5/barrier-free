package com.team.bf.controller;


import java.util.HashMap;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;

import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;


import com.team.bf.vo.PagingVO;
import com.team.bf.vo.SuggestionVO;
import com.team.bf.service.MemberService;
import com.team.bf.service.SuggestionService;


@RestController 

public class SuggestionController {
	
	@Inject 
	SuggestionService service;
	
	@Inject
	MemberService memberService;
	
	//건의할래요 뷰 1
	@GetMapping("suggest")
	public ModelAndView suggestionList(@RequestParam(value="pageNo",required = false, defaultValue = "1")int pageNo, @RequestParam(value="pageCount",required = false, defaultValue = "3")int pageCount, @RequestParam(value="searchWord",required = false, defaultValue = "")String searchWord){
		ModelAndView mav = new ModelAndView();
		
		
		PagingVO pvo = new PagingVO();
        //검색어가 있을 경우
        if(!searchWord.equals("")) 
        	pvo.setSearchWord(searchWord);
        //전체 게시글 업데이트
        pvo.setOnePageRecord(pageCount);
        pvo.setTotalRecord(service.totalRecord(pvo));
        pvo.setPageNo(pageNo);
        
		//총 페이지 수
        pvo.setTotalRecord(service.totalRecord(pvo));
		
		//DB연결
		mav.addObject("suggestionList", service.suggestionList(pvo));
		
		//페이지 정보
		mav.addObject("pvo", pvo);
		
		mav.setViewName("community/suggest"); 
		return mav;
	}
	
	
	
	
	//게시글 등록 뷰
	@GetMapping("suggestWrite")
	public ModelAndView suggestWrite() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("community/suggestWrite");
		return mav;
	
	
	}
	
	
	
	
	
	//건의할래요 게시글 생성 요청2
	@PostMapping("/suggestWrite")
	public ResponseEntity<String> suggestWrite(SuggestionVO vo, HttpServletRequest request){
		System.out.println("wirte start");
		vo.setIp(request.getRemoteAddr()); 
		vo.setUserid((String)request.getSession().getAttribute("logId"));
		
		ResponseEntity<String> entity = null;
		MultiValueMap<String, String> header = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			service.suggestionInsert(vo);
			String msg = "<script>";
				   msg += "alert('등록이 성공했습니다');";
				   msg += "location.href='/suggest';";
				   msg += "</script>";
				   
			System.out.println("write");
			entity = new ResponseEntity<String>(msg, header, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			String msg = "<script>";
				   msg += "alert('등록이 실패하였습니다');";
				   msg += "history.back();";
				   msg += "</script>";
			entity = new ResponseEntity<String>(msg, header, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	//건의할래요 삭제요청 3
	@DeleteMapping("/suggest/suggestionList")
    public ResponseEntity<HashMap<String,String>> suggestionDelete(int no, HttpServletRequest request, HttpSession session){
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	String userid = (String)session.getAttribute("logId");
    	System.out.println("delete");
    	try {
    		SuggestionVO svo = service.suggestionSelectByNo(no);
    		//작성자가 다를 경우
    		if(svo.getUserid().equals(userid)== false) {
    			result.put("status", "200");
    			result.put("msg", "잘못된 접근입니다");
    			result.put("redirect", "/suggest");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		else {
    			service.suggestionDelete(svo.getUserid(), svo.getNo());
    			result.put("status", "200");
    			result.put("msg", "글 삭제 완료.");
    			result.put("redirect", "/suggest");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    	}catch(Exception e) {
    		//삭제할 게시글이 존재하지 않을 경우 4
    		
    		e.printStackTrace();
    		result.put("status", "400");
    		result.put("msg", "글 삭제요청 에러");
    		result.put("redirect", "/suggest");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);	
    	}
    	return entity;
    }
		//건의할래요 상세보기 5 
	@GetMapping("/suggest/suggestionList/{no}")
    public ModelAndView suggestionInfoView(@PathVariable(value="no")int no) {
    	ModelAndView mav  = new ModelAndView();
    	System.out.println("출력");
    	try {
    		SuggestionVO svo = service.suggestionSelectByNo(no);
    		if(svo != null) {
    			mav.addObject("svo",svo);
    			mav.setViewName("community/suggestView");
    		}
    		else {
    			//게시물이 존재 하지 않을 경우
    			System.out.println("존재하지 않는 게시물");
    			mav.setViewName("redirect:/suggest/suggestionList");
    		}
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    		mav.setViewName("redirect:/suggest/suggestionList");
    	}
    	return mav;
    }

		//수정 뷰 7
	    @PostMapping("suggest/suggestionList/edit/{no}")
	    public ModelAndView suggestionEditView(@PathVariable(value="no")int no, HttpSession session) {
	    	ModelAndView mav = new ModelAndView();
	    	try {
		    	String userid = (String)session.getAttribute("logId"); 
		    	SuggestionVO svo = service.suggestionSelectByNo(no);
		    	//작성자 본인 확인
		    	if(userid != null && svo.getUserid().equals(userid) == true){
		    		mav.setViewName("community/suggestEdit");
		    		mav.addObject("svo",service.suggestionSelectByNo(no));
		    	}
		    	else {
		    		
		    		mav.setViewName("redirect:/suggest");
		    	}
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    		mav.setViewName("redirect:/suggest");
	    	}
	    	return mav;
	    }  
		
	    
	    
	    // 수정하기 요청 8
	    @PutMapping("/suggest/suggestionList")
	    public ResponseEntity<HashMap<String,String>> suggestionUpdate(SuggestionVO svo, HttpServletRequest request, HttpSession session){
	    	ResponseEntity<HashMap<String,String>> entity = null;
	    	HashMap<String,String> result = new HashMap<String,String>();
	    	String userid = (String)session.getAttribute("logId");
	    	
	    	try { 	
	    		if(service.suggestionSelectByNo(svo.getNo()) == null) {
	    			//수정할 게시글이 존재하지 않는 경우
	    			result.put("status", "200");
	    			result.put("msg", "존재하지 않는 게시물 입니다.");
	    			result.put("redirect", "/suggest");
	    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
	    		}
	    		//작성자가 다른경우
	    		if(svo.getUserid().equals(userid)== false) {
	    			result.put("status", "200");
	    			result.put("msg", "잘못된 접근입니다");
	    			result.put("redirect", "/suggest");
	    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
	    		}
	    		else {
	    			svo.setIp(request.getRemoteAddr());
	    			service.suggestionUpdate(svo);
	    			result.put("status", "200");
	    			result.put("msg", "글 수정 완료.");
	    			result.put("redirect", "/suggest");
	    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
	    		}
	    	}catch(Exception e) {
	    		result.put("status", "400");
	    		result.put("msg", "글 수정 요청 Error...");
	    		result.put("redirect", "/suggest");
	    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);	
	    	}
	    	
	    	
	    	return entity;
	    }
		
}	
