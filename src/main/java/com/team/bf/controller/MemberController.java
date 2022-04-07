package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.team.bf.service.MemberService;
import com.team.bf.vo.MemberVO;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MemberController {
    @Inject
    MemberService memberService;

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
}
