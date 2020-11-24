package com.example.demo.db;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.CodeVo;
import com.example.demo.vo.NoticeVo;
import com.example.demo.vo.Notice_fileVo;

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
	
	public static int getNextNoticeNo() {
		int re = 1;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("notice.nextNoticeNo");
		session.close();
		return re;
		
	}

	public static List<NoticeVo> listNotice(HashMap map){
		List<NoticeVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("notice.listNotice",map);
		session.close();
		return list;
	}
	
	public static List<CodeVo> getBoardCategory(String code_type){
		List<CodeVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("notice.getBoardCategory", code_type);
		session.close();
		return list;
	}
	
	public static int updateHit(int n_no) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.update("notice.updateHit", n_no);
		session.close();
		return re;
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
		re = session.insert("notice.insertNotice", n);
		session.close();
		return re;
	}
	
	public static int updateNotice(NoticeVo n) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("notice.updateNotice", n);
		session.close();
		return re;
	}
	
	public static int deleteNotice(int n_no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("notice.deleteNotice", n_no);
		session.close();
		return re;
	}
	
	public static NoticeVo selectByN_NO(int n_no) {
		NoticeVo n = null;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("notice.selectByN_NO", n_no);
		session.close();
		return n;
	}
	
	public static List<NoticeVo> searchNotice(HashMap map){
		List<NoticeVo> nList = null;
 		SqlSession session = sqlSessionFactory.openSession();
 		nList = session.selectList("notice.search", map);
		session.close();
		return nList;
	}
	
	// 게시글 수
		public static int totNRecord(HashMap map) {
			int re =  -1;
			SqlSession session 
			= sqlSessionFactory.openSession();
			re = session.selectOne("notice.totNRecord", map);
			session.close();
			return re;
		}
}








