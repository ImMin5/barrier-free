package com.team.bf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team.bf.vo.ReviewVO;

@Mapper
public interface ReviewDAO {
	public int reviewInsert(ReviewVO vo);
	public ReviewVO reviewSelectByNo(int no);
	public int reviewUpdate(ReviewVO vo);
	public int reviewDelete(ReviewVO vo);
	public List<ReviewVO> reviewSelectById(String userid);
	public List<ReviewVO> reviewSelectByContentid(String contentid);
}
