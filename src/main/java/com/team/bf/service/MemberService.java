package com.team.bf.service;

import com.team.bf.vo.MemberVO;

public interface MemberService {
    public int memberInsert(MemberVO vo);
    public MemberVO memberSelectById(String userid);
}
