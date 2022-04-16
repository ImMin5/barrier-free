package com.team.bf.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
public class PlannerLocationVO {
	private int no;
	private int planner_no;
	private String contentid;
	private int seq;
	private String create_date;
	private List<PlannerLocationVO> locations;
	
	public PlannerLocationVO(int planner_no, String contentid, int seq) {
		this.planner_no = planner_no;
		this.contentid = contentid;
		this.seq = seq;
	}
	
}
