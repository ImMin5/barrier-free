package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.team.bf.service.HeartService;
import com.team.bf.service.LikeService;

@Controller
public class LikeHeartController {
	@Inject
	LikeService likeService;
	
	@Inject
	HeartService heartService;
	
	@PostMapping("/like")
	public ResponseEntity<HashMap<String,String>> like(String contentid, HttpSession session) {
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		String userid = (String)session.getAttribute("logId");
		
		try {
			//좋아요 안눌려 있을 경우 
			if(userid == null) {
				result.put("msg", "로그인 필요");
			}
			else if(likeService.likeSelectOne(userid, contentid) == 0) {
				likeService.likeInsert(userid, contentid);
				result.put("msg", "like");
			}
			else {
				likeService.likeDelete(userid,contentid);
				result.put("msg", "dislike");
			}
			
			result.put("likeCount", Integer.toString(likeService.likeSelectAll(contentid)));
			result.put("status", "200");
			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
			
			
		}catch(Exception e) {
			e.printStackTrace();
			result.put("likeCount", Integer.toString(likeService.likeSelectAll(contentid)));
			result.put("msg", "좋아요 통신 오류...");
			result.put("status", "400");
			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@PostMapping("/heart")
	public ResponseEntity<HashMap<String,String>> heart(String contentid, HttpSession session) {
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		String userid = (String)session.getAttribute("logId");
		
		try {
			//좋아요 안눌려 있을 경우 
			if(userid == null) {
				result.put("msg", "로그인 필요");
			}
			else if(heartService.heartSelectOne(userid, contentid) == 0) {
				heartService.heartInsert(userid, contentid);
				result.put("msg", "heart");
			}
			else {
				heartService.heartDelete(userid,contentid);
				result.put("msg", "antiheart");
			}
			
			result.put("heartCount", Integer.toString(heartService.heartSelectAll(contentid)));
			result.put("status", "200");
			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
			
			
		}catch(Exception e) {
			e.printStackTrace();
			result.put("heartCount", Integer.toString(heartService.heartSelectAll(contentid)));
			result.put("msg", "좋아요 통신 오류...");
			result.put("status", "400");
			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
