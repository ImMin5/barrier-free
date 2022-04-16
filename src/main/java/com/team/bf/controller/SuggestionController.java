package com.team.bf.controller;

import java.nio.charset.Charset;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	public ModelAndView suggestionList(PagingVO pVO){
		ModelAndView mav = new ModelAndView();
		
		//총 페이지 수
		pVO.setTotalRecord(service.totalRecord(pVO));
		
		//DB연결
		mav.addObject("list", service.suggestionList(pVO));
		
		//페이지 정보
		mav.addObject("pVO", pVO);
		
		mav.setViewName("community/suggest"); 
		return mav;
	}
	//건의할래요 게시글 생성 요청2
	@PostMapping("suggestWrite")
	public ResponseEntity<String> suggestWrite(SuggestionVO vo, HttpServletRequest request){
		vo.setIp(request.getRemoteAddr()); 

		vo.setUserid((String)request.getSession().getAttribute("logId"));
		
		ResponseEntity<String> entity = null;
		MultiValueMap<String, String> header = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			service.suggestionInsert(vo);
			String msg = "<script>";
				   msg += "alert('등록이 성공했습니다');";
				   msg += "location.href='/community/suggestList';";
				   msg += "</script>";
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
	@DeleteMapping("/suggest/suggestList")
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
    			result.put("redirect", "community/suggest");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		else {
    			service.suggestionDelete(svo.getUserid(), svo.getNo());
    			result.put("status", "200");
    			result.put("msg", "글 삭제 완료.");
    			result.put("redirect", "community/suggest");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    	}catch(Exception e) {
    		//삭제할 게시글이 존재하지 않을 경우
    		
    		e.printStackTrace();
    		result.put("status", "400");
    		result.put("msg", "글 삭제요청 에러");
    		result.put("redirect", "/community/suggest");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);	
    	}
    	return entity;
    }
		//건의할래요 상세보기 4 
		@GetMapping("community/suggestView")
		public ModelAndView suggestionView(int no){
			ModelAndView mav = new ModelAndView();
			System.out.println("보기 가능함");
			SuggestionVO vo  = service.suggestionSelect(no);
			
			System.out.println(vo.getNo());
			mav.addObject("vo", service.suggestionSelect(no));
			mav.setViewName("community/suggestView");
			return mav;
		}

		//수정하고 난 뒤 보기 5
		@GetMapping("community/suggestEdit")
		public ModelAndView suggestEdit(int no) {
			ModelAndView mav = new ModelAndView();
			SuggestionVO vo = service.suggestionView(no);
			mav.addObject("vo", vo);
			mav.setViewName("community/suggestEdit");
			return mav;
		}
		//수정하기 6
		@PutMapping("community/suggestEdit")
		public ResponseEntity<String> suggestEdit(SuggestionVO vo, HttpSession session) {
			ResponseEntity<String> entity = null;
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
			System.out.println("test");
			vo.setUserid((String)session.getAttribute("logId"));
			try {
				int result = service.suggestionUpdate(vo);
				if(result>0) {//수정 성공시
					entity = new ResponseEntity<String>(getEditSuccessMessage(vo.getNo()), headers, HttpStatus.OK);
				}else {//수정 실패 시
					entity = new ResponseEntity<String>(getEditFailMessage(), headers, HttpStatus.BAD_REQUEST);
				}
			}catch(Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<String>(getEditFailMessage(), headers, HttpStatus.BAD_REQUEST);
			}
			return entity;
		}
		
		//글 수정 메시지 메소드
		public String getEditFailMessage() {
			String msg = "<script>";
				   msg += "alert('글 수정에 실패하였습니다.\\수정 폼으로 이동합니다.');";
				   msg += "history.back();";
				   msg += "</script>";
			return msg;
		}
		public String getEditSuccessMessage(int no) {
			String msg = "<script>";
				   msg += "alert('글 수정에 성공했습니다.\\상세보기로 이동합니다.');";
				   msg += "location.href='community/suggestView?no="+no+"';";
				   msg += "</script>";
			return msg;
		}
	}

