package com.team.bf.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.ReviewDAO;
import com.team.bf.vo.ReviewVO;

@Service
public class ReviewService {
	@Inject
	ReviewDAO dao;
	
	public int reviewInsert(ReviewVO vo) {
		return dao.reviewInsert(vo);
	}
	
}
