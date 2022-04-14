package com.team.bf.service;

import java.util.List;

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
	public ReviewVO reviewSelectByNo(int no) {
		return dao.reviewSelectByNo(no);
	}
	public int reviewUpdate(ReviewVO vo) {
		return dao.reviewUpdate(vo);
	}
	public int reviewDelete(ReviewVO vo) {
		return dao.reviewDelete(vo);
	}
	public List<ReviewVO> reviewSelectById(String userid){
		return dao.reviewSelectById(userid);
	}
	public List<ReviewVO> reviewSelectByContentid(String contentid){
		return dao.reviewSelectByContentid(contentid);
	}
	public Float reviewSelectAvgScore(String contentid) {
		return dao.reviewSelectAvgScore(contentid);
	}
}
