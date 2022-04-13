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

        if(mvoOrigin == null){
            System.out.println("嚥≪뮄�젃占쎌뵥 占쎈뼄占쎈솭");
            result.put("msg","占쎌뵬燁살꼹釉�占쎈뮉 占쎈툡占쎌뵠占쎈탵揶쏉옙 占쎈씨占쎈뮸占쎈빍占쎈뼄.");
            result.put("status","200");
            result.put("redirect", "/login");
            entity = new ResponseEntity<>(result,HttpStatus.OK);
            session.setAttribute("logId", mvo.getUserid());
        }
        else if(mvoOrigin.getUserid().equals(mvo.getUserid())){
            if(mvoOrigin.getUserpassword().equals(mvo.getUserpassword())){
                System.out.println("嚥≪뮄�젃占쎌뵥 占쎄쉐�⑨옙");
                result.put("msg","嚥≪뮄�젃占쎌뵥 占쎄쉐�⑨옙");
                result.put("status","200");
                result.put("redirect", "/");
                entity = new ResponseEntity<>(result,HttpStatus.OK);
                session.setAttribute("logId", mvo.getUserid());
            }
            else{
                System.out.println("嚥≪뮄�젃占쎌뵥 占쎈뼄占쎈솭");
                result.put("msg","�뜮袁⑨옙甕곕뜇�깈揶쏉옙 占쎌뵬燁살꼹釉�筌욑옙 占쎈륫占쎈뮸占쎈빍占쎈뼄.");
                result.put("status","200");
                result.put("redirect", "/login");
                entity = new ResponseEntity<>(result,HttpStatus.OK);
                session.setAttribute("logId", mvo.getUserid());
            }
          
        }
        else{
            System.out.println("嚥≪뮄�젃占쎌뵥 占쎈뼄占쎈솭");
            result.put("msg","嚥≪뮄�젃占쎌뵥 占쎈뼄占쎈솭...");
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

    //占쎌돳占쎌뜚 占쎄퉱占쎈닚
    @DeleteMapping("/member")
    public ResponseEntity<HashMap<String,String>> memberDelete(HttpSession session, String userpassword){
        ResponseEntity<HashMap<String,String>> entity = null;
        HashMap<String,String> result = new HashMap<>();

        String userid = (String)session.getAttribute("logId");
        System.out.println("占쎄텣占쎌젫占쎈막 占쎈툡占쎌뵠占쎈탵 : " + userid);
        int count = memberService.memberDelete(userid, userpassword);
        if(count > 0){
            result.put("msg","占쎌돳占쎌뜚占쎄퉱占쎈닚 占쎄쉐�⑨옙");
            result.put("status","200");
            result.put("redirect","/");
            entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
            session.invalidate();
        }
        else{
            result.put("msg","占쎌돳占쎌뜚占쎄퉱占쎈닚 占쎈뼄占쎈솭");
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

    @GetMapping("/infopwd")
    public ModelAndView infoPasswordView(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("member/password");
        return mav;
    }
    @GetMapping("/infoid")
    public ModelAndView infoIdiew(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("member/id");
        return mav;
    }



    @PostMapping("/signup")
    public ResponseEntity<HashMap<String,String>> signup(MemberVO mvo, HttpSession session){
        System.out.println("signup :  占쎈뻻占쎌삂" );
        HashMap<String, String> result = new HashMap<>();
        ResponseEntity<HashMap<String, String>> entity = null;
        try{
            if(memberService.memberInsert(mvo) > 0){
                //session占쎈퓠 userid�몴占� 占쏙옙占쎌삢
                session.setAttribute("logId", mvo.getUserid());
                result.put("msg","占쎌돳占쎌뜚揶쏉옙占쎌뿯 占쎌끏�뙴占�");
                result.put("status","200");
                result.put("redirect","/login");
                entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
            }
            else{
                result.put("msg","占쎌돳占쎌뜚揶쏉옙占쎌뿯 占쎈뼄占쎈솭");
                result.put("status","400");
                result.put("redirect","/");
                entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
            }
            
        }catch(Exception e){
            e.printStackTrace();
            result.put("msg","占쎌돳占쎌뜚揶쏉옙占쎌뿯 占쎈뼄占쎈솭");
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
