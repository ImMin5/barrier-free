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

	@Override
	public MemberVO memberSelectByUsername(String username, String date_birth) {
		return dao.memberSelectByUsername(username, date_birth);
	}

	@Override
	public MemberVO memberSelectByQuestion(String userid, String question, String answer) {
		return dao.memberSelectByQuestion(userid, question, answer);
	}

	@Override
	public int memberUpdatePassword(String userid, String password) {
		return dao.memberUpdatePassword(userid, password);
	}

	@Override
	public int memberUpdate(MemberVO vo) {
		return dao.memberUpdate(vo);
	}
    
    
}
