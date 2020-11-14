package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.ResponseDataCode;
import com.example.demo.dao.NoticeDao;
import com.example.demo.vo.NoticeVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class UpdateNoticeController {

	@Autowired
	@Setter
	private NoticeDao ndao;
	
	@GetMapping(value = "/admin/updateNotice")
	public void form(Model model, int n_no) {
		model.addAttribute("n", ndao.selectByN_NO(n_no));
		model.addAttribute("category", ndao.getBoardCategory("006")); // 006코드는 공지사항
	}
	
	@PostMapping(value = "/admin/updateNotice", produces = "application/json; charset=utf8")
	@ResponseBody
	public String submit(NoticeVo n) {
		System.out.println("노티스 : " +n);
		int re = ndao.updateNotice(n);
		ResponseDataVo responseDataVo = new ResponseDataVo();
		responseDataVo.setCode(ResponseDataCode.ERROR);
		responseDataVo.setMessage("등록에 실패하였습니다");
		if(re > 0) {
			responseDataVo.setCode(ResponseDataCode.SUCCESS);
			responseDataVo.setMessage("등록에 성공하였습니다");
		}
		Gson gson = new Gson();
		return gson.toJson(responseDataVo);
	}
}
