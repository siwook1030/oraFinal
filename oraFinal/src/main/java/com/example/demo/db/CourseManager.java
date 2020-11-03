package com.example.demo.db;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;import org.springframework.boot.web.embedded.undertow.ConfigurableUndertowWebServerFactory;

import com.example.demo.controller.CourseController;
import com.example.demo.vo.CoursePhotoVo;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.FoodPhotoVo;
import com.example.demo.vo.FoodVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.PublicTransportVo;

public class CourseManager {
	
private static SqlSessionFactory sqlSessionFactory;
private static final int recommendNum = 3;	
	static {
		try {
			String resource = "com/example/demo/db/sqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			System.out.println("코스매니저 예외 " +e.getMessage());
		}
	}
	
	public static int nextCno() {
		int re = 0;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("course.nextCno");
		session.close();
		return re;
	}
	
	public static int insertCourse(CourseVo c, PublicTransportVo sPT, PublicTransportVo ePT) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession();
		int rec = session.insert("course.insertCourse", c);
		int resPT = session.insert("course.insertPT",sPT); 
		int reePT = session.insert("course.insertPT",ePT);
		
		if(rec > 0 && resPT > 0 && reePT > 0) {
			session.commit();
			re = 1;
		}
		else {
			session.rollback();
		}
		
