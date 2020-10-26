package com.example.demo.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.Meeting_fileVo;
import com.example.demo.vo.Meeting_repVo;
import com.example.demo.vo.MeetingVo;

public class MeetingManager {
	public static SqlSessionFactory sqlSessionFactory;
	static {
		try {
			String resource = "com/example/demo/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("meetingManager exp : "+e.getMessage());
			e.printStackTrace();
		}
	}
	
	// 게시글 번호
	public static int nextMeetingNum() {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("meeting.nextMNum");
		session.close();
		return n;
	}
	
	// 게시글 수
	public static int totMRecord() {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("meeting.totMRecord");
		session.close();
		return n;
	}
	
	// 게시글 리스트
	public static List<MeetingVo> listMeeting(HashMap map) {
		List<MeetingVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("meeting.selectMAll", map);
		session.close();
		return list;
	}
	
	// 게시글 상세
	public static MeetingVo detailMeeting(int m_no) {
		MeetingVo m = null;
		SqlSession session = sqlSessionFactory.openSession();
		//m.setM_hit(m_no);
		m = session.selectOne("meeting.selectMByNo", m_no);
		session.close();
		return m;
	}
	
	// 게시글 등록
	public static int insertMeeting(MeetingVo m) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.selectOne("meeting.insertM", m);
		session.close();
		return re;
	}
	
	// 게시글 삭제
	public static int deleteMeeting(int m_no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("meeting.deleteM", m_no);
		session.close();
		return re;
	}
	
	// 조회수
	public static int updateHit(int m_no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.update("meeting.updateHit", m_no);
		session.close();
		return re;
	}
	
	
	// 첨부파일 번호
	public static int nextMFileNum() {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("meeting.nextMfNum");
		session.close();
		return n;
	}
	
	// 첨부파일 상세
	public static List<Meeting_fileVo> detailMFile(int m_no) {
		List<Meeting_fileVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("meeting.selectMfByNo", m_no);
		for(Meeting_fileVo vo : list) {
			System.out.println(vo);
		}
		session.close();
		return list;
	}
	
	// 첨부파일 등록
	public static int insertMFile(Meeting_fileVo mf) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.selectOne("meeting.insertMf", mf);
		session.close();
		return re;
	}
	
	// 첨부파일 삭제
	public static int deleteMFile(int m_no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("meeting.deleteMf", m_no);
		session.close();
		return re;
	}
	
	
	
	// 댓글 번호
		public static int nextMRepNum() {
			int n = 0;
			SqlSession session = sqlSessionFactory.openSession();
			n = session.selectOne("meeting.nextMrNum");
			session.close();
			return n;
		}
	
	// 댓글수
	public static int cntRep(int m_no) {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("meeting.cntRep", m_no);
		session.close();
		return n;
	}
	
	// 댓글 출력
	public static List<Meeting_repVo> detailMRep(int m_no) {
		List<Meeting_repVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("meeting.selectMrByNo", m_no);
		session.close();
		return list;
	}
	
	// 댓글 달기
	public static int insertMRep(Meeting_repVo mr) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.selectOne("meeting.insertMr", mr);
		session.close();
		return re;
	}
	
	// 댓글 삭제
	public static int deleteMRep(int m_no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("meeting.deleteMr", m_no);
		session.close();
		return re;
	}
	
}
