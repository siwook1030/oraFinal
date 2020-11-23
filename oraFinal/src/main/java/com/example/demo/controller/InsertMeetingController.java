package com.example.demo.controller;

import java.io.FileOutputStream;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.admin.PointCause;
import com.example.demo.admin.PointGet;
import com.example.demo.dao.CourseDao;
import com.example.demo.dao.MeetingDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.util.FileUtilCollection;
import com.example.demo.util.ResponseDataCode;
import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.Meeting_fileVo;

import com.example.demo.vo.MemberVo;
import com.example.demo.vo.PointVo;
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
	
	@Autowired
	@Setter
	MemberDao memberDao;
	
	@GetMapping("/user/insertMeeting")
	public void insertMeetingForm(HttpSession session, Model model) {
		model.addAttribute("cList", cdao.listCourse());
		model.addAttribute("m_no",mdao.NextMNum());
	}

	@PostMapping(value = "/user/insertMeeting", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insertSubmit(HttpServletRequest request, @RequestParam HashMap map, List<MultipartFile> uploadMtFiles) {
		System.out.println("***map : "+map);
		System.out.println("***uploadMtFiles : "+uploadMtFiles);
		
		int m_no = mdao.NextMNum();
		int c_no = Integer.parseInt((String)map.get("c_no"));
		String id = (String)map.get("id");
		String m_title = (String)map.get("m_title");
		String m_content = (String)map.get("m_content");
		Date m_regdate = null;
		int m_hit = 0;
		double m_latitude = Double.parseDouble((String)map.get("m_latitude"));
		double m_longitude = Double.parseDouble((String)map.get("m_longitude"));
		String m_locname = (String)map.get("m_locname");
		Date m_time = Date.valueOf((String)map.get("m_time"));
		int m_numpeople = Integer.parseInt((String)map.get("m_numpeople"));
		String nickName = "";
		String c_name = "";
		String rank_icon = "";
		
		MeetingVo mtvo = new MeetingVo(m_no, c_no, id, m_title, m_content, m_regdate, m_hit, m_latitude, m_longitude, m_locname, m_time, m_numpeople, nickName, c_name, rank_icon, null, 0, 0, null);

		//System.out.println(mtvo.toString());
		int re = mdao.insertMeeting(mtvo);
		
		List<Meeting_fileVo> mfvo = new ArrayList<Meeting_fileVo>();
		String path = request.getRealPath("/meetingFile");
		int re_mf = 0;
		if(uploadMtFiles.size()>0) {
			for(MultipartFile mf: uploadMtFiles) {
				int mf_no = 0;
				int mt_no = m_no;
				String mf_name = mf.getOriginalFilename();
				String mf_savename = FileUtilCollection.filePrefixName()+mf_name;
				String mf_path = "meetingFile";
				long mf_size = mf.getSize();	
				mfvo.add(new Meeting_fileVo(mf_no, m_no, mf_name, mf_savename, mf_path, mf_size));
			}
			re_mf = mdao.insertMFile(mfvo);
		}
		
		if(re>0) {
			if(uploadMtFiles.size()>0) {
				for(int i=0; i<uploadMtFiles.size(); i++) {
					try {
						byte []data = uploadMtFiles.get(i).getBytes();
						FileOutputStream fos = new FileOutputStream(path+"/"+mfvo.get(i).getMf_savename());
						fos.write(data);
						fos.close();
					} catch (Exception e) {
						// TODO: handle exception
						System.out.println("insertCntr size exp : "+e.getMessage());
					}	
				}
			}
		} 
		return Integer.toString(m_no);
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
		//System.out.println(mr);
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

