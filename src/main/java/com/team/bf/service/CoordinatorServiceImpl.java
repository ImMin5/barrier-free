package com.team.bf.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.bf.dao.CoordinatorDAO;
import com.team.bf.vo.CoordinatorVO;


@Service
public class CoordinatorServiceImpl implements CoordinatorService {
	
	@Inject
	CoordinatorDAO dao;
	
	
		@Override
		public int CoordiInsert(CoordinatorVO vo) {
			return dao.CoordiInsert(vo);
		}

				
		@Override
		public CoordinatorVO CoordinatorSelect(String coo_userid) {
			return dao.coordinatorSelect(coo_userid);
		}

		@Override
		public int CoordinatorUpdate(CoordinatorVO vo) {
			return dao.CoordinatorUpdate(vo);
		}

		@Override
		public int CoordiidCheck(String coo_userid) {
			return dao.CoordiidCheck(coo_userid);
		}
	}
