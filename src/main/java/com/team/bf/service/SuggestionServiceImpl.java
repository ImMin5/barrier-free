package com.team.bf.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.SuggestionDAO;
import com.team.bf.vo.SuggestionVO;
import com.team.bf.vo.PagingVO;

@Service
public class SuggestionServiceImpl implements SuggestionService {

	@Inject
	SuggestionDAO dao;
	
	@Override
	public int suggestionInsert(SuggestionVO vo) {
		return dao.suggestionInsert(vo);
	}

	@Override
	public List<SuggestionVO> suggestionList(PagingVO pVO){
		return dao.suggestionList(pVO);
	}
	@Override
	public SuggestionVO suggestionSelectByNo(int no) {
		return dao.suggestionSelectByNo(no);
	}	

	@Override
	public int totalRecord(PagingVO pVO) {
		return dao.totalRecord(pVO);
	}
	@Override
	public SuggestionVO suggestionSelect(int no) {
		return dao.suggestionSelect(no);
	}
	@Override
	public int suggestionUpdate(SuggestionVO vo) {
		return dao.suggestionUpdate(vo);
	}
	@Override
	public int suggestionDelete(String userid, Integer no) {
		return dao.suggestionDelete(userid, no);
	}
	@Override
	public SuggestionVO suggestionView(int no) {
		return dao.suggestionView(no);
	}
}