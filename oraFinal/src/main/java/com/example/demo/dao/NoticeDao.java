package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.MeetingManager;
import com.example.demo.db.NoticeManager;
import com.example.demo.vo.CodeVo;
import com.example.demo.vo.NoticeVo;

@Repository
public class NoticeDao {
	
	public int getNextNoticeNo() {
		return NoticeManager.getNextNoticeNo();
	}

	public List<NoticeVo> listNotice(HashMap map){
		return NoticeManager.listNotice(map);
	}
	
	public List<CodeVo> getBoardCategory(String code_type){
		return NoticeManager.getBoardCategory(code_type);
	}
	
	public NoticeVo detailNotice(int n_no) {
		return NoticeManager.detailNotice(n_no);
	}
	
	public int insertNotice(NoticeVo n) {
		return NoticeManager.insertNotice(n);
	}
	
	public int updateHit(int n_no) {
		return NoticeManager.updateHit(n_no);
	}
	
	public int updateNotice(NoticeVo n) {
		return NoticeManager.updateNotice(n);
	}
	
	public int deleteNotice(int n_no) {
		return NoticeManager.deleteNotice(n_no);
	}
	
	public NoticeVo selectByN_NO(int n_no) {
		return NoticeManager.selectByN_NO(n_no);
	}
	
	public List<NoticeVo> searchNotice(HashMap map){
		return NoticeManager.searchNotice(map);
	}
	
	public int totNRecord(HashMap map) {
		return NoticeManager.totNRecord(map);
	}
}
