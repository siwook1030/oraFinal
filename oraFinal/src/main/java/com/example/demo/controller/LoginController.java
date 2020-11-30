package com.example.demo.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.CourseDao;
import com.example.demo.util.ResponseDataCode;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class LoginController {
	
	@Autowired
	private CourseDao cdao;
	
	@GetMapping("/login")
	public String Login(HttpServletRequest request, HttpServletResponse response) {
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String referrer = request.getHeader("Referer");

		if( referrer == null || referrer.endsWith("signUp")||  referrer.endsWith("login") ) {
			referrer = "/mainPage";
		}
		
		if(savedRequest != null) {
			referrer = savedRequest.getRedirectUrl();
			requestCache.removeRequest(request, response);
		}

		    request.getSession().setAttribute("prevPage", referrer);

			
		return "login";
	}
	
	@GetMapping(value = "/checkLogin", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String checkLogin(HttpSession session) {
		HashMap map = new HashMap();
		ResponseDataVo responseDataVo = new ResponseDataVo();
		responseDataVo.setCode(ResponseDataCode.ERROR);
		map.put("id", "");
		map.put("code_value", "");
		map.put("nickName", "");
		map.put("saveCourse", "");
		if(session.getAttribute("m") != null) {
			MemberVo m = (MemberVo)session.getAttribute("m");
			responseDataVo.setCode(ResponseDataCode.SUCCESS);
			map.put("id", m.getId());
			map.put("code_value", m.getCode_value());
			map.put("nickName", m.getNickName());
			map.put("saveCourse", cdao.getAllSaveCourse(m.getId()));
		}
		responseDataVo.setItem(map);
		//System.out.println("리스폰스대이타브이오 : " + responseDataVo);
		return new Gson().toJson(responseDataVo);
	}
	
	
}
