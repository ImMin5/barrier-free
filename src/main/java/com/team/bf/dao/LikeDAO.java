package com.team.bf.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface LikeDAO {
	public int likeInsert(String userid,String contentid);
	public int likeSelectOne(String userid, String contentid);
	public int likeDelete(String userid, String contentid);
	public int likeSelectAll(String contentid);
}
