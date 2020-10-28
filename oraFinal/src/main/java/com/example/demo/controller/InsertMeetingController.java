package com.example.demo.controller;

import java.io.FileOutputStream;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.ResponseDataCode;
import com.example.demo.dao.CourseDao;
import com.example.demo.dao.MeetingDao;
import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.Meeting_fileVo;
import com.example.demo.vo.Meeting_repVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class InsertMeetingController {
	@Autowired
	@Setter
	CourseDao cdao;
	
	@Autowired
	@Setter
	MeetingDao mdao;
	
	
	@GetMapping("/insertMeeting")
	public void insertMeetingForm(HttpSession session, Model model) {
		model.addAttribute("cList", cdao.listCourse());
	}

	@PostMapping("/insertMeeting")
	public ModelAndView insertSubmit(HttpServletRequest request, HttpSession session, MeetingVo m, Meeting_fileVo mf) {
		ModelAndView mav = new ModelAndView("redirect:/listMeeting");
		int m_no = mdao.NextMNum();
		m.setM_no(m_no);
		int re = 0;
		re = mdao.insertMeeting(m);
		
		
		// 랜덤한 숫자 6
		String a = String.valueOf(System.currentTimeMillis());
		String random = a.substring(0, 6);
		System.out.println("랜덤한 숫자: "+random);
		
		// 사진 등록
		String path = request.getRealPath("/meetingFile");
		System.out.println("path : "+path);
		MultipartFile uploadFile = mf.getUploadFile();
		String mf_name = uploadFile.getOriginalFilename();
		String mf_savename = random+mf_name;
		System.out.println("** mf_name : "+mf_name);
		System.out.println("** mf_savename : "+mf_name);
		
		int mf_size = 0;
		byte data[] = null;
		if(mf_name!=null &&!mf_name.equals("")) {
			try {
				data = uploadFile.getBytes();
				mf_size = data.length;
				System.out.println("** mf_size : "+mf_size);	
				FileOutputStream fos = new FileOutputStream(path+"/"+mf_savename);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("insertCntr size exp : "+e.getMessage());
			}
			
		} else {
			mf_name = "";
			mf_savename = "";
		}
		
		mf.setMf_no(mdao.NextMfNum());
		mf.setM_no(m_no);
		mf.setMf_name(mf_name);
		mf.setMf_savename(mf_savename);
		mf.setMf_path("meetingFile");
		mf.setMf_size(mf_size);
		mdao.insertMFile(mf);
		
		System.out.println("m : "+m.toString());
		System.out.println("mf : "+mf.toString());
		
		if(re<=0) {
			mav.addObject("msg", "게시물 등록에 실패하였습니다.");
			mav.setViewName("error");
		}
		return mav;
	}
	
	@GetMapping(value = "/getCourseByMeeting", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getCourseByMeeting(HttpServletRequest request,int c_no) {
		String path = request.getRealPath("/courseLine")+"/";
		Gson gson = new Gson();
		return gson.toJson(cdao.getCourseByCno(c_no, path));
	}
	
	@PostMapping(value = "/user/insertMeetingRep", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String insertMeetingRep(HttpSession session, int m_no, int pmr_ref, String content, String nickName) throws Exception {
		if(session.getAttribute("m") == null) {
			throw new Exception();
		}
		
		MemberVo m = (MemberVo)session.getAttribute("m");

		int mr_no = mdao.NextMrNum();
		String id = m.getId();
		int mr_ref = mr_no;
		int mr_step = 0;
		String mr_content = " "+content; // 한칸띄우는건 @닉네임 없을 시 그냥 나오게끔 하기위함임
		if(pmr_ref > 0) {  // 그냥 댓글일경우 부모댓글레퍼런스를 0번으로 줄거임
			mr_ref = pmr_ref;
			mr_step = mdao.nextStep(mr_ref);
			if(!m.getNickName().equals(nickName)) {
				mr_content = "@"+ nickName + mr_content;
			}	
		}
		Meeting_repVo mr = new Meeting_repVo(mr_no, m_no, id, mr_content, null, mr_ref, mr_step, "0", null, null);
		System.out.println(mr);
		int re = 0;
		re = mdao.insertMRep(mr);

		ResponseDataVo responseDataVo = new ResponseDataVo();
		responseDataVo.setCode(ResponseDataCode.ERROR);
		if(re>0) {
			responseDataVo.setCode(ResponseDataCode.SUCCESS);
		}
		return new Gson().toJson(responseDataVo);
	}
}

