package com.team.bf.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.bf.service.BoardService;
import com.team.bf.vo.BoardVO;
import com.team.bf.vo.PagingVO;

@RestController
public class BoardController {
    
	@Inject 
	BoardService boardService;
	
    @GetMapping("/board/boardList")
    public ModelAndView boardView( @RequestParam(value="pageNo",required = false, defaultValue = "1")int pageNo, @RequestParam(value="pageCount",required = false, defaultValue = "10")int pageCount, @RequestParam(value="searchWord",required = false, defaultValue = "")String searchWord){
        ModelAndView mav = new ModelAndView();
        
        PagingVO pvo = new PagingVO();
        //검색어가 있을 경우
        if(searchWord.equals("") == false) 
        	pvo.setSearchWord(searchWord);
        //전체 게시글 업데이트
        pvo.setOnePageRecord(pageCount);
        pvo.setTotalRecord(boardService.totalRecord(pvo));
        pvo.setPageNo(pageNo);
        
        //게시글
        mav.addObject("boardList",boardService.boardSelectAll(pvo));
        //페이징 정보
        mav.addObject("pvo",pvo);
        mav.setViewName("community/board");
        return mav;
    }
    
    // 문의사항 글 생성 요청
    @PostMapping("/board/boardList")
    public ResponseEntity<HashMap<String,String>> boardInsert(BoardVO bvo, HttpServletRequest request, HttpSession session){
    	ResponseEntity<HashMap<String,String>> entity = null;
    	HashMap<String,String> result = new HashMap<String,String>();
    	
    	try {
    		//ip주소 
    		bvo.setIp(request.getRemoteAddr());
    		//일반회원 false, 관리자 true
        	bvo.set_notice(false);
        	//글 생성 
        	int r = boardService.boardInsert(bvo);
        	if(r> 0)
        		result.put("msg", "글 작성 성공");
        	else
        		result.put("msg", "글 작성 실패");;
    		
        	result.put("result",Integer.toString(r));
    		result.put("status", "200");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
    	}catch(Exception e) {
    		e.printStackTrace();
    		result.put("msg", "글 생성 요청...error");
    		result.put("status", "200");
    		entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
    		
    	}
    	
    	
    	return entity;
    }

    @GetMapping("/mypage/myreview")
    public ModelAndView myReview(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("");
        return mav;
    }
}
