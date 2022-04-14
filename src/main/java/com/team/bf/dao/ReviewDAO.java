package com.team.bf.dao;

import org.apache.ibatis.annotations.Mapper;

import com.team.bf.vo.ReviewVO;

@Mapper
public interface ReviewDAO {
	public int reviewInsert(ReviewVO vo);
}
