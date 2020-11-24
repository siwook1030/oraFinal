package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.demo.db.LogManager;
import com.example.demo.vo.LogVo;

@Repository
public class LogDao {
	
	// 로그기록 저장
	public void insertLog(LogVo log) {
		LogManager.insertLog(log);
	}
	
	// 로그기록 갖고오기
	public List<LogVo> getLogList(String code_value){
		return LogManager.getLogList(code_value);
	}
	
	// 전체회원수 갖고오기
	public int getMemberAllCnt(int day) {	
		return LogManager.getMemberAllCnt(day);
	}
	
	// 전체코스수 갖고오기
	public int getCourseAllCnt(int day) {
		return LogManager.getCourseAllCnt(day);
	}
	
	// 전체리뷰게시물 수 갖고오기
	public int getReviewAllCnt(int day) {
		return LogManager.getReviewAllCnt(day);
	}
	
	// 전체번개게시물 수 갖고오기
	public int getMeetingAllCnt(int day) {
		return LogManager.getMeetingAllCnt(day);
	}

}
