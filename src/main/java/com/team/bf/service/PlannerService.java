package com.team.bf.service;

import java.util.List;

import com.team.bf.vo.PlannerLocationVO;
import com.team.bf.vo.PlannerVO;

public interface PlannerService {
	public int plannerInsert(PlannerVO vo);
	public int plannerLocationInsert(int planner_no,  PlannerLocationVO[] voList);
}
