package com.team.bf.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;



@Getter
@Setter
public class PlannerLocationVO {
	private int no;
	private int planner_no;
	private String contentid;
	private int order;
	private String create_date;
	private List<PlannerLocationVO> locations;
	
	public List<PlannerLocationVO> getLocations(){
		return locations;
	}
}
