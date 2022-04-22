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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.servlet.ModelAndView;


import com.team.bf.service.TransportationService;
import com.team.bf.vo.TransportationVO;

@RestController
public class TransportationController {
	
	@Inject
	TransportationService service;
	

	//운행수단 리스트
	
	@GetMapping("transportationView")
	public ModelAndView transportationList() {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("lst", service.transportationSelectAll());
		System.out.println("성공 운행기간");
		mav.setViewName("/transportation/transportationView");
		return mav;
	}
	
	//운행수단 등록 폼
	@GetMapping("transportationWrite")
	public ModelAndView transportationWrite() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("transportationWrite");
		return mav;
	}
	
	
	//운행수단 등록 요청
	@PostMapping("/transportation/transportationWrite")
	public ResponseEntity<String> transportationWrite(TransportationVO tvo, HttpServletRequest request){
		System.out.println("등록 시작 합시더");
		tvo.setTitle((String)request.getSession().getAttribute("logId"));
		
		ResponseEntity<String> entity = null;
		MultiValueMap<String, String> header = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			service.transportationInsert(tvo);
			String msg = "<script>";
				   msg += "alert('등록이 성공했습니다');";
				   msg += "location.href='/';";
				   msg += "</script>";
				   
			System.out.println("등록되거라");
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
	
	//운행수단 정보 상세보기 (1) 버스
	@GetMapping("/transportation/bus")
	public ModelAndView bus(int no) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("transportationVO", service.transportationView(no));
		mav.setViewName("/transportation/bus");
		return mav;
	}
	//운행수단 정보 상세보기 (2) 비행기
	@GetMapping("/transportation/plane")
	public ModelAndView plane(int no) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("transportationVO", service.transportationView(no));
		mav.setViewName("/transportation/plane");
		return mav;
	}
	//운행수단 정보 상세보기 (3) 택시
	@GetMapping("/transportation/taxi")
	public ModelAndView taxi(int no) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("transportationVO", service.transportationView(no));
		mav.setViewName("/transportation/taxi");
		return mav;
	}
	
	
	
	
	
	
	//수정하기 뷰
	@GetMapping("transportationEdit")
	public ModelAndView transportationEdit(int no) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("vo", service.transportationSelect(no));
		mav.setViewName("transportationEdit");
		
		return mav;
	}
	//운행정보정보수정 하기 
		@PutMapping("/transportation/transportationEdit")
		public ModelAndView transportationUpdate(TransportationVO tvo, HttpSession session) {
			
	 		tvo.setTitle((String)session.getAttribute("logId"));
			
			service.transportationUpdate(tvo);
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("redirect:/");
			System.out.println("운행정보수정 성공");
			return mav;
		}
		
		
	//운행 삭제
		@DeleteMapping("/transportation/transportationDel")
	    public ResponseEntity<HashMap<String,String>> transportationDelete(int no, HttpServletRequest request, HttpSession session){
	    	ResponseEntity<HashMap<String,String>> entity = null;
	    	HashMap<String,String> result = new HashMap<String,String>();
	    	String title = (String)session.getAttribute("logId");
	    	System.out.println("삭제되라");
	    	try {
	    		TransportationVO tvo = service.transportationSelectByNo(no);
	    		//작성자가 다를 경우
	    		if(tvo.getTitle().equals(title)== false) {
	    			result.put("status", "200");
	    			result.put("msg", "잘못된 접근입니다");
	    			result.put("redirect", "");
	    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
	    		}
	    		else {
	    			service.transportationDelete(tvo.getTitle(), tvo.getNo());
	    			result.put("status", "200");
	    			result.put("msg", "글 삭제 완료.");
	    			result.put("redirect", "/");
	    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
	    		}
	    	}catch(Exception e) {
	    		//삭제할 게시글이 존재하지 않을 경우 4
	    		
	    		e.printStackTrace();
	    		result.put("status", "400");
	    		result.put("msg", "글 삭제요청 에러");
	    		result.put("redirect", "/");
	    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);	
	    	}
	    	return entity;
	    }
}