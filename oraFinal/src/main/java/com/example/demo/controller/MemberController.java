package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.dao.MemberDao;
import com.example.demo.vo.MemberVo;
import com.google.gson.Gson;

@Controller
public class MemberController {

	@Autowired
	private MemberDao dao;

	@GetMapping(value = "/myPage2", produces = "application/json;charset=utf-8")
	public void selectAll(HttpSession session) {

	}

	
	 @PostMapping(value = "/update", produces = "application/json;charset=utf-8")
	 @ResponseBody
	 public String updateMember(MemberVo m,HttpSession session) { 
		 System.out.println(m);
		 Gson gson = new Gson();
		 MemberVo orgin = (MemberVo) session.getAttribute("m");
		 if (m.getPhone() != "" && "" != m.getPhone()) {
			orgin.setPhone(m.getPhone());
		}
		 if (m.getNickName() != ""&& "" != m.getNickName()) {
			 orgin.setNickName(m.getNickName());	
		}
		 System.out.println(orgin);
		 int re = dao.updateMeber(orgin); 
		 return gson.toJson(re); 
	 }
	 
}
