package com.team.bf.controller;

import java.net.http.HttpHeaders;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.team.bf.service.SuggestionService;
import com.team.bf.vo.PagingVO;
import com.team.bf.vo.SuggestionVO;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

public class SuggestionController {
 
    @inject
    SuggestionService service;

    @GetMapping("suggestionList")
    public ModelAndView SuggestionList(PagingVO pVO) {
        ModelAndView mav = new ModelAndView();

        pVO.setTotalRecord(service.totalRecord(pVO));

        mav.addObject("list", service.suggestionList(pVO));
        mav.addObject("pVO, pVO");

        mav.setViewName("suggestion/suggestionList");
        return mav;

    }

    
	@GetMapping("suggestionWrite")
	public ModelAndView suggestionWrite() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("suggestion/suggestionWrite");
		return mav;
	}
	
	@PostMapping("suggestionWriteOk")
	public ResponseEntity<String> boardWriteOk(SuggestionVO vo, HttpServletRequest request){
		vo.setIp(request.getRemoteAddr()); 

		vo.setUserid((String)request.getSession().getAttribute("logId"));
		
		ResponseEntity<String> entity = null; 
		HttpHeaders headers = new HttpHeaders();
		header.add("Content-Type", "text/html; charset=utf-8");
		
        try {
			service.suggestionInsert(vo);
			String msg = "<script>";
				   msg += "alert('');";
				   msg += "location.href='/myapp/suggestion/suggestionList';";
				   msg += "</script>";
			entity = new ResponseEntity<String>(msg, header, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			String msg = "<script>";
				   msg += "alert('');";
				   msg += "history.back();";
				   msg += "</script>";
			entity = new ResponseEntity<String>(msg, header, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	@GetMapping("suggestionView")
	public ModelAndView suggestionView(int no){
		ModelAndView mav = new ModelAndView();
		
		service.hitCount(no);
		
		mav.addObject("vo", service.suggestionSelect(no));
		mav.setViewName("suggestion/suggestionView");
		return mav;
	}
	
	
	@GetMapping("suggestionEdit")
	public ModelAndView suggestionEdit(int no) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("vo", service.suggestionSelect(no));
		mav.setViewName("suggestion/suggestionEdit");
		
		return mav;
	}
	
	
	@PostMapping("suggestionEditOk")
	public ResponseEntity<String> suggestionEditOk(SuggestionVO vo, HttpSession session) {
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		
		vo.setUserid((String)session.getAttribute("logId"));
		try {
			int result = service.suggestionUpdate(vo);
			if(result>0) {
				entity = new ResponseEntity<String>(getEditSuccessMessage(vo.getNo()), headers, HttpStatus.OK);
			}else {
				entity = new ResponseEntity<String>(getEditFailMessage(), headers, HttpStatus.BAD_REQUEST);
			}
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(getEditFailMessage(), headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	@GetMapping("suggestionDel")
	public ModelAndView suggestionDel(int no, HttpSession session){
		String userid = (String)session.getAttribute("logId");
		
		int result = service.suggestionDelete(no, userid);
		
		ModelAndView mav = new ModelAndView();
		if(result>0) {
			mav.setViewName("redirect:suggestionList");
		}else {
			mav.addObject("no", no);
			mav.setViewName("redirect:suggestionView");
		}
		return mav;
	}

	public String getEditFailMessage() {
		String msg = "<script>";
			   msg += "alert('.');";
			   msg += "history.back();";
			   msg += "</script>";
		return msg;
	}
	public String getEditSuccessMessage(int no) {
		String msg = "<script>";
			   msg += "alert('.');";
			   msg += "location.href='/myapp/suggestion/suggestionView?no="+no+"';";
			   msg += "</script>";
		return msg;
	}
}









}
