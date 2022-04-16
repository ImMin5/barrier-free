package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.bf.service.BoardService;
import com.team.bf.service.MemberService;
import com.team.bf.vo.BoardVO;
import com.team.bf.vo.MemberVO;
import com.team.bf.vo.PagingVO;

@RestController
public class BoardController {
    
	@Inject 
	BoardService boardService;
	@Inject
	MemberService memberService;
	
	//공지/문의 사항 리스트 뷰
    @GetMapping("/board/boardList")
    public ModelAndView boardView( @RequestParam(value="pageNo",required = false, defaultValue = "1")int pageNo, @RequestParam(value="pageCount",required = false, defaultValue = "10")int pageCount, @RequestParam(value="searchWord",required = false, defaultValue = "")String searchWord){
        ModelAndView mav = new ModelAndView();
        
        PagingVO pvo = new PagingVO();
        //검색어가 있을 경우
        if(!searchWord.equals("")) 
        	pvo.setSearchWord(searchWord);
        //전체 게시글 업데이트
        pvo.setOnePageRecord(pageCount);
        pvo.setTotalRecord(boardService.totalRecord(pvo));
        pvo.setPageNo(pageNo);
        
        System.out.println("tlwkr");
        //게시글
        mav.addObject("boardList",boardService.boardAndReplySelectAll(pvo));
        //공지사항
        mav.addObject("noticeList",boardService.boardSelectNotice(5));
        //페이징 정보
        mav.addObject("pvo",pvo);
        mav.setViewName("community/board");
        return mav;
    }
    
