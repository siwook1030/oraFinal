package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dao.NoticeDao;

import lombok.Setter;

@Controller
public class DeleteNoticeController {

	@Autowired
	@Setter
	private NoticeDao ndao;
	
	@GetMapping(value = "/deleteNotice")
	public ModelAndView form(int n_no) {
		ModelAndView mav = new ModelAndView();
		ndao.deleteNotice(n_no);
		mav.setViewName("redirect:/listNotice");
		return mav;

	}
	
	
}
