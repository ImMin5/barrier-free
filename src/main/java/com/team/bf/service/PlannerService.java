package com.team.bf.service;

import java.util.List;

import com.team.bf.vo.PlannerLocationVO;
import com.team.bf.vo.PlannerMemberVO;
import com.team.bf.vo.PlannerVO;

public interface PlannerService {
	public int plannerInsert(PlannerVO vo);
	public int plannerLocationInsert(List<PlannerLocationVO> list, int planner_no);
	public int plannerInsertTest(int planner_no, String contentid, PlannerVO vo);
	public int plannerUpdate(PlannerVO vo);
	public int plannerDelete(int no);
	public PlannerVO plannerSelectByNoId(int no, String userid);
	public List<PlannerVO> plannerSelectById(String userid);
	public PlannerVO plannerSelectOne(int no, String userid);
	
	public int plannerLocationDeleteByPlannerNo(int planner_no);
	
	public List<String>plannerMemberSelectByNo(int no);
	public int plannerMemberSelectByNoId(int planner_no,String userid);
	public int plannerMemberInsert(int planner_no, String userid);
	public int plannerMemberDeleteByNo(int no);
	public List<String> plannerLocationSelectByNo(int no);
	public PlannerMemberVO plannerMemberSelectById(int planner_no, String userid);
}
