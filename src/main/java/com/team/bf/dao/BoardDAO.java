package com.team.bf.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.bf.vo.BoardVO;
import com.team.bf.vo.PagingVO;

@Mapper
@Repository
public interface BoardDAO {
	public int boardInsert(BoardVO vo);
	public int totalRecord(PagingVO vo);
	public ArrayList<BoardVO> boardSelectAll(PagingVO vo);
}
