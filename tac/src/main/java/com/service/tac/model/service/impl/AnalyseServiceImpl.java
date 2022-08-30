package com.service.tac.model.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.tac.model.mapper.AnalyseMapper;
import com.service.tac.model.service.AnalyseService;
import com.service.tac.model.vo.ConsumeAnalysis_Desc;
import com.service.tac.model.vo.ConsumeAnalysis_LargeSum;

@Service
public class AnalyseServiceImpl implements AnalyseService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<ConsumeAnalysis_LargeSum> AnalyseLC_SUM(String id) throws SQLException {
		ArrayList<ConsumeAnalysis_LargeSum> result = sqlSession.getMapper(AnalyseMapper.class).AnalyseLC_SUM(id);
		for(ConsumeAnalysis_LargeSum temp : result) {
			if ( temp.getCount() == 1 && temp.getSum() == 0 )
				temp.setCount(0);
		}
		return result;
	}

	@Override
	public ArrayList<ConsumeAnalysis_Desc> AnalyseLC_DESC(String id) throws SQLException {
		return sqlSession.getMapper(AnalyseMapper.class).AnalyseLC_DESC(id);
	}

}
