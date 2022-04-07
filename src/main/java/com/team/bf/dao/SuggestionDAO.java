package com.team.bf.dao;

import java.util.List;

import com.team.bf.vo.PagingVO;
import com.team.bf.vo.SuggestionVO;

public interface SuggestionDAO {
	
	public int suggestionInsert(SuggestionVO vo);
	
	public List<SuggestionVO> SuggestionList(PagingVO pVO);
	
	public int totalRecord(PagingVO pVO);
	
	public SuggestionVO SuggestionSelect(int no);

	public void hitCount(int no);

	public int SuggestionUpdate(SuggestionVO vo);
	
	public int SuggestionDelete(int no, String userid);
}
