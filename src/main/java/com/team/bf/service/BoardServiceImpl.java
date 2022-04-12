package com.team.bf.service;

import java.util.ArrayList;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.BoardDAO;
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

}
