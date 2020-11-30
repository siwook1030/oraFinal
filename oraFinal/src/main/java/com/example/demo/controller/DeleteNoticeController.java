package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dao.NoticeDao;
import com.example.demo.util.FileUtilCollection;
import com.example.demo.vo.NoticeVo;

import lombok.Setter;

@Controller
public class DeleteNoticeController {

	@Autowired
	@Setter
	private NoticeDao ndao;
	
	@GetMapping(value = "/admin/deleteNotice")
	public ModelAndView form(int n_no, HttpServletRequest request) {
		NoticeVo nvo = ndao.detailNotice(n_no);
		
		ModelAndView mav = new ModelAndView();
		int re = ndao.deleteNotice(n_no);
		if (re > 0) {
			if (nvo.getN_file()!=null) {
				String path = request.getRealPath("/noticeImg") + "/" + nvo.getN_file();
				FileUtilCollection.deleteFile(path);
			}
		}
		mav.setViewName("redirect:/listNotice");
		return mav;

	}
	
	
}
