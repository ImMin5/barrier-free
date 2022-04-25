package com.team.bf.service;


import java.util.List;

import com.team.bf.vo.CoordinatorVO;



public interface CoordinatorService {
	
	public int CoordiInsert(CoordinatorVO vo);
	public CoordinatorVO CoordinatorSelectBycoo_Id(String coo_userid);
	public CoordinatorVO CoordinatorSelect(String coo_userid);
	public int CoordinatorUpdate(CoordinatorVO vo);
	public int CoordiidCheck(String coo_userid);
	public CoordinatorVO coordiloginCheck(CoordinatorVO vo);
	public List<CoordinatorVO> coordinatorSelectAll();


}