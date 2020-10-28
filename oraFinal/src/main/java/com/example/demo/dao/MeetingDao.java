package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.MeetingManager;
import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.Meeting_fileVo;
import com.example.demo.vo.Meeting_repVo;

@Repository
public class MeetingDao {
	public List<MeetingVo> listMeeting(HashMap map){
		return MeetingManager.listMeeting(map);
	}
	
	public MeetingVo detailMeeting(int m_no) {
		return MeetingManager.detailMeeting(m_no);
	}
	
	public Meeting_repVo getMRep(int mr_no) {
		return MeetingManager.getMRep(mr_no);
	}
	
	public List<Meeting_fileVo> detailMFile(int m_no) {
		return MeetingManager.detailMFile(m_no);
	}
	
	
	public List<Meeting_repVo> detailMRep(HashMap map) {
		return MeetingManager.detailMRep(map);
	}
	
	
	public int insertMeeting(MeetingVo m) {
		return MeetingManager.insertMeeting(m);
	}
	
	public int insertMFile(Meeting_fileVo mf) {
		return MeetingManager.insertMFile(mf);
	}
	
	public int insertMRep(Meeting_repVo mr) {
		return MeetingManager.insertMRep(mr);
	}
	
	public int updateMRep(Meeting_repVo mr) {
		return MeetingManager.updateMRep(mr);
	}
	
	public int deleteMeeting(int m_no) {
		return MeetingManager.deleteMeeting(m_no);
	}
	
	public int deleteMf(int m_no) {
		return MeetingManager.deleteMFile(m_no);
	}
	
	public int deleteMr(int mr_no) {
		return MeetingManager.deleteMRep(mr_no);
	}
	
	
	public int NextMNum() {
		return MeetingManager.nextMeetingNum();
	}
	
	public int NextMfNum() {
		return MeetingManager.nextMFileNum();
	}
	
	public int NextMrNum() {
		return MeetingManager.nextMRepNum();
	}
	
	public int updateHit(int m_no) {
		return MeetingManager.updateHit(m_no);
	}
	
	public int totMRecord() {
		return MeetingManager.totMRecord();
	}
	
	public int cntRep(int m_no) {
		return MeetingManager.cntRep(m_no);
	}
	
	public int nextStep(int mr_ref) {
		return MeetingManager.nextStep(mr_ref);
	}
	
}
