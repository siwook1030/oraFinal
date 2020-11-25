package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import com.example.demo.db.ReviewManager;
import com.example.demo.vo.ReviewVo;
import com.example.demo.vo.Review_fileVo;
import com.example.demo.vo.Review_repVo;
import com.example.demo.vo.Review_tempVo;

@Repository
public class ReviewDao {
	public List<ReviewVo> selectList(HashMap mybatis_map){
		return ReviewManager.selectList(mybatis_map);
	}
	// 코스별 조회수 상위3개 뽑아오기
	public List<ReviewVo> getReviewByCno(int c_no){
		return ReviewManager.getReviewByCno(c_no);
	}
	
	public List<ReviewVo> myPageSelectList(HttpSession httpSession){
		return ReviewManager.MyPageSelectList(httpSession);
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
	public int count(HashMap mybatis_map) {
		return ReviewManager.count(mybatis_map);
	}
	public int nextRr_no() {
		return ReviewManager.nextRr_no();
	}
	public int nextRr_step(int rr_ref) {
		return ReviewManager.nextRr_step(rr_ref);
	}
	public int insertRep(Review_repVo rrvo) {
		return ReviewManager.insertRep(rrvo);
	}
	public int update(ReviewVo rvo) {
		return ReviewManager.update(rvo);
	}
	public int deleteFileOne(int rf_no) {
		return ReviewManager.deleteFileOne(rf_no);
	}
	public Review_tempVo selectTemp(String id) {
		return ReviewManager.selectTemp(id);
	}
	public int insertTemp(Review_tempVo rtvo) {
		return ReviewManager.insertTemp(rtvo);
	}
	public int updateTemp(Review_tempVo rtvo) {
		return ReviewManager.updateTemp(rtvo);
	}
	public int deleteTemp(String id) {
		return ReviewManager.deleteTemp(id);
	}
	public int deleteRepOne(int rr_no) {
		return ReviewManager.deleteRepOne(rr_no);
	}
	public int updateRep(Review_repVo rrvo) {
		return ReviewManager.updateRep(rrvo);
	}
	
	// 로그기록위해 댓글 삭제전 아이디 가져오기
	public Review_repVo getReviewRepOne(int rr_no) {
		return ReviewManager.getReviewRepOne(rr_no);
	}
}
