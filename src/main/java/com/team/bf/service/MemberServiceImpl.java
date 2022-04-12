package com.team.bf.service;

import javax.inject.Inject;

import com.team.bf.dao.MemberDAO;
import com.team.bf.vo.MemberVO;

import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService{
    @Inject
    MemberDAO dao;

    @Override
    public int memberInsert(MemberVO vo) {
       return dao.memberInsert(vo);    
    }

    @Override
    public MemberVO memberSelectById(String userid) {
        return dao.memberSelectById(userid);
    }

    @Override
    public int memberDelete(String userid, String password) {
        return dao.memberDelete(userid,password);
    }

	@Override
	public int memberUseridCheck(String userid) {
		return dao.memberUseridCheck(userid);
	}
    
    
}
