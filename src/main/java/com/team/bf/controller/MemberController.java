package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.team.bf.service.MemberService;
import com.team.bf.vo.MemberVO;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class MemberController {
    @Inject
    MemberService memberService;

    @GetMapping("/login")
    public ModelAndView login(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("member/login");
        return mav;
    }
    
    @PostMapping("/login")
    public ResponseEntity<HashMap<String,String>> loginReq(MemberVO mvo, HttpSession session){
        
        ResponseEntity<HashMap<String,String>> entity = null;
        HashMap<String,String> result = new HashMap<>();
        
        MemberVO mvoOrigin = memberService.memberSelectById(mvo.getUserid());
        
        //아이디가 존재하지 않음
        if(mvoOrigin == null){
            System.out.println("로그인 실패");
            result.put("msg","일치하는 아이디가 없습니다.");
            result.put("status","200");
            result.put("redirect", "/login");
            entity = new ResponseEntity<>(result,HttpStatus.OK);
            session.setAttribute("logId", mvo.getUserid());
        }
        else if(mvoOrigin.getUserid().equals(mvo.getUserid())){
            if(mvoOrigin.getUserpassword().equals(mvo.getUserpassword())){
            	System.out.println("로그인 성공");
                result.put("msg","로그인 성공");
                result.put("status","200");
                result.put("redirect", "/");
                entity = new ResponseEntity<>(result,HttpStatus.OK);
                session.setAttribute("logId", mvo.getUserid());
            }
            else{
                System.out.println("로그인 실패");
                result.put("msg","비밀번호가 일치하지 않습니다.");
                result.put("status","200");
                result.put("redirect", "/login");
                entity = new ResponseEntity<>(result,HttpStatus.OK);
                session.setAttribute("logId", mvo.getUserid());
            }
          
        }
        else{
        	 System.out.println("로그인 실패");
             result.put("msg","로그인 실패...");
             result.put("status","400");
             result.put("redirect", "/");
             entity = new ResponseEntity<>(result,HttpStatus.BAD_REQUEST);
        }

        return entity;
    }
    @PostMapping("/logout")
    public ModelAndView logout(HttpSession session){

        ModelAndView mav = new ModelAndView();
        mav.setViewName("home");
        session.invalidate();
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

    @GetMapping("/mypage")
    public ModelAndView mypage(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mypage/mypage");
        return mav;
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
    		result.put("status", "200");
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
	    		result.put("newpassowrd", initPassword);
	    		result.put("redirect", "/login");
	        	result.put("status","200");
	        	entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		else{
	        	result.put("msg", "일치하는 결과가 없습니다. 입력한 정볼르 확인해 주세요");
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



    @PostMapping("/signup")
    public ResponseEntity<HashMap<String,String>> signup(MemberVO mvo, HttpSession session){
        System.out.println("signup :  시작" );
        HashMap<String, String> result = new HashMap<>();
        ResponseEntity<HashMap<String, String>> entity = null;
        try{
            if(memberService.memberInsert(mvo) > 0){
                //session에 userid를 저장
                session.setAttribute("logId", mvo.getUserid());
                result.put("msg","회원가입 완료");
                result.put("status","200");
                result.put("redirect","/login");
                entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
            }
            else{
                result.put("msg","회원가입 실패");
                result.put("status","400");
                result.put("redirect","/");
                entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
            }
        }catch(Exception e){
            e.printStackTrace();
            result.put("msg","회원가입 실패");
            result.put("status","400");
            result.put("redirect","/");
            entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
        }
        return entity;
    }
    
    @PostMapping("/signup/memberIdCheck")
    public int memberIdCheck(String userid) {
    	return memberService.memberUseridCheck(userid);
    }
}
