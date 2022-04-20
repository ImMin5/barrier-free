package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.team.bf.service.CoordinatorService;
import com.team.bf.service.MemberService;
import com.team.bf.vo.CoordinatorVO;
import com.team.bf.vo.MemberVO;


@RestController

public class CoordinatorController {
	
	@Inject
	CoordinatorService coordinatorservice;
	
	@Inject
    MemberService memberService;
	
	
	

	   //코디네이터 목록 뷰 
	   @GetMapping("/coordinator")
	   public ModelAndView cordinatorListView() {
	      ModelAndView mav = new ModelAndView();
	      mav.addObject("coordiList", coordinatorservice.coordinatorSelectAll());
	      mav.setViewName("coordinator/coordinator");
	      return mav;
	   }
	   
	   // 코디네이터 로그인 하기
	   @PostMapping("coordinatorLogin")
	   public ModelAndView coo_login(CoordinatorVO vo, HttpSession session) {
	      
	      CoordinatorVO vo2 = coordinatorservice.coordiloginCheck(vo);
	      
	      ModelAndView mav = new ModelAndView();
	      if(vo2!=null) {//코디 로그인  성공 시 
	         session.setAttribute("Coo_logId", vo2.getCoo_userid());
	         session.setAttribute("logStatus", "Y");
	         System.out.println("코디네이터 로그인 성공");
	         mav.setViewName("redirect:/");
	      }else {//로그인 실패 : 로그인 폼으로 이동
	         mav.setViewName("redirect:coordinator");
	         System.out.println("코디네이터 로그인 실패");
	      }
	      
	      return mav;
	   }
	   
	   //코디네이터 등록 폼 뷰 
	   @GetMapping("/admin/coordinator/form")
	   public ModelAndView coordinatorFormView(HttpSession session) {
		   ModelAndView mav = new ModelAndView();
		   try {
			   mav.setViewName("admin/coordinatorForm");
		   }catch(Exception e) {
			   e.printStackTrace();
			   mav.setViewName("redirect:/admin/coordinator");
		   }
		   return mav;
	   }
	   
	   @GetMapping("/admin/coordinator")
	   public ModelAndView coordinatorAdminListView() {
		   ModelAndView mav = new ModelAndView();
		   mav.addObject("coordiList", coordinatorservice.coordinatorSelectAll());
		   mav.setViewName("admin/coordinator");
		   return mav;
			   
		   
	   }
	   
	   //코디네이터 등록 
	   @PostMapping("/admin/coordinator/form")
	   public ResponseEntity<HashMap<String,String>> coordinatorForm(CoordinatorVO cvo, MemberVO mvo, HttpSession session){
        System.out.println("signup :  코디네이터 등록" );
        HashMap<String, String> result = new HashMap<>();
        ResponseEntity<HashMap<String, String>> entity = null;
        try{
            if(coordinatorservice.CoordiInsert(cvo) > 0){
                
                session.setAttribute("logId", mvo.getUserid());
                result.put("msg","코디네이터 등록 완료");
                result.put("redirect","/");
                entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
            }
            else{
                result.put("msg","코디네이터 등록 실패");
                result.put("status","400");
                result.put("redirect","/");
                entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
            }
        }catch(Exception e){
            e.printStackTrace();
            result.put("msg","코디네이터 등록 실패");
            result.put("status","400");
            result.put("redirect","/");
            entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

	//코디정보수정 하기 
	@PostMapping("coordinatorUpdate")
	public ModelAndView coordiUpdate(CoordinatorVO vo, HttpSession session) {
		
 		vo.setCoo_userid((String)session.getAttribute("logId"));
		
		coordinatorservice.CoordinatorUpdate(vo);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		System.out.println("수정 성공");
		return mav;
	}
	//코디 등록 아이디 중복 검사 
	@PostMapping("coordiIdCheck")
	
	
	public int coordiCheck(String coo_userid){
		int cnt = coordinatorservice.CoordiidCheck(coo_userid);
		System.out.println("코디아이디 중복검사 ");
		return cnt;
	}
}