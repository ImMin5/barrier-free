package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.team.bf.service.ReviewService;
import com.team.bf.vo.ReviewVO;

@RestController
public class ReviewController {

	@Inject
	ReviewService reviewService;
	
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
}
