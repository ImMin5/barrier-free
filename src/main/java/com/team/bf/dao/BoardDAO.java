package com.team.bf.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.bf.vo.BoardAndReply;
import com.team.bf.vo.BoardVO;
import com.team.bf.vo.PagingVO;

@Mapper
@Repository
public interface BoardDAO {
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
	//답변과 연동된 게시물 불러오기
	public ArrayList<BoardAndReply> boardAndReplySelectAll(PagingVO vo);
}
