package com.team.bf.service;

import javax.inject.Inject;

import java.util.List;

import com.team.bf.dao.SuggestionDAO;
import com.team.bf.vo.PagingVO;
import com.team.bf.vo.SuggestionVO;

import org.springframework.stereotype.Service;

@Service
public class SuggestionServiceImpl implements SuggestionService {
	@Inject
	SuggestionDAO dao;
	
    @Override
	public int suggestionInsert(SuggestionVO vo) {
		return dao.suggestionInsert(vo);
	}
	@Override
	public List<SuggestionVO> suggestionList(PagingVO pVO) {
		//return dao.suggestionList(pVO);
	}
	@Override
	public int totalRecord(PagingVO pVO) {
		//return dao.totalRecord(pVO);
	}
	@Override
	public SuggestionVO suggestionSelect(int no) {
		//return dao.suggestionSelect(no);
	}
	@Override
	public void hitCount(int no) {
		//dao.hitCount(no);
	}
	@Override
	//public int suggestionUpdate(SuggestionVO vo) {
		//return dao.suggestionUpdate(vo);
	}
	@Override
	public int suggestionDelete(int no, String userid) {
		//return dao.suggestionDelete(no, userid);
	}
}