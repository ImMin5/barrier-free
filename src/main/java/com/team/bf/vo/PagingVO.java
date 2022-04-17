package com.team.bf.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PagingVO {
   
	private int onePageRecord = 10;
	private int pageNo = 1; 
	private int totalRecord;
	private int totalPage; 
	private int offsetIndex = 0;
	private int onePageCount = 5;
	private int startPage = 1;

	private String searchWord;
	
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
		
		offsetIndex = (pageNo-1)*onePageRecord;
		
		startPage = ((pageNo-1)/onePageCount*onePageCount)+1;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		
		if(totalRecord%onePageRecord==0) {
			totalPage = totalRecord/onePageRecord;
		}else {
			totalPage = totalRecord/onePageRecord+1;
		}
	}

}
