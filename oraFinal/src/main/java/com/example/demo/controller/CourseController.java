package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.CourseDao;
import com.example.demo.db.CourseManager;

import com.example.demo.vo.CoursePhotoVo;

import com.example.demo.util.FileUtilCollection;
import com.example.demo.util.ResponseDataCode;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.FoodVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.PublicTransportVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

@Controller
public class CourseController {
	
	
	@Autowired
	private CourseDao cdao;
	
	@GetMapping("/searchCourse")
	public void searchCourseForm() {
		
	}
	
	@PostMapping(value ="/searchCourse", produces = "application/json; charset=utf8")
	@ResponseBody
	public String searchCourse(double latitude, double longitude, int distance, int time,@RequestParam(value="view[]",required = false) List<String> view) {
		HashMap map = new HashMap();
		System.out.println("위도 : "+latitude);
		System.out.println("경도 : "+longitude);
		System.out.println("거리 : "+distance);
		System.out.println("시간 : "+time);
		int minDis = 0;
		if(distance > 0) { 
			 minDis = 20;
		}
		if(distance >50) {
			minDis = 950;
		}
		
		int minTime = 0;
		if(time > 0) {
			 minTime = 60;
		}
		if(time > 180) {
			minTime = 820;
		}
		
		
		if(view != null) {
			int cnt=1;
			for(String v : view) {
				map.put("view"+cnt, v);
				cnt++;
			}
		}
			
		map.put("latitude", latitude);
		map.put("longitude", longitude);
		map.put("distance", distance);
		map.put("minDis", minDis);
		map.put("time", time);
		map.put("minTime", minTime);
		List<CourseVo> sclList = cdao.searchCourseList(map);
		
		Gson gson = new Gson();
		
		return gson.toJson(sclList);
		
	}
	
	
	@RequestMapping(value = "/detailCourse", produces = "application/json; charset=utf-8")
	public void detailCourse(HttpServletRequest request,Model model, int c_no) {
		String path = request.getRealPath("/courseLine")+"/";
		Gson gson = new Gson();
		CourseVo c = cdao.getCourseByCno(c_no, path);
		List<PublicTransportVo> ptList = cdao.getPublicTransportByCno(c_no);
	//	List<FoodVo> fList = cdao.getFoodByCno(c_no);
		model.addAttribute("c", c);
		model.addAttribute("cJson", gson.toJson(c));
		model.addAttribute("ptList", ptList);
		model.addAttribute("ptJson", gson.toJson(ptList));
	//	model.addAttribute("fList", fList);
	//	model.addAttribute("fJson", gson.toJson(fList));
	}
	@RequestMapping(value = "/admin/deleteCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteCourse(HttpServletRequest request, int c_no) {
		
		 ResponseDataVo responseDataVo = new ResponseDataVo();
		 responseDataVo.setCode(ResponseDataCode.ERROR);
		 responseDataVo.setMessage("삭제에 실패하였습니다.");
		 int re = -1;
		 re = cdao.deleteCourse(c_no);
		 String cLinepath = request.getRealPath(MakingCourseController.courseLinePath);
		 String cLineName = c_no + MakingCourseController.courseLineName;
		 String cPhotoFolderPath = request.getRealPath(MakingCourseController.coursePhotoPath)+MakingCourseController.coursePhotoPathSub+c_no;
		 if( re > 0) {
			 try {
				 FileUtilCollection.deleteFile(cLinepath+"/"+cLineName);
				 FileUtilCollection.deleteFolder(cPhotoFolderPath);
			 }catch (Exception e) {
				System.out.println("딜리트코스 파일예외 " + e.getMessage());
			}	 
			 responseDataVo.setCode(ResponseDataCode.SUCCESS);
			 responseDataVo.setMessage("삭제에 성공하였습니다");
		 }
		 	 
		 Gson gson = new Gson();
		 return gson.toJson(responseDataVo);
	}
	
	

   @RequestMapping("/detailFood")
   public void detailFood(HttpServletRequest request,Model model,int c_no ,int food_no) {
      String path = request.getRealPath("/courseLine")+"/";
      model.addAttribute("c", cdao.getCourseByCno(c_no, path));
      model.addAttribute("f", cdao.getFoodByFoodNo(food_no));
   }
   
   @GetMapping(value = "/myPageSaveCourse")
      public void saveCourse() {
      }
   
   //나의 찜코스 ~
   @PostMapping(value = "/myPageSaveCourse", produces = "application/json; charset=utf-8")
   @ResponseBody
   public String saveCourse(HttpSession httpSession) {
      System.out.println("세이브 컨트롤러 작동!!!!");
      Gson gson = new Gson();
      List<CourseVo> courseList = cdao.getSaveCourse(httpSession);
      List<CoursePhotoVo> photovo =null;
      for (CourseVo c : courseList) {
         photovo =(c.getC_photo());
      }
      //model.addAttribute("courseList",courseList);
      //model.addAttribute("photovo",photovo);
      System.out.println(courseList);
      System.out.println("코스리스트");
      System.out.println(photovo);
      
      return gson.toJson(courseList);
   }
   //내가 만든코스~
   @GetMapping(value = "/myPageMyCourse")
   public void myCourse(Model model,HttpSession httpSession) {
      System.out.println("마이코스 컨트롤러 작동!!!!");
      List<CourseVo> courseList = cdao.getMyCourseById(httpSession);
      List<CoursePhotoVo> photovo =null;
      for (CourseVo c : courseList) {
         photovo =(c.getC_photo());
      }
      model.addAttribute("courseList",courseList);
      model.addAttribute("photovo",photovo);
      System.out.println(courseList);
      System.out.println("코스리스트");
      System.out.println(photovo);
   }
   //찜코스 삭제~
   @PostMapping(value = "/deleteSaveCourse", produces = "application/json; charset=utf-8")
   @ResponseBody
   public String deleteSaveCourse(HttpSession httpSession,int cno) {
      System.out.println("코스삭제 컨트롤러작동" + cno);
      MemberVo m = (MemberVo)httpSession.getAttribute("m");
      HashMap map = new HashMap();
      map.put("id", m.getId());
      map.put("c_no", cno);
      String re = ""+cdao.deleteSaveCourse(map);
      return re;
   }
	
	//찜코스 추가
	@PostMapping(value = "/user/addSaveCourse",  produces = "application/json; charset=utf-8")
	@ResponseBody
	public String addSaveCourse(@RequestParam Map<String, Object> map) {
		int re = cdao.addSaveCourse(map);
		return Integer.toString(re);
	}
	
	//찜코스 삭제 ajax 오버로딩
	@PostMapping(value = "/user/deleteSaveCourse",  produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteSaveCourse(@RequestParam HashMap<String, Object> map) {
		int re = cdao.deleteSaveCourse(map);
		return Integer.toString(re);
	}

//   @RequestMapping("/detailFood")  포기... crud가 너무 힘들다
//   public void detailFood(HttpServletRequest request,Model model,int c_no ,int food_no) {
//      String path = request.getRealPath("/courseLine")+"/";
//      model.addAttribute("c", cdao.getCourseByCno(c_no, path));
//      model.addAttribute("f", cdao.getFoodByFoodNo(food_no));
//   }
}