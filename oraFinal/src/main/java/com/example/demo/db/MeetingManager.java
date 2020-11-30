package com.example.demo.db;

import java.io.InputStream;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.example.demo.vo.Meeting_fileVo;
import com.example.demo.vo.Meeting_peopleVo;
import com.example.demo.vo.Meeting_repVo;
import com.example.demo.vo.Meeting_tempVo;
import com.example.demo.vo.Review_repVo;
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
	public static int totMRecord(String id) {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("meeting.totMRecord",id);
		session.close();
		return n;
	}
	
	// 글 작성 시간
	public static String getDate_diff_str(long date_diff, Date m_regdate) {
		if(date_diff > 2592000) {						// 30일 : 30*24*60*60
			return m_regdate.toString();
		} else if (date_diff > 86400) {					// 1일 : 24*60*60
			return (date_diff / 86400) + " 일 전";	
		} else if (date_diff > 3600) {					// 1시간 : 60*60
			return (date_diff / 3600) + " 시간 전";
		} else if (date_diff > 60) {					// 1분 : 60
			return (date_diff / 60) + " 분 전";
		} else {										// 1분 미만
			return "방금 전";
		}
	}
	
	// 게시글 리스트
	  public static List<MeetingVo> listMeeting(HashMap map) {
	      List<MeetingVo> list = null;
	      SqlSession session = sqlSessionFactory.openSession();
	      list = session.selectList("meeting.selectMAll",map);
	      session.close();
	      for(MeetingVo m : list) {
	    	  m.setMf(detailMFile(m.getM_no()));
	    	  m.setM_repCnt(cntRep(m.getM_no()));
	    	  m.setDate_diff_str(getDate_diff_str(m.getDate_diff(),m.getM_regdate()));
	      }
	      return list;
	   }
	
	// 게시글 상세
	public static MeetingVo detailMeeting(int m_no) {
		MeetingVo m = null;
		SqlSession session = sqlSessionFactory.openSession();
		m = session.selectOne("meeting.selectMByNo", m_no);
		session.close();
		return m;
	}
	
	// 게시글 등록
	public static int insertMeeting(MeetingVo m) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("meeting.insertM", m);
		session.close();
		return re;
	}
	
	// 게시글 수정
	public static int updateMeeting(MeetingVo m) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.update("meeting.updateM", m);
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
	
	// 모임인원 상세
	public static List<Meeting_peopleVo> detailMPeople(int m_no) {
		List<Meeting_peopleVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("meeting.selectMpByNo", m_no);
		session.close();
		return list;
	}
	
	// 모임인원 등록
	public static int insertMPeople(Meeting_peopleVo mp) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("meeting.insertMp", mp);
		session.close();
		return re;
	}
	
	//모임인원 한명삭제
	public static int deleteOneMp(Meeting_peopleVo mp) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("meeting.deleteOneMp", mp);
		session.close();
		return re;
	}
	
	// 모임인원 전체삭제
	public static int deleteMPeople(int m_no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("meeting.deleteMp", m_no);
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
//		for(Meeting_fileVo vo : list) {
//			System.out.println(vo);
//		}
		session.close();
		return list;
	}
	
	// 첨부파일 등록
	public static int insertMFile(Meeting_fileVo mfvo) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("meeting.insertMf", mfvo);
		session.close();
		return re;
	}
	
	// 첨부파일 수정
	public static int updateMFile(Meeting_fileVo mf) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.update("meeting.updateMf", mf);
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
	public static List<Meeting_repVo> detailMRep(HashMap map) {
		List<Meeting_repVo> list = null;
		SqlSession session = sqlSessionFactory.openSession();
		list = session.selectList("meeting.selectMrList", map);
		session.close();
		return list;
	}
	
	// 댓글 한개가져오기(수정위해서)
	public static Meeting_repVo getMRep(int mr_no) {
		Meeting_repVo mr = null;
		SqlSession session = sqlSessionFactory.openSession();
		mr = session.selectOne("meeting.selectMrByNo", mr_no);
		session.close();
		
		return mr;
	}
	
	// 댓글 달기
	public static int insertMRep(Meeting_repVo mr) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("meeting.insertMr", mr);
		session.close();
		return re;
	}
	
	// 댓글 수정
	public static int updateMRep(Meeting_repVo mr) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.insert("meeting.updateMr", mr);
		session.close();
		return re;
	}
	
	// 댓글 전체삭제
	public static int deleteMRep(int m_no) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession(true);
		re = session.delete("meeting.deleteMr", m_no);
		session.close();
		return re;
	}
	
	// 댓글 한개삭제
		public static int deleteMrOne(int mr_no) {
			int re = -1;
			SqlSession session = sqlSessionFactory.openSession(true);
			re = session.delete("meeting.deleteMrOne", mr_no);
			session.close();
			return re;
		}
	
	//마이페이지 토탈
	public static int myTotMRecord(String id) {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("meeting.MyTotMRecord",id);
		session.close();
		return n;
	}
	// 마이페이지 게시글 리스트
		public static List<MeetingVo> myPageListMeeting(HashMap map) {
			List<MeetingVo> list = null;
			SqlSession session = sqlSessionFactory.openSession();
			list = session.selectList("meeting.myPageSelectMAll", map);
			session.close();
			return list;
		}
	// 맥스 스텝값
	public static int nextStep(int mr_ref) {
		int n = 0;
		SqlSession session = sqlSessionFactory.openSession();
		n = session.selectOne("meeting.nextStep", mr_ref);
		session.close();
		return n;
	}
	
	public static Meeting_tempVo selectTemp(String id) {
		Meeting_tempVo mtvo = null;
		SqlSession session = sqlSessionFactory.openSession();
		mtvo = session.selectOne("meeting.selectTemp", id);
		session.close();
		return mtvo;
	}
	
	public static int insertTempId(String id) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.insert("meeting.insertTempId", id);
		session.commit();
		session.close();
		return re;
	}
	
	public static int updateTemp(Meeting_tempVo mtvo) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.update("meeting.updateTemp", mtvo);
		session.commit();
		session.close();
		return re;
	}
	
	public static int deleteTemp(String id) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.delete("meeting.deleteTemp", id);
		session.commit();
		session.close();
		return re;
	}
	
	public static int deleteMfOne(int mf_no) {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.delete("meeting.deleteMfOne", mf_no);
		session.commit();
		session.close();
		return re;
	}
	
	// 로그기록중 댓글삭제전 아이디 가져오기위해
	public static Meeting_repVo getMeetingRepOne(int mr_no) {
		
		SqlSession session = sqlSessionFactory.openSession();
		Meeting_repVo mrvo = session.selectOne("meeting.selectMeetingRepOne", mr_no);
		session.close();
		
		return mrvo;
	}
}
