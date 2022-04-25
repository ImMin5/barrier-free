package com.team.bf.service;

import java.util.List;

import com.team.bf.vo.SuggestionVO;

import com.team.bf.vo.PagingVO;

public interface SuggestionService {
	public int suggestionInsert(SuggestionVO vo);
	public List<SuggestionVO> suggestionList(PagingVO pVO);
	public int totalRecord(PagingVO vo);
	public SuggestionVO suggestionSelectByNo(int no);
	public SuggestionVO suggestionSelect(int no);
	public int suggestionUpdate(SuggestionVO vo);
	public int suggestionDelete(String userid, Integer no);
	public SuggestionVO suggestionView(int no);
}

