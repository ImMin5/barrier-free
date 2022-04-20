package com.team.bf.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.PlannerDAO;
import com.team.bf.vo.PlannerLocationVO;
import com.team.bf.vo.PlannerVO;

@Service
public class PlannerServiceImpl implements PlannerService {

	@Inject
	PlannerDAO dao;
	
	@Override
	public int plannerInsert(PlannerVO vo) {
		return dao.plannerInsert(vo);
	}

	@Override
	public int plannerLocationInsert(List<PlannerLocationVO> list, int planner_no) {
		return dao.plannerLocationInsert(list, planner_no);
	}

	@Override
	public int plannerInsertTest(int planner_no, String contentid, PlannerVO vo) {
		return dao.plannerInsertTest(planner_no, contentid, vo);
	}

	@Override
	public PlannerVO plannerSelectByNoId(int no, String userid) {
		return dao.plannerSelectByNoId(no, userid);
	}

	@Override
	public int plannerUpdate(PlannerVO vo) {
		return dao.plannerUpdate(vo);
	}

	@Override
	public int plannerLocationDeleteByPlannerNo(int planner_no) {
		return dao.plannerLocationDeleteByPlannerNo(planner_no);
	}

	@Override
	public int plannerDelete(int no) {
		return dao.plannerDelete(no);
	}

	@Override
	public List<PlannerVO> plannerSelectById(String userid) {
		return dao.plannerSelectById(userid);
	}

	@Override
	public PlannerVO plannerSelectOne(int no, String userid) {
		return dao.plannerSelectOne(no, userid);
	}

	@Override
	public List<String> plannerMemberSelectByNo(int no) {
		return dao.plannerMemberSelectByNo(no);
	}

	@Override
	public int plannerMemberSelectByNoId(int planner_no, String userid) {
		return dao.plannerMemberSelectByNoId(planner_no, userid);
	}

	@Override
	public int plannerMemberInsert(int planner_no, String userid) {
		return dao.plannerMemberInsert(planner_no, userid);
	}

	@Override
	public int plannerMemberDeleteByNo(int no) {
		return dao.plannerMemberDeleteByNo(no);
	}

	@Override
	public List<String> plannerLocationSelectByNo(int no) {
		return dao.plannerLocationSelectByNo(no);
	}



	

}
