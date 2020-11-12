package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.dao.NoticeDao;

import lombok.Setter;

@Controller
public class DeleteNoticeController {

//	@Autowired
//	@Setter
//	private NoticeDao ndao;
//	
//	@GetMapping(value = "/admin/updateNotice")
//	public void form(Model model, int n_no) {
//		model.addAttribute("n", ndao.selectByN_NO(n_no));
//		model.addAttribute("category", ndao.getBoardCategory("006")); // 006코드는 공지사항
//	}
	
	
}
