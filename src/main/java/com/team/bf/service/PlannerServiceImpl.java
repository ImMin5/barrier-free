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
	public PlannerVO plannerSelectByNo(int no, String userid) {
		return dao.plannerSelectByNo(no, userid);
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



	

}
