package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.demo.db.CourseManager;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.FoodVo;
import com.example.demo.vo.PublicTransportVo;

@Repository
public class CourseDao {
	
	public int nextCno() {
		return CourseManager.nextCno();
	}
	
	public int insertCourse(CourseVo c, PublicTransportVo sPT, PublicTransportVo ePT) {
		return CourseManager.insertCourse(c, sPT, ePT);
	}
	
	public List<CourseVo> recommendList(String view) {
		return CourseManager.recommendList(view);
	}
	
	public CourseVo getCourseByCno(int c_no) {
		return CourseManager.getCourseByCno(c_no);
	}
	
	public List<CourseVo> listCourse(){
		return CourseManager.listCourse();
	}
	
	public List<PublicTransportVo> getPublicTransportByCno(int c_no){
		return CourseManager.getPublicTransportByCno(c_no);
	}
	
	public List<FoodVo> getFoodByCno(int c_no){
		return CourseManager.getFoodByCno(c_no);
	}
	
	public FoodVo getFoodByFoodNo(int food_no) {
		return CourseManager.getFoodByFoodNo(food_no);
	}
	
	public List<CourseVo> searchCourseList(HashMap map){
		return CourseManager.searchCourseList(map);
	}
}
