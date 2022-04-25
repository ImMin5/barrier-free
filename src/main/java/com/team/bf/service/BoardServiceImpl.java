package com.team.bf.service;

import java.util.ArrayList;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.BoardDAO;
import com.team.bf.vo.BoardAndReply;
import com.team.bf.vo.BoardVO;
import com.team.bf.vo.PagingVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	BoardDAO dao;
	
	@Override
	public int boardInsert(BoardVO vo) {
		return dao.boardInsert(vo);
	}

	@Override
	public int totalRecord(PagingVO vo) {
		return dao.totalRecord(vo);
	}

	@Override
	public ArrayList<BoardVO> boardSelectAll(PagingVO vo) {
		return dao.boardSelectAll(vo);
	}

	@Override
	public BoardVO boardSelectByNo(int no) {
		return dao.boardSelectByNo(no);
	}

	@Override
	public ArrayList<BoardVO> boardSelectNotice(int limit) {
		return dao.boardSelectNotice(limit);
	}

	@Override
	public int boardUpdate(BoardVO vo) {
		return dao.boardUpdate(vo);
	}

	@Override
	public int boardDelete(String userid, int no) {
		return dao.boardDelete(userid, no);
	}

	@Override
	public int boardReplyInsert(BoardVO vo) {
		return dao.boardReplyInsert(vo);
	}

	@Override
	public ArrayList<BoardAndReply> boardAndReplySelectAll(PagingVO vo) {
		return dao.boardAndReplySelectAll(vo);
	}

	@Override
	public ArrayList<BoardAndReply> boardAndReplySelectById(PagingVO vo, String userid) {
		return dao.boardAndReplySelectById(vo, userid);
	}

	@Override
	public BoardVO boardReplySelectByNo(int no) {
		return dao.boardReplySelectByNo(no);
	}

}
