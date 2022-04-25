package com.team.bf.service;

import java.util.List;

import com.team.bf.vo.MemberVO;

public interface MemberService {
    public int memberInsert(MemberVO vo);
    public MemberVO memberSelectById(String userid);
    public int memberDelete(String userid, String password);
    public int memberUseridCheck(String userid);
    public MemberVO memberSelectByUsername(String username, String date_birth);
    public MemberVO memberSelectByQuestion(String userid, String question, String answer);
    public int memberUpdatePassword(String userid, String password);
    public MemberVO memberLogin(String userid, String userpassowrd);
    public int memberUpdate(MemberVO vo);
    public List<MemberVO> memberSelectAll();
    public int memberUpdateByAdmin(MemberVO vo);
}
