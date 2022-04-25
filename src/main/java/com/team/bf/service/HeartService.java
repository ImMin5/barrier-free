package com.team.bf.service;

public interface HeartService {
	public int heartInsert(String userid,String contentid);
	public int heartSelectOne(String userid, String contentid);
	public int heartDelete(String userid, String contentid);
	public int heartSelectAll(String contentid);
}
