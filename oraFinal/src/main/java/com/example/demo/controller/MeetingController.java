package com.example.demo.controller;

import java.io.File;
import java.sql.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.ResponseDataCode;
import com.example.demo.dao.CourseDao;
import com.example.demo.dao.MeetingDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.MemberVo;

import com.example.demo.vo.Meeting_fileVo;
import com.example.demo.vo.Meeting_peopleVo;
import com.example.demo.vo.Meeting_repVo;
import com.example.demo.vo.MemberVo;

import com.example.demo.vo.ResponseDataVo;
import com.fasterxml.jackson.annotation.JacksonInject.Value;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class MeetingController {
	@Autowired
	private MeetingDao mdao;
	
	@Autowired
	private CourseDao cdao;
	
	public static int totRecord = 0; // 총 게시글 수
	public static int recordSize = 6; // 한 번에 보이는 게시글 수
	public static int totPage = 0; // 총 페이지 수
	public static int pageSize = 2; // 한 번에 보이는 페이지 수
	
	public static int recordSizeR = 10; // 한 번에 보이는 댓글게시글 수
	public static int pageSizeR = 5; // 한 번에 보이는 댓글페이지 수
	
	HashMap map = new HashMap();
	
	@RequestMapping("/listMeeting")
	public void listMeeting(Model model) {
		model.addAttribute("recordSize", recordSize);
		model.addAttribute("pageSize", pageSize);
	}

	@RequestMapping(value = "/listMeetingJson", produces = "appliction/json;charset=utf-8")
	@ResponseBody
	public String listMeetingJson(Model model, int pageNo) {
		Gson gson = new Gson();
		HashMap map = new HashMap();
		totRecord = mdao.totMRecord(); 
		System.out.println("=========================");
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
		map.put("list", mdao.listMeeting(map));
		//System.out.println("*** : "+gson.toJson(map));
		return gson.toJson(map);
	}
	
	
	@RequestMapping(value = "/detailMeeting", produces = "application/json;charset=utf-8")
	public void detailMeeting(HttpServletRequest request, Model model, int m_no) {
		String path = request.getRealPath("/courseLine")+"/";
		mdao.updateHit(m_no);
		MeetingVo mt = mdao.detailMeeting(m_no);
		int c_no = mt.getC_no();
		
		int totalRecordR = mdao.cntRep(m_no);
		int totalPageNum = (int)Math.ceil((double)totalRecordR/recordSizeR);
		System.out.println("토탈페이지넘 : " +totalPageNum);
		int start = 1;
		int end = start+recordSizeR-1;
			
		//HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("m_no", m_no);
		
		Gson gson = new Gson();
		model.addAttribute("mrList", gson.toJson(mdao.detailMRep(map)));
		model.addAttribute("m_no", gson.toJson(m_no));
		model.addAttribute("totalRecordR", gson.toJson(totalRecordR));
		model.addAttribute("totalPageNum", gson.toJson(totalPageNum));
		model.addAttribute("pageSizeR", gson.toJson(pageSizeR));
		model.addAttribute("cJson", gson.toJson(cdao.getCourseByCno(c_no, path)));
		model.addAttribute("mt", mt);			
		model.addAttribute("mf", gson.toJson(mdao.detailMFile(m_no)));
	}
	
	
	@GetMapping(value = "/detailMRep", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String detailMrep(int m_no, int num) {
		int end = num*recordSizeR;
		int start = end-recordSizeR+1;
		
		//HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("m_no", m_no);
		
		int totalRecordR = mdao.cntRep(m_no);
		int totalPageNum = (int)Math.ceil((double)totalRecordR/MeetingController.recordSizeR);
		map.put("mrList", mdao.detailMRep(map));
		map.put("totalRecordR", totalRecordR);
		map.put("totalPageNum", totalPageNum);
		Gson gson = new Gson();
		return gson.toJson(map);
	}
	
	@GetMapping(value = "/user/updateMeeting", produces = "application/json; charset=utf-8")
	public void updateMForm(HttpServletRequest request, int m_no, Model model, int c_no) {	
		System.out.println("작동완");
		Gson gson = new Gson();
		String path = request.getRealPath("/couraseLine");
		MeetingVo mt = mdao.detailMeeting(m_no);
		List<Meeting_fileVo> mf = mdao.detailMFile(m_no);
		model.addAttribute("mt", mt);
		model.addAttribute("mtJson", gson.toJson(mt));
		model.addAttribute("mfJson", gson.toJson(mdao.detailMFile(m_no)));
		model.addAttribute("cs", cdao.getCourseByCno(c_no, path));
		model.addAttribute("cList", cdao.listCourse());
		//System.out.println("*** mt(updtMtng) : "+mt);
		//System.out.println("*** mf(updtMtng) : "+mf);

	}
	
	@PostMapping(value = "/user/updateMeeting", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updateMSubmit(@RequestParam HashMap map, HttpServletRequest request, List<MultipartFile> uploadMtFiles) {
		//System.out.println("*** map(updtCntr Sbmt) : "+map);
		
		int m_no = Integer.parseInt((String)map.get("m_no"));
		int c_no = Integer.parseInt((String)map.get("c_no"));
		String id = "";
		String m_title = (String)map.get("m_title");
		String m_content = (String)map.get("m_content");
		String m_regdate = null;
		int m_hit = 0;
		double m_latitude = Double.parseDouble((String)map.get("m_latitude"));
		double m_longitude = Double.parseDouble((String)map.get("m_longitude"));
		String m_locname = (String)map.get("m_locname");
		Date m_time = Date.valueOf((String)map.get("m_time"));
		int m_numpeople = Integer.parseInt((String)map.get("m_numpeople"));
		String nickName = "";
		String c_name = "";
		String rank_icon = "";
		
		MeetingVo mtvo = new MeetingVo(m_no, c_no, id, m_title, m_content, m_regdate, m_hit, m_latitude, m_longitude, m_locname, m_time, m_numpeople, nickName, c_name, rank_icon);
		//System.out.println(mtvo.toString());
		int re = mdao.updateMeeting(mtvo);
		
 
		
		
		
//		int re = mdao.updateMeeting(mt);
//		if(re>0 ) {
//			//System.out.println("*** mf(updtCntr Sbmt) : "+mf);
//			
//			// 서버에 저장된 이전 파일 이름
//			String oldFname = mf.getMf_savename();
//			//System.out.println("*** oldFname : "+oldFname);
//			
//			// 저장경로
//			String path = request.getRealPath("meetingFile");
//			
//			// 새로 업로드 되는 파일 이름
//			String mf_name = null;
//			//MultipartFile uploadFile = mf.getUploadFile();
//			//System.out.println("*** uploadFile : "+uploadFile);
//			//mf_name = uploadFile.getOriginalFilename();
//			//System.out.println("*** mf_name : "+mf_name);
			
//			
//		} else {
//
//		}
		
		
		return Integer.toString(m_no);
	}
	
	@RequestMapping("/deleteMeeting")
	public ModelAndView deleteMeeting(int m_no, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("redirect:/listMeeting");
		System.out.println("*** m_no(deleteM cntr) : "+m_no);
		
		String path = request.getRealPath("meetingFile");
		System.out.println("*** path (DltMtng Cntr) : "+path);		
		File file = null;
		int re = 0;
		
		// 모임인원 삭제
		List<Meeting_peopleVo> listMP = mdao.detailMPeople(m_no);
		if(listMP.size()>0) {
			re = mdao.deleteMPeople(m_no);
			if(re<=0) {
				mav.addObject("msg", "파일삭제에 실패했습니다.");
				mav.setViewName("error");
			}
		}
		
		// 댓글삭제
		// 댓글사진삭제
		map.put("start", 1);
		map.put("end", mdao.cntRep(m_no));
		map.put("m_no", m_no);
		List<Meeting_repVo> listMR = mdao.detailMRep(map);
		if(listMR.size()>0) {
			re = mdao.deleteMRep(m_no);
			if(re<=0) {
				mav.addObject("msg", "파일삭제에 실패했습니다.");
				mav.setViewName("error");
			} else {
				for(Meeting_repVo list:listMR) {
					String oldFname = list.getMr_file1();
					file = new File(path+"/"+oldFname);
					file.delete();
				}
			}
		}
		

		// 첨부파일삭제
		// 저장된파일삭제
		List<Meeting_fileVo> listMF = mdao.detailMFile(m_no);
		if(listMF.size()>0) {
			re = mdao.deleteMFile(m_no);
			if(re<=0) {
				mav.addObject("msg", "파일삭제에 실패했습니다.");
				mav.setViewName("error");
			} else {
				for(Meeting_fileVo list:listMF) {
					String oldFname = list.getMf_savename();
					file = new File(path+"/"+oldFname);
					file.delete();
				}
			}
		}
		
		// 모임인원, 댓글, 첨부파일 삭제 성공시 미팅게시판 삭제
		re = mdao.deleteMeeting(m_no);
		if(re<=0) {
			mav.addObject("msg", "파일삭제 실패했습니다.");
			mav.setViewName("error");
		}
	
		return mav;
	}
	public String getMemberId(HttpSession httpSession) {
		MemberVo m = (MemberVo)httpSession.getAttribute("m");
		return m.getId();
	}
	
	//내 게시물 목록
	@RequestMapping("/myPageListMeeting")
	public void myPageListMeeting(Model model, @RequestParam(value = "pageNo", defaultValue = "1") int pageNo, MeetingVo m,HttpSession httpSession) {
		totRecord = mdao.myTotMRecord(getMemberId(httpSession));
		totPage = (int)Math.ceil((double)totRecord/recordSize);
		
		// 페이지 버튼 숫자
		int startPage = (pageNo-1)/pageSize*pageSize+1;
		int endPage = startPage+pageSize-1;
		if(endPage>totPage) {
			endPage = totPage;
		}
		
		String pageStr="";
		if(startPage>1) {
			pageStr += "<a href='myPageListMeeting?pageNo="+(startPage-1)+"'> < </a>"+"  ";
		}
		for(int i=startPage;i<=endPage;i++) {
			pageStr += "<a href='myPageListMeeting?pageNo="+i+"'>"+i+"</a>"+"  ";
		}
		if(totPage>endPage) {
			pageStr += "<a href='myPageListMeeting?pageNo="+(endPage+1)+"'> > </a>";
		}
		
		// 페이지에 출력되는 레코드 번호
		int start = (pageNo-1)*recordSize+1;
		int end = start+recordSize-1;
		if(end>totRecord) {
			end = totRecord;
		}
		HashMap map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("id", getMemberId(httpSession));
		
		System.out.println("===================");
		System.out.println("totRecord: "+totRecord+" /totPage: "+totPage);
		System.out.println("start: "+start+" /end: "+end);
		System.out.println("startPage: "+startPage+" /endPage: "+endPage);
		
		model.addAttribute("pageStr", pageStr);
		model.addAttribute("list", mdao.myPageListMeeting(map));
	}
	
	@PostMapping(value = "/user/deleteMeetingRep", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteMeetingRep(int m_no, int mr_no) {
		int re = 0;
		re = mdao.deleteMr(mr_no);
		
		ResponseDataVo responseDataVo = new ResponseDataVo();
		responseDataVo.setCode(ResponseDataCode.ERROR);
		if(re>0) {
			responseDataVo.setCode(ResponseDataCode.SUCCESS);
		}
		return new Gson().toJson(responseDataVo);
	}
	
}