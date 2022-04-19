package com.team.bf.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.bf.vo.CoordinatorVO;


@Mapper
@Repository
public interface CoordinatorDAO {
	//코디 등록
	public int CoordiInsert(CoordinatorVO vo);
	//코디 로그인
	public CoordinatorVO coordiloginCheck(CoordinatorVO vo);
	//코디 정보 수정란
	public CoordinatorVO coordinatorSelect(String coordiid);
	
	public CoordinatorVO CoordinatorSelectBycoo_Id(String coo_userid);
	
	
	//DB에서 코디 정보 수정
	public int CoordinatorUpdate(CoordinatorVO vo);
	//코디네이터 아이디 중복 확인
	public int CoordiidCheck(String coordiid);
}