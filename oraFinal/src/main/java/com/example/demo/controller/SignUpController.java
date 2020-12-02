package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dao.MemberDao;
import com.example.demo.vo.MemberVo;

import lombok.Setter;

@Controller
public class SignUpController {
	
	@Autowired
	@Setter
	private MemberDao mdao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/signUp",method = RequestMethod.GET)
	public void formSignUp() {
		//model.addAttribute("signUpOk", "0");
	}
	
	@RequestMapping(value = "/signUp",method = RequestMethod.POST,produces = "application/text; charset=utf8")
	@ResponseBody
	public String submitSignUp(MemberVo m, Model model) throws Exception {
		String password = m.getPassword();
		m.setPassword(passwordEncoder.encode(password));		
		m.setCode_value("00102"); //관리자 00101, 정회원 00102
		m.setRank_name("Lv1"); //처음 회원가입하면 기본으로 레벨1 제공
		System.out.println(m);
		int re = mdao.insertMember(m);

		return Integer.toString(re);
	}
	
	@RequestMapping(value = "/idCheck",method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String idCheck(String id) {
		System.out.println("아이디체크 작동");
		int result=mdao.idCheck(id);
		System.out.println("아이디체크 검증 : " + result);
		return Integer.toString(result);
	}
	
	@RequestMapping(value = "/nickCheck",method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String nickCheck(String nickName) {
		System.out.println("닉체크 작동");
		int result=mdao.nickCheck(nickName);
		System.out.println("닉체크 검증 : " + result);
		return Integer.toString(result);
	}
	
	@RequestMapping(value = "/phoneNumCheck",method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String phoneNumCheck(String phone) {
		System.out.println("폰번호체크 작동");
		int result=mdao.phoneNumCheck(phone);
		System.out.println("폰번호체크 검증 : " + result);
		return Integer.toString(result);
	}
}
