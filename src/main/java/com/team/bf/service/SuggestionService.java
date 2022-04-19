package com.team.bf.service;

import java.util.List;

import com.team.bf.vo.SuggestionVO;
import com.team.bf.vo.PagingVO;

public interface SuggestionService {
	
	public int suggestionInsert(SuggestionVO vo);
	
	public List<SuggestionVO> suggestionList(PagingVO pVO);
	
	public int totalRecord(PagingVO pVO);

	public SuggestionVO suggestionSelect(int no);
	
	public void hitCount(int no);
	
	public int suggestionUpdate(SuggestionVO vo);
	
	public int suggestionDelete(int no, String userid);
}
