package com.service.tac.model.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.tac.model.dao.ConsumeDAO;
import com.service.tac.model.mapper.ConsumeMapper;
import com.service.tac.model.service.ConsumeService;
import com.service.tac.model.vo.Consume;

@Service
public class ConsumeServiceImpl implements ConsumeService {
	
	@Autowired
	private ConsumeDAO consumeDAO;

	@Override
	public int addConsumeInfo(Consume consume) throws SQLException {
		return consumeDAO.addConsumeInfo(consume);
	}

	@Override
	public ArrayList<HashMap<String, Object>> getConsume(String memberId) throws SQLException {
		return consumeDAO.getConsume(memberId);
	}

	@Override
	public int updateConsumeInfo(Consume consume) throws SQLException {
		return consumeDAO.updateConsumeInfo(consume);
	}

	@Override
	public int deleteConsumeInfo(int consumeId) throws SQLException {
		return consumeDAO.deleteConsumeInfo(consumeId);
	}

}
