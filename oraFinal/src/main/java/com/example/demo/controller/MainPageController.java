package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dao.CourseDao;
import com.example.demo.vo.CourseVo;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class MainPageController {
	
	@Autowired
	@Setter
	CourseDao cdao;
	
	@RequestMapping(value = "/mainPage",  produces = "application/json; charset=utf8")
	public void mainPage(Model model) {
		Gson gson = new Gson();
		List<List<CourseVo>> cListByView = new ArrayList<List<CourseVo>>();
		List<String> vNameList = new ArrayList<String>();
		vNameList.add("강");vNameList.add("산");vNameList.add("명소");vNameList.add("바다");  //뷰 추가하는곳 순서있음
		for(String v : vNameList) {
			cListByView.add(cdao.getCourseByView(v));
		}
		model.addAttribute("cListByView", gson.toJson(cListByView));
		model.addAttribute("vNameList", gson.toJson(vNameList));
	}
	
	@PostMapping(value = "/headerCourseListByView", produces = "application/json; charset=utf8")
	public String headerCourseListByView() {
		
		return "";
	}
	
	
}
