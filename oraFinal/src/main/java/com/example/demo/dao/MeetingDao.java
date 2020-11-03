package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.MeetingManager;
import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.Meeting_fileVo;
import com.example.demo.vo.Meeting_peopleVo;
import com.example.demo.vo.Meeting_repVo;

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
	
	public int totMRecord() {
		return MeetingManager.totMRecord();
	}
	
	// meeting_file
	public List<Meeting_fileVo> detailMFile(int m_no) {
		return MeetingManager.detailMFile(m_no);
	}
	
	public int insertMFile(Meeting_fileVo mf) {
		return MeetingManager.insertMFile(mf);
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
	
	public int deleteMRep(int m_no) {
		return MeetingManager.deleteMRep(m_no);
	}
	
	public int NextMrNum() {
		return MeetingManager.nextMRepNum();
	}

	public int cntRep(int m_no) {
		return MeetingManager.cntRep(m_no);
	}
	
	// meeting_people
	public List<Meeting_peopleVo> detailMPeople(int m_no) {
		return MeetingManager.detailMPeople(m_no);
	}
	
	public int insertMPeople(Meeting_peopleVo mp) {
		return MeetingManager.insertMPeople(mp);
	}
	
	public int deleteMPeople(int m_no) {
		return MeetingManager.deleteMPeople(m_no);
	}
}
