package com.example.demo.dao;

import org.springframework.stereotype.Repository;

import com.example.demo.db.LogManager;
import com.example.demo.vo.LogVo;

@Repository
public class LogDao {
	
	public void insertLog(LogVo log) {
		LogManager.insertLog(log);
	}

}
