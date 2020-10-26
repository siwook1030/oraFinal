package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dao.NoticeDao;
import com.example.demo.vo.NoticeVo;

@Controller
@RequestMapping("/insertNotice")
public class InsertNoticeController {

	@Autowired
	private NoticeDao dao;
	
	public void setDao(NoticeDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public void form() {		
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView submit(NoticeVo n) {
		ModelAndView mav = new ModelAndView("redirect:/listNotice");
		int re = dao.insert(n);
		if(re <= 0) {
			mav.addObject("msg", "공지사항 등록에 실패하였습니다.");
			mav.setViewName("error");
		}
		return mav;
	}
}
