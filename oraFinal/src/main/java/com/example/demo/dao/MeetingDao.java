package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.MeetingManager;
import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.Meeting_fileVo;
import com.example.demo.vo.Meeting_peopleVo;
import com.example.demo.vo.Meeting_repVo;
import com.example.demo.vo.Meeting_tempVo;

@Repository
public class MeetingDao {
	
	// meeting
	public List<MeetingVo> listMeeting(HashMap map){
		return MeetingManager.listMeeting(map);
	}
	
	public MeetingVo detailMeeting(int m_no) {
		return MeetingManager.detailMeeting(m_no);
	}
  
	public int insertMeeting(MeetingVo m) {
		return MeetingManager.insertMeeting(m);
	}

	public Meeting_repVo getMRep(int mr_no) {
		return MeetingManager.getMRep(mr_no);
	}
	
	public int updateMeeting(MeetingVo m) {
		return MeetingManager.updateMeeting(m);
	}
	
	public int deleteMeeting(int m_no) {
		return MeetingManager.deleteMeeting(m_no);
	}
	
	public int NextMNum() {
		return MeetingManager.nextMeetingNum();
	}
	
	public int updateHit(int m_no) {
		return MeetingManager.updateHit(m_no);
	}
	
	public int totMRecord(String id) {
		return MeetingManager.totMRecord(id);
	}
	
	// meeting_file
	public List<Meeting_fileVo> detailMFile(int m_no) {
		return MeetingManager.detailMFile(m_no);
	}
    
	public int insertMFile(Meeting_fileVo mfvo) {
		return MeetingManager.insertMFile(mfvo);
	}

	public int updateMRep(Meeting_repVo mr) {
		return MeetingManager.updateMRep(mr);
	}
	
	public int updateMFile(Meeting_fileVo mf) {
		return MeetingManager.updateMFile(mf);
	}
	
	public int deleteMFile(int m_no) {
		return MeetingManager.deleteMFile(m_no);
	}
	

	public int NextMfNum() {
		return MeetingManager.nextMFileNum();
  }

	
	// meeting_rep
	public List<Meeting_repVo> detailMRep(HashMap map) {
		return MeetingManager.detailMRep(map);
	}
	
	public int insertMRep(Meeting_repVo mr) {
		return MeetingManager.insertMRep(mr);
	}
	// 댓글 전체삭제
	public int deleteMRep(int m_no) {
		return MeetingManager.deleteMRep(m_no);
	}
	
	// 댓글 한개삭제
	public int deleteMrOne(int mr_no) {
		return MeetingManager.deleteMrOne(mr_no);
	}
	
	public int NextMrNum() {
		return MeetingManager.nextMRepNum();
	}

	public int cntRep(int m_no) {
		return MeetingManager.cntRep(m_no);
	}
	
	public int myTotMRecord(String id) {
		return MeetingManager.myTotMRecord(id);
	}
	public List<MeetingVo> myPageListMeeting(HashMap map){
		return MeetingManager.myPageListMeeting(map);
	}
	// meeting_people
	public List<Meeting_peopleVo> detailMPeople(int m_no) {
		return MeetingManager.detailMPeople(m_no);
	}
	
	public int insertMPeople(Meeting_peopleVo mp) {
		return MeetingManager.insertMPeople(mp);
	}
	
	public int deleteOneMp(Meeting_peopleVo mp) {
		return MeetingManager.deleteOneMp(mp);
	}
	
	public int deleteMPeople(int m_no) {
		return MeetingManager.deleteMPeople(m_no);
	}

	public int nextStep(int mr_ref) {
		return MeetingManager.nextStep(mr_ref);
	}
	
	public Meeting_tempVo selectTemp(String id) {
		return MeetingManager.selectTemp(id);
	}
	
	public int insertTempId(String id) {
		return MeetingManager.insertTempId(id);
	}
	
	public int updateTemp(Meeting_tempVo mtvo) {
		return MeetingManager.updateTemp(mtvo);
	}
	
	public int deleteTemp(String id) {
		return MeetingManager.deleteTemp(id);
	}
	
	public int deleteMfOne(int mf_no) {
		return MeetingManager.deleteMfOne(mf_no);
	}
	
	// 로그기록중 댓글삭제전 아이디 가져오기위헤
	public Meeting_repVo getMeetingRepOne(int mr_no) {
		return MeetingManager.getMeetingRepOne(mr_no);
	}
}
