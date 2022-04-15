package com.team.bf.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface HeartDAO {
	public int heartInsert(String userid,String contentid);
	public int heartSelectOne(String userid, String contentid);
	public int heartDelete(String userid, String contentid);
	public int heartSelectAll(String contentid);
}
