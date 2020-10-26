package com.example.demo.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dao.CourseDao;
import com.example.demo.dao.MeetingDao;
import com.example.demo.vo.MeetingVo;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class MeetingController {
	
	@Autowired
	@Setter
	private MeetingDao mdao;
	
	@Autowired
	@Setter
	private CourseDao cdao;
	
	public static int totRecord = 0; // 총 게시글 수
	public static int recordSize = 3; // 한 번에 보이는 게시글 수
	public static int totPage = 0; // 총 페이지 수
	public static int pageSize = 2; // 한 번에 보이는 페이지 수
	
	@RequestMapping("/listMeeting")
	public void listMeeting(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo, MeetingVo m) {
		totRecord = mdao.totMRecord();
		totPage = (int)Math.ceil((double)totRecord/recordSize);
		
		// 페이지 버튼 숫자
		int startPage = (pageNo-1)/pageSize*pageSize+1;
		int endPage = startPage+pageSize-1;
		if(endPage>totPage) {
			endPage = totPage;
		}
		
		String pageStr="";
		if(startPage>1) {
			pageStr += "<a href='listMeeting?pageNo="+(startPage-1)+"'> < </a>"+"  ";
		}
		for(int i=startPage;i<=endPage;i++) {
			pageStr += "<a href='listMeeting?pageNo="+i+"'>"+i+"</a>"+"  ";
		}
		if(totPage>endPage) {
			pageStr += "<a href='listMeeting?pageNo="+(endPage+1)+"'> > </a>";
		}
		
		// 페이지에 출력되는 레코드 번호
		int start = (pageNo-1)*recordSize+1;
		int end = start+recordSize-1;
		if(end>totRecord) {
			end = totRecord;
		}
		HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		
		System.out.println("===================");
		System.out.println("totRecord: "+totRecord+" /totPage: "+totPage);
		System.out.println("start: "+start+" /end: "+end);
		System.out.println("startPage: "+startPage+" /endPage: "+endPage);
		
		model.addAttribute("pageStr", pageStr);
		model.addAttribute("list", mdao.listMeeting(map));
	}
	
	@RequestMapping("/detailMeeting")
	public void detailMeeting(Model model, int m_no, MeetingVo m) {
		mdao.updateHit(m_no);
		MeetingVo mt = mdao.detailMeeting(m_no);
		int c_no = mt.getC_no();
		model.addAttribute("mt", mt);
		model.addAttribute("cntRep", mdao.cntRep(m_no));
		model.addAttribute("mr", mdao.detailMRep(m_no));
		model.addAttribute("mf", mdao.detailMFile(m_no));
	}
	
	@RequestMapping(value = "/detailMRep", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String detailMrep(int m_no) {
		Gson gson = new Gson();
		return gson.toJson(mdao.detailMRep(m_no));
	}
	
	@RequestMapping("/deleteMeeting")
	public ModelAndView deleteMeeting(int m_no, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("redirect:/listMeeting");
		
		/*
		String path = request.getRealPath("meetingFile");
		String oldFname = mdao.detailMFile(m_no).getMf_savename();
		int mf_no = mdao.detailMFile(m_no).getMf_no();
		
		
		
		int re = 0;
		re = mdao.deleteMf(m_no);
		if(re<=0) {
			mav.addObject("msg", "죄송합니다.\n게시글 삭제에 오류가 발생했습니다.");
			mav.setViewName("error");
		} else {
			mdao.deleteMeeting(m_no);
			if (mf_no>0) {
				File file = new File(path+"/"+oldFname);
				file.delete();
			}
		}
		*/
		
		
		return mav;
	}
	
}