    //문의사항 상세 뷰 
    @GetMapping("/board/boardList/{no}")
    public ModelAndView boardInfoView(@PathVariable(value="no")int no) {
    	ModelAndView mav  = new ModelAndView();
    	
    	try {
    		BoardVO bvo = boardService.boardSelectByNo(no);
    		if(bvo != null) {
    			mav.addObject("bvo",bvo);
    			mav.setViewName("community/boardDetail");
    		}
    		else {
    			//게시물이 존재 하지 않을 경우
    			System.out.println("존재하지 않는 게시물");
    			mav.setViewName("redirect:/board/boardList");
    		}
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    		mav.setViewName("redirect:/board/boardList");
    	}
    	return mav;
    }
    //문의사항 작성 폼 뷰
    @GetMapping("/board/boardList/form")
    public ModelAndView boardFormView(HttpSession session) {
    	ModelAndView mav = new ModelAndView();
    	String userid = (String)session.getAttribute("logId");
    	
    	try {
    		if(memberService.memberSelectById(userid) != null) {
    			mav.setViewName("community/boardForm");
    		}else{
    			System.out.println("회원가입 후 진행");
    			mav.setViewName("redirect:/board/boardList");
    		}
    	}catch(Exception e) {
    		//1.userid가 null일 경우
    		e.printStackTrace();
    		session.invalidate();
    		mav.setViewName("redirect:/");
    	}
    	return mav;
    	
    }
    //문의사항 수정 뷰
    @PostMapping("/board/boardList/edit/{no}")
    public ModelAndView boardEditView(@PathVariable(value="no")int no, HttpSession session) {
    	ModelAndView mav = new ModelAndView();
    	try {
	    	String userid = (String)session.getAttribute("logId"); 
	    	BoardVO bvo = boardService.boardSelectByNo(no);
	    	//작성자 본인 확인
	    	if(userid != null && bvo.getUserid().equals(userid) == true){
	    		mav.setViewName("community/boardEdit");
	    		mav.addObject("bvo",boardService.boardSelectByNo(no));
	    	}
	    	else {
	    		mav.setViewName("redirect:/board/boardList");
	    	}
    	}catch(Exception e) {
    		e.printStackTrace();
    		mav.setViewName("redirect:/board/boardList");
    	}
    	return mav;
    }
    //문의사항 상세정보 뷰
    @GetMapping("/board/boardList/{no}")
    public ModelAndView boardDetailView(@PathVariable(value="no")int no, HttpSession session) {
    	ModelAndView mav = new ModelAndView();
    	try {
	    	mav.addObject("bvo",boardService.boardSelectByNo(no));
	    	mav.setViewName("community/boardDetail");
    	}catch(Exception e) {
    		e.printStackTrace();
    		mav.setViewName("redirect:/board/boardList");
    	}
    	return mav;
    }

    
    //1. 문의사항 글 생성 요청
    @PostMapping("/board/boardList")
    public ResponseEntity<HashMap<String,String>> boardInsert(BoardVO bvo, HttpServletRequest request, HttpSession session){
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	String userid = (String)session.getAttribute("logId");
    	
    	try {
    		MemberVO mvo = memberService.memberSelectById(userid);
    		System.out.println("글 작성자 : " + userid);
    		
    		//ip주소 
    		bvo.setIp(request.getRemoteAddr());
    		
    		//일반회원,코디네이터 false, 관리자 true
    		if(mvo.getGrade_member() == 2) {
    			// 관리자 2
    			bvo.set_notice(true);
    		}
    		else {
    			// 일반회원1, 코디네이터 2
    			bvo.set_notice(false);
    		}
    		//글 생성 
        	int r = boardService.boardInsert(bvo);
        	
        	if(r> 0) {
        		result.put("msg", "글 작성 성공");
        		result.put("redirect", "/board/boardList/"+bvo.getNo());
        	}
        	else {
        		result.put("msg", "글 작성 실패");
        		result.put("redirect", "/board/boardList");
        	}
        	result.put("result",Integer.toString(r));
    		result.put("status", "200");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    	}catch(Exception e) {
    		//1. member 테이블에 id가 존재하지 않을경우 발생
    		e.printStackTrace();
    		result.put("msg", "글 생성 요청...error");
    		result.put("redirect", "/board/boardList");
    		result.put("status", "200");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);	
    	}
    	return entity;
    }
    
    //2. 문의사항 글 수정 요청
    @PutMapping("/board/boardList")
    public ResponseEntity<HashMap<String,String>> boardUpdate(BoardVO bvo, HttpServletRequest request, HttpSession session){
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	String userid = (String)session.getAttribute("logId");
    	
    	try { 	
    		if(boardService.boardSelectByNo(bvo.getNo()) == null) {
    			//수정할 게시글이 존재하지 않는 경우
    			result.put("status", "200");
    			result.put("msg", "존재하지 않는 게시물 입니다.");
    			result.put("redirect", "/board/boardList");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		//작성자가 다른경우
    		if(bvo.getUserid().equals(userid)== false) {
    			result.put("status", "200");
    			result.put("msg", "잘못된 접근입니다");
    			result.put("redirect", "/board/boardList");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		else {
    			bvo.setIp(request.getRemoteAddr());
    			boardService.boardUpdate(bvo);
    			result.put("status", "200");
    			result.put("msg", "글 수정 완료.");
    			result.put("redirect", "/board/boardList/"+bvo.getNo());
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    	}catch(Exception e) {
    		result.put("status", "400");
    		result.put("msg", "글 수정 요청 Error...");
    		result.put("redirect", "/board/boardList");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);	
    	}
    	
    	
    	return entity;
    }
    
    //3. 문의사항 글 삭제 요청
    @DeleteMapping("/board/boardList")
    public ResponseEntity<HashMap<String,String>> boardDelete(int no, HttpServletRequest request, HttpSession session){
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	String userid = (String)session.getAttribute("logId");
    	
    	try {
    		BoardVO bvo = boardService.boardSelectByNo(no);
    		//작성자가 다른경우
    		if(bvo.getUserid().equals(userid)== false) {
    			result.put("status", "200");
    			result.put("msg", "잘못된 접근입니다");
    			result.put("redirect", "/board/boardList");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		else {
    			boardService.boardDelete(bvo.getUserid(), bvo.getNo());
    			result.put("status", "200");
    			result.put("msg", "글 삭제 완료.");
    			result.put("redirect", "/board/boardList");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    	}catch(Exception e) {
    		//삭제할 게시글이 존재하지 않을 경우
    		//userid가 null일 경우 
    		e.printStackTrace();
    		result.put("status", "400");
    		result.put("msg", "글 삭제 요청 Error...");
    		result.put("redirect", "/board/boardList");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);	
    	}
    	return entity;
    }
    
    //4. 관리자 공지사항 생성요청
    @PostMapping("/admin/board/notice")
    public ResponseEntity<HashMap<String,String>> adminNoticeInsert(BoardVO bvo, HttpServletRequest request,HttpSession session ) {
    	return boardInsert(bvo,request, session);
    }
    
    //5. 관리자 문의사항 답변 생성
    @PostMapping("/admin/board/reply")
    public ResponseEntity<HashMap<String,String>> adminInsert(BoardVO bvo, HttpServletRequest request, HttpSession session){
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	String userid = (String)session.getAttribute("logId");
    	
    	
    	try {
    		System.out.println("답변자 : " + userid);
    		//답변할 글이 있는지 확인, 관리자가 아닌경우
    		if(boardService.boardSelectByNo(bvo.getNo()) == null) {
    			result.put("msg", "답변할 글이 없습니다.");
    			result.put("redirect", "/admin/board/boardList");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		else if(memberService.memberSelectById(userid).getGrade_member() != 2) {
    			result.put("msg", "잘못된 접근 입니다.");
    			result.put("redirect", "/admin/board/boardList");
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    		else {
    			//ip주소
    			bvo.setIp(request.getRemoteAddr());
    			boardService.boardReplyInsert(bvo);
    			result.put("msg", "문의사항 답변 완료");
    			result.put("redirect", "/admin/board/boardList/"+bvo.getNo());
    			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    		}
    	}catch(Exception e) {
    		//이미 완료한 답변을 새로 작성하려고 할때
    		e.printStackTrace();
    		result.put("msg", "문의사항 답변 Error...");
    		result.put("redirect", "/admin/board/boardList");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);	
    	}
    	
    	return entity;
    }
  
}
