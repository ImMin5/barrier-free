package com.team.bf.dao;

import com.team.bf.vo.MemberVO;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MemberDAO {
    public int memberInsert(MemberVO vo);
    public MemberVO memberSelectById(String userid);
}
