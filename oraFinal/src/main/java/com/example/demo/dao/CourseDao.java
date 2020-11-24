package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import com.example.demo.db.CourseManager;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.FoodVo;
import com.example.demo.vo.PublicTransportVo;

@Repository
public class CourseDao {
	// 코스 다음번호
	public int nextCno() {
		return CourseManager.nextCno();
	}
	
	//코스 인서트
	public int insertCourse(CourseVo c, PublicTransportVo sPT, PublicTransportVo ePT) {
		return CourseManager.insertCourse(c, sPT, ePT);
	}
	//코스 수정
	public int updateCourse (CourseVo c, PublicTransportVo sPT, PublicTransportVo ePT) {
		return CourseManager.updateCourse(c, sPT, ePT);
	}
	//코스 삭제
	public int deleteCourse(int c_no) {
		return CourseManager.deleteCourse(c_no);
	}
	// 뷰에따른 코스갖고오기
	public List<CourseVo> getCourseByView(String view) {
		return CourseManager.getCourseByView(view);
	}
	// 코스상세 가져오기 path는 코스라인파일 읽기위한것
	public CourseVo getCourseByCno(int c_no, String path) {
		return CourseManager.getCourseByCno(c_no, path);
	}
	// 리뷰,번개게시판 코스리스트 보여주기용
	public List<CourseVo> listCourse(){
		return CourseManager.listCourse();
	}
	
	// 메이킹코스 코스명중복체크
	public int cnameDupCheck(String c_name) {
		return CourseManager.cnameDupCheck(c_name);
	}
	
	// 대중교통 갖고오기
	public List<PublicTransportVo> getPublicTransportByCno(int c_no){
		return CourseManager.getPublicTransportByCno(c_no);
	}
	
	public List<FoodVo> getFoodByCno(int c_no){
		return CourseManager.getFoodByCno(c_no);
	}
	
	public FoodVo getFoodByFoodNo(int food_no) {
		return CourseManager.getFoodByFoodNo(food_no);
	}
	
	// 맞춤코스검색 리스트 가져오기
	public List<CourseVo> searchCourseList(HashMap map){
		return CourseManager.searchCourseList(map);
	}
	
	// 태그검색 코스 가져오기
	public List<CourseVo> tagSearchCourseList(String searchTag){
		return CourseManager.tagSearchCourseList(searchTag);
	}
	
	// 승인대기중인 코스리스트 가져오기
	public List<CourseVo> getCourseListByTemp(){
		return CourseManager.getCourseListByTemp();
	}
	
	// 승인대기중이 코스 승인해주기
	public int approveCourse(int c_no) {
		return CourseManager.approveCourse(c_no);
	}
	
	
	public List<Integer> getAllSaveCourse(String id){
		return CourseManager.getAllSaveCourse(id);
	}
	
	public List<CourseVo> getSaveCourse(HttpSession httpSession){
		return CourseManager.getSaveCourse(httpSession);
	}
	public List<CourseVo> getMyCourseById(HttpSession httpSession){
		return CourseManager.getMyCourseById(httpSession);
	}
	public int deleteSaveCourse(HashMap map) {
		return CourseManager.deleteSaveCourse(map);
	}
	
	public int addSaveCourse(Map map) {
		return CourseManager.addSaveCourse(map);
	}
}
