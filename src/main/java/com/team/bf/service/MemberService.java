package com.team.bf.service;

import com.team.bf.vo.MemberVO;

public interface MemberService {
    public int memberInsert(MemberVO vo);
    public MemberVO memberSelectById(String userid);
    public int memberDelete(String userid, String password);
    public int memberUseridCheck(String userid);
    public MemberVO memberSelectByUsername(String username, String date_birth);
}
