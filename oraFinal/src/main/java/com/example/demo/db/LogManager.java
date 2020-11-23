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
	
	public static void insertLog(LogVo log) {
		SqlSession session = sqlSessionFactory.openSession(true);
		session.insert("log.insertLog", log);
		session.close();
	}
	
	public static List<LogVo> getLogList(String code_value){
		List<LogVo> logList = null;
		SqlSession session = sqlSessionFactory.openSession();
		logList = session.selectList("log.selectCourseLog", code_value);
		session.close();
		
		return logList;
	}
}
