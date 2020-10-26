package com.example.demo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.NoticeManager;
import com.example.demo.vo.CodeVo;
import com.example.demo.vo.NoticeVo;

@Repository
public class NoticeDao {

	public List<NoticeVo> listNotice(){
		return NoticeManager.listNotice();
	}
	
	public List<CodeVo> getBoardCategory(){
		return NoticeManager.getBoardCategory();
	}
	
	public NoticeVo detailNotice(int n_no) {
		return NoticeManager.detailNotice(n_no);
	}
	
	public int insert(NoticeVo n) {
		return NoticeManager.insertNotice(n);
	}
}
