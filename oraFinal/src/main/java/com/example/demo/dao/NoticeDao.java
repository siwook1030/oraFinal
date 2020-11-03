package com.example.demo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.NoticeManager;
import com.example.demo.vo.CodeVo;
import com.example.demo.vo.NoticeVo;

@Repository
public class NoticeDao {
	
	public int getNextNoticeNo() {
		return NoticeManager.getNextNoticeNo();
	}

	public List<NoticeVo> listNotice(){
		return NoticeManager.listNotice();
	}
	
	public List<CodeVo> getBoardCategory(String code_type){
		return NoticeManager.getBoardCategory(code_type);
	}
	
	public NoticeVo detailNotice(int n_no) {
		return NoticeManager.detailNotice(n_no);
	}
	
	public int insert(NoticeVo n) {
		return NoticeManager.insertNotice(n);
	}
}
