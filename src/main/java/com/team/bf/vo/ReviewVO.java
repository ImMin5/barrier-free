package com.team.bf.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewVO {
	private int no;
	private int score;
	private String userid;
	private String content;
	private String contentid;
	private String write_date;
	private String ip;
	private String contentTypeId;
	private String title;
}
