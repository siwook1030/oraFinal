package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	
}
