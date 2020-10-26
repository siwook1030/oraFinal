package com.example.demo.db;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.ReviewVo;
import com.example.demo.vo.Review_fileVo;
import com.example.demo.vo.Review_repVo;

public class ReviewManager {
	static SqlSessionFactory sqlSessionFactory;
	static {
		try {
			String resource = "com/example/demo/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static List<ReviewVo> selectList(){
		List<ReviewVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("review.selectList");
		session.close();
		return list;
	}
	public static int incHit(int r_no) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.update("review.incHit", r_no);
		session.close();
		return re;
	}
	public static ReviewVo selectOne(int r_no) {
		ReviewVo vo = null;
		SqlSession session = sqlSessionFactory.openSession();
		vo = session.selectOne("review.selectOne", r_no);
		session.close();
		return vo;
	}
	public static List<Review_fileVo> selectListFile(int r_no){
		List<Review_fileVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("review.selectListFile", r_no);
		session.close();
		return list;
	}
	public static List<Review_repVo> selectListRep(int r_no){
		List<Review_repVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("review.selectListRep", r_no);
		session.close();
		return list;
	}
	public static int nextR_no() {
		int r_no = 0;
		SqlSession session = sqlSessionFactory.openSession();
		r_no = session.selectOne("review.nextR_no");
		session.close();
		return r_no;
	}
	public static int insert(ReviewVo vo) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("review.insert", vo);
		session.close();
		return re;
	}
	public static int insertFile(Review_fileVo vo) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("review.insertFile", vo);
		session.close();
		return re;
	}
	public static int nextRf_no() {
		int rf_no = 0;
		SqlSession session = sqlSessionFactory.openSession();
		rf_no = session.selectOne("review.nextRf_no");
		session.close();
		return rf_no;
	}
	public static int countRep(int r_no) {
		int cnt = 0;
		SqlSession session = sqlSessionFactory.openSession();
		cnt = session.selectOne("review.countRep", r_no);
		session.close();
		return cnt;
	}
	public static int delete(int r_no) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("review.delete", r_no);
		session.close();
		return re;
	}
	public static int deleteFile(int r_no) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("review.deleteFile", r_no);
		session.close();
		return re;
	}
	public static int deleteRep(int r_no) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("review.deleteRep", r_no);
		session.close();
		return re;
	}
}
