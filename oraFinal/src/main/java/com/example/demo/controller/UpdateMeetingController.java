package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.MeetingDao;
import com.example.demo.util.ResponseDataCode;
import com.example.demo.vo.Meeting_repVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class UpdateMeetingController {
	
	@Autowired
	@Setter
	MeetingDao mdao;
	
	@PostMapping(value = "/user/updateMeetingRep", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updateMeetingRep(int mr_no, String content, String toName) {
		Meeting_repVo mr = mdao.getMRep(mr_no);
		String mr_content = toName+" "+content;
		System.out.println("mr콘텐트 : " + mr_content);
		mr.setMr_content(mr_content);
		
		int re = 0;
		re = mdao.updateMRep(mr);
		
		ResponseDataVo responseDataVo = new ResponseDataVo();
		responseDataVo.setCode(ResponseDataCode.ERROR);
		if(re>0) {
			responseDataVo.setCode(ResponseDataCode.SUCCESS);
		}
		return new Gson().toJson(responseDataVo);
		
	}
}
