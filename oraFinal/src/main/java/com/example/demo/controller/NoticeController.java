package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.NoticeDao;
import com.example.demo.vo.NoticeVo;

@Controller
public class NoticeController {
	
	public static int pageSIZE =  10;
	public static int totalCount  = 0;
	public static int totalPage = 1;
	
	@Autowired
	private NoticeDao ndao;
	
	public void setDao(NoticeDao ndao) {
		this.ndao = ndao;
	}
	
	@RequestMapping("/listNotice")
	public void listNotice() {
		
	}
	
	@RequestMapping(value = "/listNoticeJson", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void listNotice(Model model, @RequestParam(value = "pageNUM", defaultValue = "1") int pageNUM) {
		totalCount = ndao.getTotalCount();
		totalPage = (int)Math.ceil( (double)totalCount/pageSIZE ) ;
		int start = (pageNUM-1)*pageSIZE + 1;
		int end = start + pageSIZE;
		if(end > totalCount) {
			end = totalCount;
		}
		
		HashMap map = new HashMap();
		map.put("start",start);
		map.put("end",end);
		
		model.addAttribute("list",ndao.listNotice());
		model.addAttribute("category", ndao.getBoardCategory("006")); // 공지사항 코드 가져옴(006)
		model.addAttribute("totalPage", totalPage);
	}
	
	@RequestMapping("/detailNotice")
	public void detailNotice(int n_no,Model model) {
		ndao.updateHit(n_no); // 조회수 증가
		System.out.println(ndao.detailNotice(n_no));
		model.addAttribute("n",ndao.detailNotice(n_no));
	}
	
	@GetMapping(value = "/searchNotice", produces = "application/json; charset=utf8")
	@ResponseBody
	public List<NoticeVo> searchNotice(String code_value, String searchText) {
		HashMap map = new HashMap();
		map.put("code_value", code_value);
		map.put("searchText", searchText);
		
		return ndao.searchNotice(map);	
		
	}
}
