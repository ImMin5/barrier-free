package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.team.bf.service.MemberService;
import com.team.bf.service.PlannerService;
import com.team.bf.vo.MemberVO;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class MemberController {
    @Inject
    MemberService memberService;
    
    //마이페이지 뷰
    @GetMapping("/mypage")
    public ModelAndView mypage(HttpSession session){
        ModelAndView mav = new ModelAndView();
        String userid = (String)session.getAttribute("logId");
        if(userid != null) {
        	 mav.addObject("mvo",memberService.memberSelectById(userid));
             mav.setViewName("mypage/mypage");
        }
        else {
        	mav.setViewName("redirect:/");
        }
       
        return mav;
    }
    
    //로그인 페이지 뷰 
    @GetMapping("/login")
    public ModelAndView login(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("member/login");
        return mav;
    }
    //로그인 요청
    @PostMapping("/login")
    public ModelAndView loginReq(MemberVO mvo, HttpSession session){
    	ModelAndView mav = new ModelAndView();
        MemberVO mvoOrigin = memberService.memberSelectById(mvo.getUserid());
        
        //아이디가 존재하지 않음
        if(mvoOrigin == null){
            System.out.println("아이디가 존재하지 않습니다.");
            mav.setViewName("redirect:/login");
        }
        else if(mvoOrigin.getUserid().equals(mvo.getUserid())){
            if(mvoOrigin.getUserpassword().equals(mvo.getUserpassword())){
            	System.out.println("로그인 성공");
                session.setAttribute("logId", mvo.getUserid());
                mav.setViewName("redirect:/");
            }
            else{
                System.out.println("로그인 실패 비밀번호 불일치");
                mav.setViewName("redirect:/login");
            }
          
        }
        else{
        	 System.out.println("로그인 실패");
        	 mav.setViewName("redirect:/");
        }

        return mav;
    }
    //로그아웃
    @GetMapping("/logout")
    public ModelAndView logout(HttpSession session){
    	 ModelAndView mav = new ModelAndView();
    	String userid = (String)session.getAttribute("logId");
    	if(userid != null) {
    		 mav.setViewName("redirect:/");
    		 session.invalidate();
    	}
    	else {
    		mav.setViewName("redirect:/login");
    	}
        return mav;

    }
    //회원 탈퇴 뷰 페이지
    @GetMapping("/mypage/delete")
    public ModelAndView memberDeleteView(HttpSession session) {
    	ModelAndView mav = new ModelAndView();
    	String userid = (String)session.getAttribute("logId");
    	try {
    		MemberVO mvo = memberService.memberSelectById(userid);
    		mav.addObject("mvo", mvo);
    		mav.setViewName("mypage/delete");
    	}catch(Exception e) {
    		e.printStackTrace();
    		mav.setViewName("redirect:/");
    	}
    	
    	return mav;
    	
    }

    //회원 탈퇴
    @DeleteMapping("/member")
    public ResponseEntity<HashMap<String,String>> memberDelete(HttpSession session, String userpassword){
    	ResponseEntity<HashMap<String,String>> entity = null;
        HashMap<String,String> result = new HashMap<>();

        String userid = (String)session.getAttribute("logId");
        System.out.println("삭제할 아이디 : " + userid);
        int count = memberService.memberDelete(userid, userpassword);
        if(count > 0){
            result.put("msg","회원탈퇴 성공");
            result.put("status","200");
            result.put("redirect","/");
            entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
            session.invalidate();
        }
        else{
            result.put("msg","회원탈퇴 실패");
            result.put("status","400");
            result.put("redirect","/mypage");
            entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
        }
        
        return entity;
    }

    @GetMapping("/signup")
    public ModelAndView signupView(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("member/signupView");
        return mav;
    }
    
    //아이디 찾기 뷰
    @GetMapping("/infoid")
    public ModelAndView infoIdView(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("member/id");
        return mav;
    }
    
    //아이디 찾기 요청
    @PostMapping("/infoid")
    public ResponseEntity<HashMap<String,String>> findInfoId(String username, String date_birth){
        
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
	    	MemberVO mvo = memberService.memberSelectByUsername(username, date_birth);
	        //정보와 일치하는 아이디가 없을 경우
	    	if(mvo == null) {
	        	result.put("msg", "일치하는 아이디가 없습니다.");
	        	result.put("userid", "");
	        	result.put("status","200");
	        	entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
	        }
	    	else {
	    		System.out.println("아이디 찾기 결과 : " +  mvo.getUserid());
	    		result.put("msg", "일치하는 아이디가 있습니다.");
	    		result.put("userid", mvo.getUserid());
	    		result.put("redirect", "/login");
	        	result.put("status","200");
	        	entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
	    	}
    	}catch(Exception e) {
    		e.printStackTrace();
    		result.put("msg", "아이디 찾기 요청 실패....");
    		result.put("status", "400");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
    	}
    	
        return entity; 
    }
    
    //비밀번호 찾기 뷰 
    @GetMapping("/infopwd")
    public ModelAndView infoPasswordView(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("member/password");
        return mav;
    }
    
  //비밀번호 찾기 요청
    @PostMapping("/infopwd")
    public ResponseEntity<HashMap<String,String>> findInfoPwd(String userid, String question, String answer){
        String initPassword ="12341234";
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		MemberVO mvo = memberService.memberSelectByQuestion(userid, question, answer);
    		//정보와 일치하는 멤버 객체가 없을 경우
    		if(mvo != null && memberService.memberUpdatePassword(mvo.getUserid(), initPassword) > 0) {
    			System.out.println("원래 비밀번호 : " + mvo.getUserpassword());
    			result.put("msg", "비밀번호가 초기화 되었습니다.");
	    		result.put("newpassword", initPassword);
	    		result.put("redirect", "/login");
	        	result.put("status","200");
	        	entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		else{
	        	result.put("msg", "일치하는 결과가 없습니다. 입력한 정보를 확인해 주세요");
	        	result.put("newpassword", "");
	        	result.put("status","200");
	        	entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
	        }
    	}
    	catch(Exception e) {
    		result.put("msg", "비밀번호 찾기 요청 실패....");
    		result.put("status", "200");
    		e.printStackTrace();
    	}
        return entity; 
    }


    //회원가입 요청
    @PostMapping("/signup")
    public ModelAndView signup(MemberVO mvo, HttpSession session){
    	ModelAndView mav = new ModelAndView();
     
        try{
            if(memberService.memberInsert(mvo) > 0){
                //session에 userid를 저장
                session.setAttribute("logId", mvo.getUserid());
                System.out.println("회원가입 완료");
                mav.setViewName("redirect:login");
            }
            else{
                System.out.println("msg 회원가입 실패");
                mav.setViewName("redirect:/signup");
            }
        }catch(Exception e){
        	e.printStackTrace();
        	System.out.println("회원가입 에러...Error");
            mav.setViewName("redirect:/signup");
        }
        return mav;
    }
    //아이디 중복검사
    @PostMapping("/signup/memberIdCheck")
    public int memberIdCheck(String userid) {
    	return memberService.memberUseridCheck(userid);
    }
    
    //회원정보 수정 요청
    @PutMapping("/mypage")
    public ResponseEntity<HashMap<String,String>> memberEdit(MemberVO mvo, HttpSession session){
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	String userid = (String)session.getAttribute("logId");
    	
    	try {
    		mvo.setUserid(userid);
    		result.put("status", "200");
    		if(userid == null) {
    			result.put("msg", "로그인 후 이용해 주세요");
    			result.put("redirect","redirect:/login");
    		}
    		else {
    			if(memberService.memberUpdate(mvo) > 0) {
    				result.put("msg", "회원 정보 업데이트 성공!");
        			result.put("redirect","redirect:/mypage");
    			}
    			else {
    				result.put("msg", "회원 정보 업데이트 실패.");
        			result.put("redirect","/mypage");
    			}
    		}
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    		result.put("status", "400");
    		result.put("msg", "회원 정보 업데이트 에러...Error");
    		result.put("redirect","/");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
    	}
    	
    	return entity;
    }
}
