package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.CourseDao;
import com.example.demo.vo.CourseVo;
import com.google.gson.Gson;

@Controller
public class SearchCourseController {
	@Autowired
	private CourseDao cdao;
	
	@GetMapping("/searchCourse")
	public void searchCourseForm() {
		
	}
	
	@PostMapping(value ="/searchCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String searchCourse(double latitude, double longitude, int distance, int time,@RequestParam(value="view[]",required = false) List<String> view) {
		HashMap map = new HashMap();
		System.out.println("위도 : "+latitude);
		System.out.println("경도 : "+longitude);
		System.out.println("거리 : "+distance);
		System.out.println("시간 : "+time);
		System.out.println("풍경 : " + view);
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
	
	@GetMapping("/tagSearchCourse")
	public void tagSearchCourseForm(Model model,@RequestParam(defaultValue = "0") String searchTag) {
		String [] tagArr = (searchTag.replaceAll(" ", "")).split(",");
		String tags = "";
		for(String t : tagArr) {
			if(!t.equals("") && t != null) {
				tags += t+"|";
			}
		}	
		tags = tags.substring(0, tags.length()-1);
		model.addAttribute("searchTag", tags);	
	}
	
	@PostMapping(value = "/tagSearchCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<CourseVo> tagSearchCourse(String searchTag) {
		String [] tagArr = (searchTag.replaceAll(" ", "")).split(",");
		String tags = "";
		for(String t : tagArr) {
			if(!t.equals("") && t != null) {
				tags += t+"|";
			}
		}	
		tags = tags.substring(0, tags.length()-1);
		return cdao.tagSearchCourseList(tags);
	}
	
}
