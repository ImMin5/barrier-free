package com.team.bf.vo;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlannerVO {
	private int no;
	private String userid;
	private String title;
	private String start_date;
	private String end_date;
	private String create_date;
	private String edit_date;

	private List<String> contentidList;
	private List<Integer> seqList;
	private List<String> memberList;
	private List<PlannerLocationVO> plList;
	
	
}
