package com.team.bf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.bf.vo.SuggestionVO;
import com.team.bf.vo.PagingVO;

@Mapper
@Repository
public interface SuggestionDAO {
	public int suggestionInsert(SuggestionVO vo);
	public List<SuggestionVO> suggestionList(PagingVO pVO);
	public int totalRecord(PagingVO vo);
	public SuggestionVO suggestionSelect(int no);
	public SuggestionVO suggestionSelectByNo(int no);
	public int suggestionUpdate(SuggestionVO vo);
	public int suggestionDelete(String userid, Integer no);
	public SuggestionVO suggestionView(int no);
}
