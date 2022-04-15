package com.team.bf.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.LikeDAO;

@Service
public class LikeServiceImpl implements LikeService{
	@Inject
	LikeDAO dao;
	public int likeInsert(String userid,String contentid) {
		return dao.likeInsert(userid, contentid);
	}
	@Override
	public int likeSelectOne(String userid, String contentid) {
		return dao.likeSelectOne(userid, contentid);
	}
	@Override
	public int likeDelete(String userid, String contentid) {
		return dao.likeDelete(userid, contentid);
	}
	@Override
	public int likeSelectAll(String contentid) {
		return dao.likeSelectAll(contentid);
	}
}
