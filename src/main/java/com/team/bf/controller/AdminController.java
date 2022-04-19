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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.bf.service.BoardService;
import com.team.bf.service.HeartService;
import com.team.bf.service.LikeService;
import com.team.bf.service.MemberService;
import com.team.bf.service.OpenApiService;
import com.team.bf.service.PlannerService;
import com.team.bf.service.ReviewService;
import com.team.bf.vo.BoardVO;
import com.team.bf.vo.MemberVO;
import com.team.bf.vo.PagingVO;

@RestController
public class AdminController {
	
	
	@Inject
	BoardService boardService;
	
	@Inject
	MemberService memberService;
	
	@GetMapping("/admin")
	public ModelAndView adminLoginView(HttpSession session){
		ModelAndView mav = new ModelAndView();
		String adminStatus = (String)session.getAttribute("adminStatus");
		try {
			if(adminStatus != null && adminStatus.equals("Y")) {
				mav.setViewName("redirect:/admin/boardList");
			}
			else {
				mav.setViewName("admin/login");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	@PostMapping("/admin")
	public ModelAndView adminLogin(MemberVO mvo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminStatus = (String)session.getAttribute("adminStatus");
		String userid  = (String)session.getAttribute("logId");
		try {
			
			if(memberService.memberLogin(mvo.getUserid(), mvo.getUserpassword()) != null) {
				session.setAttribute("logId", mvo.getUserid());
				session.setAttribute("adminStatus", "Y");
				mav.setViewName("redirect:/admin/boardList");
			}
			else {
				mav.setViewName("redirect:/admin");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//공지/문의사항 리스트 뷰
	@GetMapping("/admin/boardList")
	public ModelAndView adminBoardList(HttpSession session, @RequestParam(value="pageNo",required = false, defaultValue = "1")int pageNo, @RequestParam(value="pageCount",required = false, defaultValue = "10")int pageCount, @RequestParam(value="searchWord",required = false, defaultValue = "")String searchWord) {
		ModelAndView mav = new ModelAndView();
		try {
			PagingVO pvo = new PagingVO();
			//검색어가 있을 경우
	        if(!searchWord.equals("")) 
	        	pvo.setSearchWord(searchWord);
	        //전체 게시글 업데이트
	        pvo.setOnePageRecord(pageCount);
	        pvo.setTotalRecord(boardService.totalRecord(pvo));
	        pvo.setPageNo(pageNo);
	        //게시글
	        mav.addObject("boardList",boardService.boardAndReplySelectAll(pvo));
	        //공지사항
	        mav.addObject("noticeList",boardService.boardSelectNotice(5));
	        //페이징 정보
	        mav.addObject("pvo",pvo);
			mav.setViewName("admin/board");
		}catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:admin/boardList");
		}
		
		return mav;
	}
	
	//회원관리 리스트 뷰
	@GetMapping("/admin/memberList")
	public ModelAndView adminMemberList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		try {
			mav.addObject("memberList", memberService.memberSelectAll());
			mav.setViewName("/admin/memberList");
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		return mav;
	}
	
	
	 //관리자 회원정보 변경
    @PutMapping("/admin/memberList")
    public String adminMemberEdti(MemberVO mvo, HttpSession session) {
    	String msg = null;
    	try {
    		if(memberService.memberUpdateByAdmin(mvo) > 0) {
    			msg="회원정보 변경 성공";
    		}
    		else {
    			msg="회원정보 변경 실패";
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	return msg;
    }
    //관리자 회원 삭제
    @DeleteMapping("/admin/memberList")
    public String adminMemberDelete(MemberVO mvo) {
    	String msg = "";
    	try {
    		if(memberService.memberDelete(mvo.getUserid(), mvo.getUserpassword()) > 0) {
    			msg = "회원 삭제 성공";
    		}
    		else {
    			msg = "회원 삭제 실패";
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return msg;
    }
}