package com.team.bf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.bf.vo.PlannerLocationVO;
import com.team.bf.vo.PlannerVO;

@Mapper
public interface PlannerDAO {
	public int plannerInsert(PlannerVO vo);
	public int plannerLocationInsert(int planner_no,  PlannerLocationVO[] voList);
	
}
