package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dao.NoticeDao;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeDao ndao;
	
	public void setDao(NoticeDao ndao) {
		this.ndao = ndao;
	}
	
	@RequestMapping("/listNotice")
	public void listNotice(Model model) {
		model.addAttribute("list",ndao.listNotice());
	}
	
	@RequestMapping("/detailNotice")
	public void detailNotice(int n_no,Model model) {
		model.addAttribute("n",ndao.detailNotice(n_no));
	}
}
