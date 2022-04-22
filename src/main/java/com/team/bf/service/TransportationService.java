package com.team.bf.service;

import java.util.List;


import com.team.bf.vo.PagingVO;
import com.team.bf.vo.TransportationVO;

public interface TransportationService {
	public int transportationInsert(TransportationVO vo);
	public List<TransportationVO> transportationList(PagingVO pVO);
	public TransportationVO transportationView(int no);
	public int transportationDelete(String title, int no);
	public TransportationVO transportationSelect(int no);
	public TransportationVO transportationSelectByNo(int no);
	public int transportationUpdate(TransportationVO vo);
	public List<TransportationVO> transportationSelectAll();

}
