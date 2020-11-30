package com.example.demo.db;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.LogVo;

public class LogManager {
	
private static SqlSessionFactory sqlSessionFactory;
	
	static {
		try {
			String resource = "com/example/demo/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			System.out.println("로그매니저 예외 " +e.getMessage());
		}
	}
	
	// 로그기록 저장
	public static void insertLog(LogVo log) {
		SqlSession session = sqlSessionFactory.openSession(true);
		session.insert("log.insertLog", log);
		session.close();
	}
	
	// 로그기록 가져오기 코드밸류에따라 달라짐
	public static List<LogVo> getLogList(String code_value){
		List<LogVo> logList = null;
		SqlSession session = sqlSessionFactory.openSession();
		logList = session.selectList("log.selectCourseLog", code_value);
		session.close();
		
		return logList;
	}
	
	// 전체회원수 갖고오기
	public static int getMemberAllCnt(int day) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.selectOne("log.memberAllCnt", day);
		session.close();
		
		return cnt;
	}
	
	// 전체코스수 갖고오기
	public static int getCourseAllCnt(int day) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.selectOne("log.courseAllCnt", day);
		session.close();
		
		return cnt;
	}
	
	// 전체리뷰게시물 수 갖고오기
	public static int getReviewAllCnt(int day) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.selectOne("log.reviewAllCnt",day);
		session.close();
		
		return cnt;
	}
	
	// 전체번개게시물 수 갖고오기
	public static int getMeetingAllCnt(int day) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.selectOne("log.meetingAllCnt", day);
		session.close();
		
		return cnt;
	}
}
