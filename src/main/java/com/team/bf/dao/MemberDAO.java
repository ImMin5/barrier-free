package com.team.bf.dao;

import com.team.bf.vo.MemberVO;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MemberDAO {
    public int memberInsert(MemberVO vo);
    public MemberVO memberSelectById(String userid);
    public int memberDelete(String userid, String password);
    public int memberUseridCheck(String userid);
    public MemberVO memberSelectByUsername(String username, String date_birth);
}
