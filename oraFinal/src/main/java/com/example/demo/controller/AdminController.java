package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.CourseDao;
import com.example.demo.dao.LogDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.util.BitSms;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.LogVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

@Controller
public class AdminController {
	@Autowired
	private BitSms bs;
	
	@Autowired
	private CourseDao cdao;
	
	@Autowired
	private MemberDao mdao;
	
	@Autowired
	private LogDao ldao;
	
	@GetMapping(value = "/admin/adminPage")
	public void adminPage(Model model) {
		
		int memberAllCnt = ldao.getMemberAllCnt(0);
		int memberAllCntYester = ldao.getMemberAllCnt(1);
		
		int courseAllCnt = ldao.getCourseAllCnt(0);
		int courseAllCntYester = ldao.getCourseAllCnt(1);
		
		int reviewAllCnt = ldao.getReviewAllCnt(0);
		int reviewAllCntYester = ldao.getReviewAllCnt(1);
		
		int meetingAllCnt = ldao.getMeetingAllCnt(0);
		int meetingAllCntYester = ldao.getMeetingAllCnt(1);
		
		model.addAttribute("memberAllCnt", memberAllCnt);
		model.addAttribute("memberChangeCnt", memberAllCnt-memberAllCntYester);
		
		model.addAttribute("courseAllCnt", courseAllCnt);
		model.addAttribute("courseChangeCnt", courseAllCnt-courseAllCntYester);
		
		model.addAttribute("reviewAllCnt", reviewAllCnt);
		model.addAttribute("reviewChangeCnt", reviewAllCnt-reviewAllCntYester);
		
		model.addAttribute("meetingAllCnt", meetingAllCnt);
		model.addAttribute("meetingChangeCnt", meetingAllCnt-meetingAllCntYester);
		

	}
	
	@GetMapping(value = "/admin/courseSearchLog",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String courseSearchLog() {
		HashMap map = new HashMap();
		
		map.put("reviewC", ldao.getLogList("004"));
		map.put("meetingC", ldao.getLogList("005"));
		map.put("cno", ldao.getLogList("00701"));
		map.put("dis", ldao.getLogList("00702"));
		map.put("time", ldao.getLogList("00703"));
		map.put("view", ldao.getLogList("00704"));
		map.put("tag", ldao.getLogList("00705"));

		return new Gson().toJson(map);
	}
	
	@GetMapping(value = "/admin/getCourseListByTemp", produces = "application/json; charset=utf-8" )
	@ResponseBody
	public List<CourseVo> getCourseListByTemp(){

		return cdao.getCourseListByTemp();
	}
	
	@PostMapping(value = "/admin/approveCourse", produces = "application/json; charset=utf-8" )
	@ResponseBody
	public String approveCourse(int c_no, String c_name , String id) {
		String alert = "["+c_name+"]코스 승인에 실패했습니다";
		
		int re = cdao.approveCourse(c_no);
		MemberVo m  = mdao.selectMember(id);
		if(re > 0) {
			alert = "["+c_name+"]코스 승인에 성공했습니다";
			String sendMsg = "[오늘의 라이딩]\r\n"+m.getNickName()+"님! 등록하신 코스가 승인되었습니다."
					+ "코스등록에 감사드립니다 ^_^";
			String result = bs.sendMsg(m.getPhone(), sendMsg);
			if(result.equals("1")) {
				alert += "(문자발송완료)";
			}
			else {
				alert += "(문자발송실패)";
			}
		} 
		
		return alert;
	}
}
