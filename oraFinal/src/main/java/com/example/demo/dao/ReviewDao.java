package com.example.demo.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.ReviewManager;
import com.example.demo.vo.ReviewVo;
import com.example.demo.vo.Review_fileVo;
import com.example.demo.vo.Review_repVo;

@Repository
public class ReviewDao {
	public List<ReviewVo> selectList(){
		return ReviewManager.selectList();
	}
	public int incHit(int r_no) {
		return ReviewManager.incHit(r_no);
	}
	public ReviewVo selectOne(int r_no) {
		return ReviewManager.selectOne(r_no);
	}
	public List<Review_fileVo> selectListFile(int r_no) {
		return ReviewManager.selectListFile(r_no);
	}
	public List<Review_repVo> selectListRep(int r_no) {
		return ReviewManager.selectListRep(r_no);
	}
	public int nextR_no() {
		return ReviewManager.nextR_no();
	}
	public int insert(ReviewVo vo) {
		return ReviewManager.insert(vo);
	}
	public int insertFile(Review_fileVo vo) {
		return ReviewManager.insertFile(vo);
	}
	public int nextRf_no() {
		return ReviewManager.nextRf_no();
	}
	public int countRep(int r_no) {
		return ReviewManager.countRep(r_no);
	}
	public int delete(int r_no) {
		return ReviewManager.delete(r_no);
	}
	public int deleteFile(int r_no) {
		return ReviewManager.deleteFile(r_no);
	}
	public int deleteRep(int r_no) {
		return ReviewManager.deleteRep(r_no);
	}
}
