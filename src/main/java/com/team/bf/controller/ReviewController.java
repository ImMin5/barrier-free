package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.bf.service.ReviewService;
import com.team.bf.vo.ReviewVO;

@RestController
public class ReviewController {

	@Inject
	ReviewService reviewService;
	
	@GetMapping("/mypage/myreview")
	public ModelAndView myreview(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId"); 
		mav.addObject("reviewList",reviewService.reviewSelectById(userid));
		mav.setViewName("mypage/myreview");
		return mav;
	}
	
	@PostMapping("/review/myreview")
	public ResponseEntity<HashMap<String,String>> reivewInsert(ReviewVO rvo, HttpServletRequest request, HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		String userid = (String)session.getAttribute("logId");
		try {
			if(userid == null) {
				result.put("status", "200");
				result.put("msg","로그인 후 이용해 주세요.");
				result.put("redirect", "/login");
			}
			else {
				//ip주소
				rvo.setUserid(userid);
				rvo.setIp(request.getRemoteAddr());
				reviewService.reviewInsert(rvo);
				result.put("status","200");
				result.put("msg","리뷰등록완료");
				result.put("redirect", "/");
			}
			
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status", "400");
			result.put("msg","리뷰 등록 Error...");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@PutMapping("/review/myreview")
	public ResponseEntity<HashMap<String,String>> reivewUpdate(ReviewVO rvo, HttpServletRequest request, HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		String userid = (String)session.getAttribute("logId");
		
		try {
			if(reviewService.reviewSelectByNo(rvo.getNo()) == null || rvo.getUserid().equals(userid) == false) {
				//리뷰가 존재하지 않거나 , 작성자가 다를 경우 
				result.put("status", "200");
				result.put("msg","잘못된 접근입니다.");
				result.put("redirect","/");
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
			}
			else {
				rvo.setIp(request.getRemoteAddr());
				if(reviewService.reviewUpdate(rvo) > 0){
					result.put("status", "200");
					result.put("msg","리뷰 수정 완료");
					result.put("redirect","/");
				}
				else {
					result.put("status", "200");
					result.put("msg","리뷰 수정 실패");
					result.put("redirect","/");
				}
				
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status", "400");
			result.put("msg","잘못된 접근입니다...Error");
			result.put("redirect","/");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@DeleteMapping("/review/myreview")
	public ResponseEntity<HashMap<String,String>> reivewDelete(int no, HttpServletRequest request, HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		String userid = (String)session.getAttribute("logId");
		
		try {
			ReviewVO rvo = reviewService.reviewSelectByNo(no);
			if(rvo == null || rvo.getUserid().equals(userid) == false) {
				//리뷰가 존재하지 않거나 , 작성자가 다를 경우 
				result.put("status", "200");
				result.put("msg","잘못된 접근입니다.");
				result.put("redirect","/");
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
			}
			else {
				if(reviewService.reviewDelete(rvo) > 0) {
					result.put("status", "200");
					result.put("msg","리뷰 삭제 완료");
					result.put("redirect","/");
				}
				else {
					result.put("status", "200");
					result.put("msg","리뷰 삭제 실패");
					result.put("redirect","/");
				}
				
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
			}
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status", "400");
			result.put("msg","잘못된 접근입니다...Error");
			result.put("redirect","/");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}