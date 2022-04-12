package com.team.bf.service;

import java.util.ArrayList;

import com.team.bf.vo.BoardVO;
import com.team.bf.vo.PagingVO;

public interface BoardService {
	public int boardInsert(BoardVO vo);
	public int totalRecord(PagingVO vo);
	public ArrayList<BoardVO> boardSelectAll(PagingVO vo);
}