		session.close();
		return re;
	}
	
	public static List<CourseVo> getCourseByView(String view) {  // 메인페이지 추천
		List<CourseVo> clist = new ArrayList<CourseVo>();
		SqlSession session = sqlSessionFactory.openSession();
		clist = session.selectList("course.selectByView", view);
		for(CourseVo c : clist) {
			c.setC_views(c.getC_view().split("-"));
			List<CoursePhotoVo> cpList = session.selectList("course.selectCoursePhoto", c.getC_no());
			Collections.shuffle(cpList);
			c.setC_photo(cpList);
		}
	//	System.out.println(clist);
		session.close();
		return clist;
	}
	
	public static CourseVo getCourseByCno(int c_no, String path) {
		CourseVo c = null;
		SqlSession session = sqlSessionFactory.openSession();
		c = session.selectOne("course.selectByCno", c_no);
		c.setC_views(c.getC_view().split("-"));
		c.setC_line(getCline(c.getC_line(), path));
		List<CoursePhotoVo> cpList = session.selectList("course.selectCoursePhoto", c_no);			
		Collections.shuffle(cpList);
		if(cpList.size() == 0 ) {
			cpList = null;
		} 
		c.setC_photo(cpList);
		session.close();
		
		return c;
	}
	
	public static List<CourseVo> listCourse(){
		List<CourseVo> cList = null;
		SqlSession session = sqlSessionFactory.openSession();
		cList = session.selectList("course.selectCourseList");
		session.close();
		
		return cList;
	}
	
	public static List<CourseVo> searchCourseList(HashMap map){
		List<CourseVo> scList = new ArrayList<CourseVo>();
		List<Integer> inCnumList = null;
		List<Integer> cNumList = new ArrayList<Integer>();
		SqlSession session = sqlSessionFactory.openSession();
		
		int maxSearchSize = 500;
		double disNum= 0.1;
		double nearDisNum = 1;
		double timeNum = 0.3;

		int distance = (int) map.get("distance");
		int minDis = (int) map.get("minDis");
		int time = (int) map.get("time");
		int minTime = (int) map.get("minTime");

		
		for(int i=0; i<=maxSearchSize; i++) {
			map.put("maxNearDis", (5+(i*nearDisNum)));
			map.put("minDis", ((distance-minDis)-(i*disNum)));
			map.put("maxDis", (distance+(i*disNum)));
			map.put("minTime", ((time-minTime)-(i*timeNum)));
			map.put("maxTime", (time+(i*timeNum)));

			inCnumList = session.selectList("course.selectSearchCourseNum", map);
			for(int num : inCnumList) {
				if(!cNumList.contains(num)) {
					cNumList.add(num);
				}
			}
			
		}
		System.out.println(cNumList);
		for(int c_no : cNumList) {
			map.put("c_no", c_no);
			scList.add(selectByCnoandUserDis(map));
		}
		session.close();
		return scList;
	}
	
	public static int cnameDupCheck(String c_name) {
		int re = 1;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.selectOne("course.cnameDupCheck", c_name);
		session.close();
		
		return re;
		
	}
	
	public static List<PublicTransportVo> getPublicTransportByCno(int c_no){
		List<PublicTransportVo> ptList = null;
		SqlSession session = sqlSessionFactory.openSession();
		ptList = session.selectList("course.selectPt", c_no);
		session.close();
		
		return ptList;
	}
	
	public static List<FoodVo> getFoodByCno(int c_no){
		List<FoodVo> fList = null;
		SqlSession session = sqlSessionFactory.openSession();
		fList = session.selectList("course.selectFood", c_no);
		for(FoodVo f : fList) {
			List<FoodPhotoVo> fpList = session.selectList("course.selectFoodPhoto", f.getFood_no());
			Collections.shuffle(fpList);
			f.setFood_photo(fpList);
			
		}
		session.close();
		
		return fList;
	}
	
	public static FoodVo getFoodByFoodNo(int food_no) {
		FoodVo f = null;
		SqlSession session = sqlSessionFactory.openSession();
		f = session.selectOne("course.selectOneFood", food_no);
		List<FoodPhotoVo> fpList = session.selectList("course.selectFoodPhoto", food_no);
		Collections.shuffle(fpList);
		f.setFood_photo(fpList);
		session.close();
		return f;
	}
	
	private static CourseVo selectByCnoandUserDis(HashMap map) {
		CourseVo c = null;
		SqlSession session = sqlSessionFactory.openSession();
		c = session.selectOne("course.selectByCnoandUserDis", map);
		c.setC_views(c.getC_view().split("-"));
		List<CoursePhotoVo> cpList = session.selectList("course.selectCoursePhoto", (int)map.get("c_no"));
		Collections.shuffle(cpList);
		c.setC_photo(cpList);
		session.close();
		
		return c;
	}
	
	private static String getCline(String filename, String path) {
		String c_line = "";
		try {
			File file = new File(path+filename);
			FileReader fileReader = new FileReader(file);
			BufferedReader bufferedReader = new BufferedReader(fileReader);
			String line = "";
			while((line= bufferedReader.readLine()) != null) {
				c_line += line;
			}
			
			bufferedReader.close();
			System.out.println(c_line);
		}catch (Exception e) {
			System.out.println("코스매니저 겟시라인 예외 " +e.getMessage());
		}
		
		return c_line;
	}
	//나의 찜코스 가져오기
	public static List<CourseVo> getSaveCourse(HttpSession httpSession) {
		MemberVo m = (MemberVo)httpSession.getAttribute("m");
		List<CourseVo> SaveCourseList;
		SqlSession session = sqlSessionFactory.openSession();
		SaveCourseList = session.selectList("course.selectSaveCourse", m.getId());
		List<CoursePhotoVo> cpList = null;
		for (CourseVo c : SaveCourseList) {
			cpList=session.selectList("course.selectCoursePhoto", c.getC_no());
			Collections.shuffle(cpList);
			c.setC_photo(cpList);
		}
		session.close();
		return SaveCourseList;
	}
	//내가만든 코스 가져오기
	public static List<CourseVo> getMyCourseById(HttpSession httpSession) {
		MemberVo m = (MemberVo)httpSession.getAttribute("m");
		List<CourseVo> SaveCourseList;
		SqlSession session = sqlSessionFactory.openSession();
		SaveCourseList = session.selectList("course.selectMyCourse", m.getId());
		List<CoursePhotoVo> cpList = null;
		for (CourseVo c : SaveCourseList) {
			cpList=session.selectList("course.selectCoursePhoto", c.getC_no());
			Collections.shuffle(cpList);
			c.setC_photo(cpList);
		}
		
		session.close();
		return SaveCourseList;
	}
	//찜코스 삭제
	public static int deleteSaveCourse(HashMap map) {
		int re = -1;
		SqlSession session = sqlSessionFactory.openSession();
		re = session.delete("course.deleteMyCourse", map);
		session.commit();
		session.close();
		return re;
	}
	
	
	
	
}











