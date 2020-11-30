package com.example.demo.controller;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.util.BitSms;

@Controller
public class SmsController {
	@Autowired
	private BitSms bs;
	
	
	@GetMapping(value = "/smsSend",  produces = "application/text; charset=utf8")
	@ResponseBody
	public String smsSubmit(String phoneNum, HttpSession session) {
		Random rand = new Random();
		String sendMsg = "[오늘의라이더] 회원가입 인증번호\r\n";
		String number = "";
		for(int i=0; i<6; i++) {
			number += rand.nextInt(10);
		}
		session.setAttribute("number", number);
		sendMsg += number;
		String re = bs.sendMsg(phoneNum, sendMsg);
		System.out.println("결과체크 : " +re);
		//re가 1이면 전송성공 아니면 실패
		return re;
	}
	
	@PostMapping(value = "/smsSend",  produces = "application/text; charset=utf8")
	@ResponseBody
	public String sms(String num,  HttpSession session) {
		String chek = "";
		String number = "";
		if(session.getAttribute("number") != null) {
			number = (String)session.getAttribute("number");
		}
		
		if(number.equals(num)) {
			chek = "1";  // 1이면 인증번호와 일치 아니면 ""
			session.removeAttribute("number");
		}
		System.out.println("입력번호 : " + num);
		System.out.println("체크번호 : " + chek);
		return chek;
	}
	
	@GetMapping(value = "/smsSendMy",  produces = "application/text; charset=utf8")
	@ResponseBody
	public String smsSendMy(String phoneNum, HttpSession session) {
		Random rand = new Random();
		String sendMsg = "[오늘의라이더] 본인확인 인증번호\r\n";
		String number = "";
		for(int i=0; i<6; i++) {
			number += rand.nextInt(10);
		}
		session.setAttribute("number", number);
		sendMsg += number;
		String re = bs.sendMsg(phoneNum, sendMsg);
		System.out.println("결과체크 : " +re);
		//re가 1이면 전송성공 아니면 실패
		return re;
	}
	
}
