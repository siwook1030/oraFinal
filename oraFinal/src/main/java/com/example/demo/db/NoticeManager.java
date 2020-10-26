package com.example.demo.db;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.CodeVo;
import com.example.demo.vo.NoticeVo;

public class NoticeManager {

	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		try {
			String resource = "com/example/demo/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			System.out.println("NoticeManager 예외발생: " +e.getMessage());
		}
	}
	
	public static List<NoticeVo> listNotice(){
		List<NoticeVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("notice.listNotice");
		session.close();
		return list;
	}
	
	public static List<CodeVo> getBoardCategory(){
		List<CodeVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("notice.getBoardCategory");
		session.close();
		return list;
	}
	
	public static NoticeVo detailNotice(int n_no) {
		NoticeVo n = null;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("notice.detailNotice", n_no);
		session.close();
		return n;
	}
	
	public static int insertNotice(NoticeVo n) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("notice.insert", n);
		session.close();
		return re;
	}
}








