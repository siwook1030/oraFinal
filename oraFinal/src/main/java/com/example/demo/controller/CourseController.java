package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.CourseDao;
import com.example.demo.db.CourseManager;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.FoodVo;
import com.example.demo.vo.PublicTransportVo;
import com.google.gson.Gson;

@Controller
public class CourseController {
	
	public static final String c_linePath = "C:\\Users\\siwook\\git\\oraFinal\\oraFinal\\src\\main\\webapp\\courseLine/";
	
	@Autowired
	private CourseDao cdao;
	
	@RequestMapping("/mainPage")
	public void mainPage(Model model) {
		Random rand = new Random();
		String []view = {"강","산","명소","바다"};
		int r = rand.nextInt(view.length);
		model.addAttribute("clist", cdao.recommendList(view[r]));
		model.addAttribute("view", view[r]);
	}
	
	@GetMapping("/searchCourse")
	public void searchCourse() {
		
	}
	
	@PostMapping(value ="/searchCourse", produces = "application/json; charset=utf8")
	@ResponseBody
	public String searchCourse(HttpSession session,double latitude, double longitude, int distance, int time,@RequestParam(value="view[]",required = false) List<String> view) {
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
	public void detailCourse(Model model, int c_no) {
		Gson gson = new Gson();
		List<PublicTransportVo> ptList = cdao.getPublicTransportByCno(c_no);
		List<FoodVo> fList = cdao.getFoodByCno(c_no);
		model.addAttribute("c", cdao.getCourseByCno(c_no));
		model.addAttribute("ptList", ptList);
		model.addAttribute("ptJson", gson.toJson(ptList));
		model.addAttribute("fList", fList);
		model.addAttribute("fJson", gson.toJson(fList));
	}
	
	@RequestMapping("/detailFood")
	public void detailFood(Model model,int c_no ,int food_no) {
		model.addAttribute("c", cdao.getCourseByCno(c_no));
		model.addAttribute("f", cdao.getFoodByFoodNo(food_no));
	}
}
