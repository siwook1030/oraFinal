package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.dao.MemberDao;
import com.example.demo.service.MemberService;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.RankVo;
import com.google.gson.Gson;
	

@Controller
public class MemberController {

	@Autowired
	private MemberDao dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder; 
	
	@GetMapping(value = "/myPage", produces = "application/json;charset=utf-8")
	public void selectAll(HttpSession session) {

	}
	 //비밀번호 확인
	 @PostMapping(value = "/passwordConfirm", produces = "application/json;charset=utf-8")
	 @ResponseBody
	 public String passwordConfirm(MemberVo m,String password) {
		 String c = "";
		 boolean r = passwordEncoder.matches(password,m.getPassword());
		 if (r) {
			c = "확인되었습니다";
		 }else {
			c= "비밀번호를 다시확인해주세요";
		}
		 return c;
	 }
	 //비밀번호확인후 정보변경
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
		 if (m.getPassword() != ""&& "" != m.getPassword()) {
			 orgin.setPassword(passwordEncoder.encode(m.getPassword()));	
		 }
		 System.out.println(orgin);
		 int re = dao.updateMeber(orgin); 
		 
		 return gson.toJson(re); 
	 }
	 //나의 등급 확인
	 @GetMapping("/myPageMyRank")
	 public void getRank(HttpSession httpSession,Model model) {	// 랭크아이콘 가져오기
		 	RankVo r = dao.selectRank(((MemberVo)httpSession.getAttribute("m")).getRank_name());
			model.addAttribute("r", r);
	}
//	 
//	 @RequestMapping("/test")
//	 @ResponseBody
//	 public String test() {
//		 String a = "tiger";
//		 String b = passwordEncoder.encode("tiger");
//		 boolean r = passwordEncoder.matches(a, b);
//		 //String a = "tiger12345";
//		 //String b =orgin.getPassword();
//		 //boolean r = passwordEncoder.matches(a,b);
//		 //passwordEncoder.m
//		 System.out.println("r-------------------------"+r);
//		 return "ok";
//	 }
//	
}
