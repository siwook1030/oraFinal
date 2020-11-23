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
import com.google.gson.Gson;

@Controller
public class NoticeController {
	
	public static int totRecord = 0; // 총 게시글 수
	public static int recordSize = 8; // 한 번에 보이는 게시글 수
	public static int totPage = 0; // 총 페이지 수
	public static int pageSize = 2; // 한 번에 보이는 페이지 수
	
	@Autowired
	private NoticeDao ndao;
	
	public void setDao(NoticeDao ndao) {
		this.ndao = ndao;
	}
	
	@RequestMapping("/listNotice")
	public void listNotice(Model model) {
		System.out.println("작동함!!");
		model.addAttribute("category", ndao.getBoardCategory("006"));
		model.addAttribute("recordSize", recordSize);
		model.addAttribute("pageSize", pageSize);
	}
	
	@RequestMapping(value = "/listNoticeJson", produces = "appliction/json; charset=utf-8")
	@ResponseBody
	public String listMeetingJson(Model model, int pageNo,@RequestParam(defaultValue ="")String searchText,@RequestParam(defaultValue ="0")String code_value) {
		System.out.println("Asdasd");
		Gson gson = new Gson();
		HashMap map = new HashMap();
		map.put("searchText", searchText);
		map.put("code_value", code_value);
		totRecord = ndao.totNRecord(map); 
		System.out.println("=========================");
		System.out.println("*** totRecord : "+totRecord);
		System.out.println("*** recordSize : "+recordSize);
		System.out.println("*** pageNo : "+pageNo);
		
		// 페이지에 출력되는 레코드 번호
		int start = (pageNo-1)*recordSize+1;
		int end = start+recordSize-1;
		if(end>totRecord) {
			end = totRecord;
		}
		
		System.out.println("*** start : "+start);
		System.out.println("*** end : "+end);
		
		map.put("start", start);
		map.put("end", end);
		map.put("totRecord", totRecord);
		map.put("list", ndao.listNotice(map));
		//System.out.println("*** : "+gson.toJson(map));
		return gson.toJson(map);
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
