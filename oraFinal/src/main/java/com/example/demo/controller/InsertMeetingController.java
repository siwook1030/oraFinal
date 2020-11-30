package com.example.demo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.RequestMapping;
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
import com.example.demo.vo.Meeting_tempVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.ResponseDataVo;
import com.example.demo.vo.Review_fileVo;
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
		MemberVo mvo = (MemberVo)session.getAttribute("m");
		Meeting_tempVo mtvo = mdao.selectTemp(mvo.getId());
		if(mtvo != null) {
			String m_title = mtvo.getM_title();
			if(m_title != null) {
				m_title = m_title.replace("\"", "\\\"").replace("\'", "\\\'");		// JS에서 원활한 string처리를 위해 변경처리
			}
			String m_content = mtvo.getM_content();
			if(m_content != null) {
				m_content = m_content.replace("\"", "\\\"").replace("\'", "\\\'");	// JS에서 원활한 string처리를 위해 변경처리
			}
			mtvo.setM_title(m_title);
			mtvo.setM_content(m_content);
		}
		//System.out.println("글제목:"+mtvo.getM_title());
		model.addAttribute("mtvo", mtvo);
		model.addAttribute("cList", cdao.listCourse());
		model.addAttribute("m_no",mdao.NextMNum());
		
	}

	@PostMapping(value = "/user/insertMeeting", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insertSubmit(HttpServletRequest request, @RequestParam HashMap map) {
		//System.out.println("***map : "+map);
		
		int m_no = mdao.NextMNum();
		int c_no = Integer.parseInt((String)map.get("c_no"));
		String id = (String)map.get("id");
		String m_title = (String)map.get("m_title");
		String m_content = (String)map.get("real_content");
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
		
		MeetingVo mvo = new MeetingVo(m_no, c_no, id, m_title, m_content, m_regdate, m_hit, m_latitude, m_longitude, m_locname, m_time, m_numpeople, nickName, c_name, rank_icon, null, 0, 0, null);
		
    //System.out.println(mtvo.toString());
		int re = mdao.insertMeeting(mvo);
		
		if(re > 0) {	// mvo insert성공 시
			//System.out.println("url들:"+ (String)map.get("image_urls"));
			String str = (String)map.get("image_urls");		// 사진없으면 ''임.
			if(!str.equals("")) {	// 사진 1개이상있으면
				String[] image_urls = str.split(",");	// JS에서 FormData로 배열 보낼경우 쉼표(,)로 구분해서 보내짐.
				String path = request.getServletContext().getRealPath("/");
				
				// autosave하면 사진파일은 저장되지만 review_file테이블에는 저장되지 않는다.
				// 저장하지 않아도 image_urls를 통해서 저장된 img파일명을 알 수 있다.
				for(int i = 0; i < image_urls.length; i++) {
					Meeting_fileVo mfvo = new Meeting_fileVo();
					mfvo.setMf_no(0);
					mfvo.setM_no(m_no);
					String mf_savename = image_urls[i].substring(image_urls[i].lastIndexOf("/") + 1);
					String decodeResult = "";
					try {
						// DB에 파일명을 저장할때 실제파일명이 저장되도록 decode처리한다.
						decodeResult = URLDecoder.decode(mf_savename, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					mfvo.setMf_savename(decodeResult);
					String mf_name = decodeResult.substring(6);
					mfvo.setMf_name(mf_name);
					String mf_path = "meetingFile";
					mfvo.setMf_path(mf_path);
					File file = new File(path+"/"+mf_path+"/"+mf_savename);
					long mf_size = file.length();
					mfvo.setMf_size(mf_size);
					mdao.insertMFile(mfvo);
				}
			}
			mdao.deleteTemp(id);	// review테이블에 insert성공 후 임시테이블의 record삭제
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
	
	// ckeditor image insert 설정
	@RequestMapping(value = "/meetingImageInsert", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String meetingImageInsert(MultipartFile upload, HttpServletRequest request) {
		// ckeditor에서 image insert를 매개변수로 받을 때 반드시 upload로 설정해야 한다.
		String uploadFolder = request.getHeader("uploadFolder");
		String mf_name = upload.getOriginalFilename();
		String path = request.getServletContext().getRealPath("/");
		System.out.println("path:"+path);
		String rand = String.valueOf(System.currentTimeMillis());
		String randCode = rand.substring(rand.length() - 6);
		String mf_savename = randCode + mf_name;
		try {
			byte[] data = upload.getBytes();
			FileOutputStream fos = new FileOutputStream(path+"/"+uploadFolder+"/"+mf_savename);
			fos.write(data);
			fos.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		Gson gson = new Gson();
		String encodeResult = "";
		try {
			// 사진 파일명에 특수문자 있을 경우 엑박뜨기때문에 URL퍼센트인코딩해준다. 공백문자를 '+'로 바꾸기 때문에 ' '문자로 다시 바꿔준다.
			encodeResult = URLEncoder.encode(mf_savename, "UTF-8").replace("+", "%20");
		}catch (Exception e) {
			// TODO: handle exception
		}
		HashMap<String, String> map = new HashMap<String, String>();
		// ckeditor에 image insert 성공에 대한 응답으로 url : [image경로]를 반환해야 한다. 그래야만 editor에 이미지가 표시된다.
		map.put("url", "/"+uploadFolder+"/"+encodeResult);
		return gson.toJson(map);
	}
	
	// ckeditor image를 사용자가 선택해서 delete할 경우
	@RequestMapping(value = "/meetingImageDelete", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void meetingImageDelete(String[] urls, HttpServletRequest request) {
		// 수정하다가 취소할 경우 사진이 여러개라면 모두 삭제하기 위해 배열로 받아서 처리한다.
		String uploadFolder = request.getHeader("uploadFolder");
		String path = request.getServletContext().getRealPath("/");
		for(String url : urls) {
			String fname = url.substring(url.lastIndexOf("/")+1);
			String decodeResult = "";
			try {
				decodeResult = URLDecoder.decode(fname, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			File file = new File(path + "/"+uploadFolder+"/" + decodeResult);
			file.delete();
		}
	}
	
	// ckeditor 글내용 변화에 따른 autosave처리.
	@RequestMapping(value = "/meetingAutoSave", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void meetingAutoSave(Meeting_tempVo mtvo, HttpSession session, String temp_time) {
		MemberVo mvo = (MemberVo)session.getAttribute("m");
		mtvo.setId(mvo.getId());
		if(!temp_time.equals("")) {
			mtvo.setM_time(Date.valueOf(temp_time));
		}
		System.out.println("주소:"+mtvo.getM_locname());
		mdao.updateTemp(mtvo);
	}
	
	
}

