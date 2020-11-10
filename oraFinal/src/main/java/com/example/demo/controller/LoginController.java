package com.example.demo.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.ResponseDataCode;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

@Controller
public class LoginController {
	
	@GetMapping("/login")
	public String Login(HttpServletRequest request, HttpServletResponse response) {
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String referrer = request.getHeader("Referer");
		
		if( referrer == null || referrer.equals("http://localhost:8088/signUp")) {
			referrer = "http://localhost:8088/mainPage";
		}
		
		if(savedRequest != null) {
			referrer = savedRequest.getRedirectUrl();
		}

		    request.getSession().setAttribute("prevPage", referrer);
			System.out.println(referrer);
			
		return "login";
	}
	
	@PostMapping(value = "/checkLogin", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String checkLogin(HttpSession session) {
		HashMap map = new HashMap();
		ResponseDataVo responseDataVo = new ResponseDataVo();

		map.put("id", "");
		map.put("code_value", "");
		map.put("nickName", "");

		if(session.getAttribute("m") != null) {
			MemberVo m = (MemberVo)session.getAttribute("m");
			map.put("id", m.getId());
			map.put("code_value", m.getCode_value());

			map.put("nickName", m.getNickName());

		}
		responseDataVo.setItem(map);
		System.out.println("리스폰스대이타브이오 : " + responseDataVo);
		return new Gson().toJson(responseDataVo);
	}
	
	
}
