package com.example.demo.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.ReviewVo;
import com.example.demo.vo.Review_fileVo;
import com.example.demo.vo.Review_repVo;
import com.example.demo.vo.Review_tempVo;

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
	public static List<ReviewVo> selectList(HashMap mybatis_map){
		List<ReviewVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("review.selectList", mybatis_map);
		session.close();
		for(ReviewVo r : list) {
			r.setRf(selectListFile(r.getR_no()));
	    }
		return list;
	}
	// 코스별 후기 조회수 상위3개 뽑아오기
	public static List<ReviewVo> getReviewByCno(int c_no){
		List<ReviewVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("review.selectOrderByHit", c_no);
		session.close();
		for(ReviewVo r : list) {
			r.setRf(selectListFile(r.getR_no()));
	    }
		return list;
	}
	
	//마이페이지 내후기
	public static List<ReviewVo> MyPageSelectList(HttpSession httpSession){
		List<ReviewVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		MemberVo m = (MemberVo)httpSession.getAttribute("m");
		list = session.selectList("review.myPageSelectList",m.getId());
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
	public static int count(HashMap mybatis_map) {
		int cnt = 0;
		SqlSession session = sqlSessionFactory.openSession();
		cnt = session.selectOne("review.count", mybatis_map);
		session.close();
		return cnt;
	}
	public static int nextRr_no() {
		int rr_no = 0;
		SqlSession session = sqlSessionFactory.openSession();
		rr_no = session.selectOne("review.nextRr_no");
		session.close();
		return rr_no;
	}
	public static int nextRr_step(int rr_ref) {
		int rr_step = 0;
		SqlSession session = sqlSessionFactory.openSession();
		rr_step = session.selectOne("review.nextRr_step", rr_ref);
		session.close();
		return rr_step;
	}
	public static int insertRep(Review_repVo rrvo) {
		int re = 0;
		System.out.println(rrvo);
		SqlSession session = sqlSessionFactory.openSession();
		re = session.insert("review.insertRep", rrvo);
		session.commit();
		session.close();
		return re;
	}
	public static int update(ReviewVo rvo) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.update("review.update", rvo);
		session.commit();
		session.close();
		return re;
	}
	public static int deleteFileOne(int rf_no) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.delete("review.deleteFileOne", rf_no);
		session.commit();
		session.close();
		return re;
	}
	public static Review_tempVo selectTemp(String id) {
		Review_tempVo rtvo = null;
		SqlSession session = sqlSessionFactory.openSession();
		rtvo = session.selectOne("review.selectTemp", id);
		session.close();
		return rtvo;
	}
	public static int insertTemp(Review_tempVo rtvo) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.insert("review.insertTemp", rtvo);
		session.commit();
		session.close();
		return re;
	}
	public static int updateTemp(Review_tempVo rtvo) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.update("review.updateTemp", rtvo);
		session.commit();
		session.close();
		return re;
	}
	public static int deleteTemp(String id) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.delete("review.deleteTemp", id);
		session.commit();
		session.close();
		return re;
	}
	public static int deleteRepOne(int rr_no) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.delete("review.deleteRepOne", rr_no);
		session.commit();
		session.close();
		return re;
	}
	public static int updateRep(Review_repVo rrvo) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.update("review.updateRep", rrvo);
		session.commit();
		session.close();
		return re;
	}
	
	// 로그기록 댓글 삭제전 아이디 가져오기위해
	public static Review_repVo getReviewRepOne(int rr_no) {
		SqlSession session = sqlSessionFactory.openSession();
		Review_repVo rrvo = session.selectOne("review.selectReviewRep",rr_no);
		session.close();
		
		return rrvo;
	}
}
