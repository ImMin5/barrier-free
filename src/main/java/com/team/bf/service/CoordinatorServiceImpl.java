package com.team.bf.service;

import java.util.List;

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
		
		@Override
		public CoordinatorVO CoordinatorSelectBycoo_Id(String coo_userid) {
			return dao.CoordinatorSelectBycoo_Id(coo_userid);
		}

		@Override
		public CoordinatorVO coordiloginCheck(CoordinatorVO vo) {
			return dao.coordiloginCheck(vo);
			
		}


		@Override
		public List<CoordinatorVO> coordinatorSelectAll() {
			return dao.coordinatorSelectAll();
		}
		
		
		
}
