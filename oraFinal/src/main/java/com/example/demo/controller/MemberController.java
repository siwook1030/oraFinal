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
   //마이페이지 이동
   @GetMapping(value = "/myPage", produces = "application/json;charset=utf-8")
   public void selectAll(HttpSession session) {


   }
    //비밀번호 확인
    @PostMapping(value = "/passwordConfirm")
    @ResponseBody
    public String passwordConfirm(HttpSession httpSession,String password) {
       System.out.println("비밀번호 확인 컨트롤러 확인 ~~~~~~~~~~~~~~~~~~~~~~");
       MemberVo m = (MemberVo)httpSession.getAttribute("m");
       System.out.println(m.getPassword());
       String c = "";
       boolean r = passwordEncoder.matches(password,m.getPassword());
       if (r) {
         c = "확인되었습니다";
       }else {
         c= "비밀번호를 다시확인해주세요";
      }
       System.out.println("c:" + c);
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
           String password = m.getPassword();
           orgin.setPassword(passwordEncoder.encode(password)); 
        
        }
       
       System.out.println(orgin);
       int re = dao.updateMeber(orgin); 
       
       return gson.toJson(re); 
    }
 
    @PostMapping(value = "/updatePwd", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String updatePwd(String password,String id) { 
    	Gson gson = new Gson();
    	System.out.println("..........................패스워드"+password);
    	System.out.println("..........................아이디"+id);
    	MemberVo m = new MemberVo();
    	m.setId(id);
    	String pwd = passwordEncoder.encode(password); 
    	m.setPassword(pwd);
    	int re = dao.updatePwd(m); 
    	return gson.toJson(re); 
    }
    //나의 등급 확인
    @GetMapping("/myPageMyRank")
    public void getRank(HttpSession httpSession,Model model) {   // 랭크아이콘 가져오기
          RankVo r = dao.selectRank(((MemberVo)httpSession.getAttribute("m")).getRank_name());
         model.addAttribute("r", r);
   }

    @PostMapping(value = "/selectMemberId", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getRank(Model model,String phone) {   // 아이디찾기
    	System.out.println("mmmmmmmmmmmmmmmmmmmmmmmm"+phone);
    	Gson gson = new Gson();
    	MemberVo m = dao.selectMemberId(phone);
    	System.out.println("mmmmmmmmmmmmmmmmmmmmmmmm"+m.getId());
    	return gson.toJson(m);
    }
}

