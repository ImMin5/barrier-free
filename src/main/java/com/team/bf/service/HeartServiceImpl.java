package com.team.bf.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.HeartDAO;

@Service
public class HeartServiceImpl implements HeartService{
	
	@Inject 
	HeartDAO dao;
	@Override
	public int heartInsert(String userid, String contentid) {
		return dao.heartInsert(userid, contentid);
	}

	@Override
	public int heartSelectOne(String userid, String contentid) {
		return dao.heartSelectOne(userid, contentid);
	}

	@Override
	public int heartDelete(String userid, String contentid) {
		return dao.heartDelete(userid, contentid);
	}

	@Override
	public int heartSelectAll(String contentid) {
		return dao.heartSelectAll(contentid);
	}

}
