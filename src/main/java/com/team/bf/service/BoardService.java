package com.team.bf.service;

import java.util.ArrayList;

import com.team.bf.vo.BoardAndReply;
import com.team.bf.vo.BoardVO;
import com.team.bf.vo.PagingVO;

public interface BoardService {
	public int boardInsert(BoardVO vo);
	public int totalRecord(PagingVO vo);
	public ArrayList<BoardVO> boardSelectAll(PagingVO vo);
	public BoardVO boardSelectByNo(int no);
	public ArrayList<BoardVO> boardSelectNotice(int limit);
	public int boardUpdate(BoardVO vo);
	public int boardDelete(String userid, int no);
	public ArrayList<BoardVO> boardSelectById(String userid);
	
	//관리자
	public int boardReplyInsert(BoardVO vo);
	
	//
	public ArrayList<BoardAndReply> boardAndReplySelectAll(PagingVO vo);
}
