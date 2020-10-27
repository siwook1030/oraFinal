package com.example.demo.controller;

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
		String check = "0";
		if(session.getAttribute("m") != null) {
			check = "1";
		}
		
		return check;
	}
	
	
}
