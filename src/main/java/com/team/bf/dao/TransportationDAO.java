package com.team.bf.dao;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import com.team.bf.vo.PagingVO;
import com.team.bf.vo.TransportationVO;


@Mapper
@Repository
	
public interface TransportationDAO {
	public int transportationInsert(TransportationVO vo);
	public List<TransportationVO> transportationList(PagingVO pVO);
	public TransportationVO transportationView(int no);
	public int transportationDelete(String title, int no);
	public TransportationVO transportationSelect(int no);
	public TransportationVO transportationSelectByNo(int no);
	public int transportationUpdate(TransportationVO vo);
	public List<TransportationVO> transportationSelectAll();
}