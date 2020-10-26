package com.example.demo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.FreeBoardManager;
import com.example.demo.vo.FreeBoardVo;

@Repository
public class FreeBoardDao {
	
	public int nextFreeBoardNum() {
		return FreeBoardManager.nextFreeBoardNum();
	}
	
	public List<FreeBoardVo> listFreeBoard(){
		return FreeBoardManager.listFreeBoard();
	}
	
	public FreeBoardVo getFreeBoard(int no) {
		return FreeBoardManager.getFreeBoard(no);
	}
}
