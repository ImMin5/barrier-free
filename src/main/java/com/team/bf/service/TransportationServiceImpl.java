package com.team.bf.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.TransportationDAO;
import com.team.bf.vo.PagingVO;
import com.team.bf.vo.TransportationVO;


@Service
public class TransportationServiceImpl implements TransportationService {
	
	@Inject
	TransportationDAO dao;
	
	
	
	
	@Override
	public int transportationInsert(TransportationVO vo) {
	return dao.transportationInsert(vo);
	
	}
	
	@Override
	public List<TransportationVO> transportationList(PagingVO pVO) {
	return dao.transportationList(pVO);
	
	}
	
	public TransportationVO transportationView(int no) {
	return dao.transportationView(no);
	
	}
	
	
	
	public int transportationDelete(String title, int no) {
	return dao.transportationDelete(title, no);
	
	}
	
	
	public TransportationVO transportationSelect(int no) {
	return dao. transportationSelect(no);
	
	}
	
	public TransportationVO transportationSelectByNo(int no) {
	return dao. transportationSelectByNo(no);
	}
	
	public int transportationUpdate(TransportationVO vo) {
	return dao. transportationUpdate(vo);

}
	public List<TransportationVO> transportationSelectAll() {
	return dao. transportationSelectAll();
	}
	
	
	
	
	
}	