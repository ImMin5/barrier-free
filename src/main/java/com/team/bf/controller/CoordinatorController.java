package com.team.bf.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;


import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.team.bf.service.CoordinatorService;
import com.team.bf.vo.CoordinatorVO;


@RestController

public class CoordinatorController {
	
	@Inject
	CoordinatorService coordinatorservice;
	
	
	//코디네이터 등록 1
	@PostMapping("coordinatorForm")
	public String CoordinatorForm(CoordinatorVO vo, Model model) {
		
		int cnt = coordinatorservice.CoordiInsert(vo);
		
	
		model.addAttribute("cnt", cnt);
		System.out.println("등록 성공");
		return "coordinator/coordinatorResult";
	}
	
	//코디정보수정 하기 2
	@PostMapping("coordinator")
	
	public ModelAndView coordiEdit(CoordinatorVO vo, HttpSession session) {
		
 		vo.setCoo_userid((String)session.getAttribute("logId"));
		
		coordinatorservice.CoordinatorUpdate(vo);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/");
		System.out.println("수정 성공");
		return mav;
	}
	//코디 등록 아이디 중복 검사 3
	@PostMapping("coordiIdCheck")
	
	
	public int coordiCheck(String coo_userid){
		int cnt = coordinatorservice.CoordiidCheck(coo_userid);
		System.out.println("코디아이디 중복검사 ");
		return cnt;
	}
}