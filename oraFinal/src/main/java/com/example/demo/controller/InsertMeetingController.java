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

import com.example.demo.vo.MemberVo;
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
	public ModelAndView insertSubmit(HttpServletRequest request, HttpSession session, MeetingVo mt, Meeting_fileVo mf) {
		ModelAndView mav = new ModelAndView("redirect:/listMeeting");
		MeetingVo mtvo = new MeetingVo();
		
		int m_no = mdao.NextMNum();
		mtvo.setM_no(m_no);
		mtvo.setC_no(mt.getC_no());
		MemberVo mbvo = (MemberVo)session.getAttribute("m");
		mtvo.setId(mbvo.getId());
		mtvo.setM_title(mt.getM_title());
		mtvo.setM_content(mt.getM_content());
		mtvo.setM_latitude(mt.getM_latitude());
		mtvo.setM_longitude(mt.getM_longitude());
		mtvo.setM_locname(mt.getM_locname());
		mtvo.setM_time(mt.getM_time());
		mtvo.setM_numpeople(mt.getM_numpeople());
	
		System.out.println("*** mtvo(IsrtM cntr) : "+mtvo.toString());
		int re = 0;
		re = mdao.insertMeeting(mtvo);
		
		MultipartFile uploadFile = mf.getUploadFile();
		String mf_name = uploadFile.getOriginalFilename();
		
		if(re>0) {
			if(mf_name!=null&&!mf_name.equals("")) {
				
				// 랜덤한 숫자 6
				String a = String.valueOf(System.currentTimeMillis());
				String random = a.substring(7);
				
				// 사진 등록
				Meeting_fileVo mfvo = new Meeting_fileVo();
				mfvo.setMf_no(mdao.NextMfNum());
				mfvo.setM_no(m_no);
				mfvo.setMf_name(mf_name);
				String mf_savename = random+mf_name;
				mfvo.setMf_savename(mf_savename);
				mfvo.setMf_path("meetingFile");
				mfvo.setMf_size(uploadFile.getSize());
				
				System.out.println("*** mf_name(IsrtM Cntr) : "+mf_name);
				System.out.println("*** mf_savename(IsrtM Cntr) : "+mf_savename);
				System.out.println("*** mf(IsrtM Cntr) : "+mf.toString());
				int re_mf = 0;
				re_mf = mdao.insertMFile(mfvo);
				
				if(re_mf>0) {
					String path = request.getRealPath("/meetingFile");
					System.out.println("*** path(IsrtM Cntr) : "+path);
					try {
						byte []data = uploadFile.getBytes();
						FileOutputStream fos = new FileOutputStream(path+"/"+mf_savename);
						fos.write(data);
						fos.close();
					} catch (Exception e) {
						// TODO: handle exception
						System.out.println("insertCntr size exp : "+e.getMessage());
					}	
				}
			}
		} else {
			mav.addObject("msg", "게시글 등록에 실패하였습니다.");
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

