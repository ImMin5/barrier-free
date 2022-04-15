package com.team.bf.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {
	private int no;
	private String userid;
	private String subject;
	private String content;
	private boolean is_notice;
	private String write_date;
	private String ip;
}
