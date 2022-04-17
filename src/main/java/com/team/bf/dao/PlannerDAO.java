package com.team.bf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.bf.vo.PlannerLocationVO;
import com.team.bf.vo.PlannerVO;

@Mapper
public interface PlannerDAO {
	public int plannerInsert(PlannerVO vo);
	public int plannerLocationInsert(List<PlannerLocationVO> list, int planner_no);
	public int plannerInsertTest(int planner_no, String contentid, PlannerVO vo);
	public int plannerUpdate(PlannerVO vo);
	public int plannerDelete(int no);
	
	public PlannerVO plannerSelectByNo(int no, String userid);
	public int plannerLocationDeleteByPlannerNo(int planner_no);
}
