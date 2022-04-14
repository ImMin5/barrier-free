package com.team.bf.service;

public interface LikeService {
	public int likeInsert(String userid,String contentid);
	public int likeSelectOne(String userid, String contentid);
	public int likeDelete(String userid, String contentid);
	public int likeSelectAll(String contentid);
}
