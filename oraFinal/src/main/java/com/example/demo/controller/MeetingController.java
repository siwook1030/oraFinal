package com.example.demo.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;

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

import com.example.demo.dao.CourseDao;
import com.example.demo.dao.MeetingDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.util.FileUtilCollection;
import com.example.demo.util.ResponseDataCode;
import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.MemberVo;

import com.example.demo.vo.Meeting_fileVo;
import com.example.demo.vo.Meeting_peopleVo;
import com.example.demo.vo.Meeting_repVo;
import com.example.demo.vo.Meeting_tempVo;
import com.example.demo.vo.MemberVo;

import com.example.demo.vo.ResponseDataVo;
import com.example.demo.vo.ReviewVo;
import com.example.demo.vo.Review_fileVo;
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
	public static int recordSize = 8; // 한 번에 보이는 게시글 수
	public static int totPage = 0; // 총 페이지 수
	public static int pageSize = 3; // 한 번에 보이는 페이지 수
	
	public static int recordSizeR = 10; // 한 번에 보이는 댓글게시글 수
	public static int pageSizeR = 5; // 한 번에 보이는 댓글페이지 수
	
	HashMap map = new HashMap();
	
	@RequestMapping(value = "/listMeeting", produces = "appliction/json;charset=utf-8" )
	public void listMeeting(Model model,String id) {
		model.addAttribute("recordSize", recordSize);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("id", id);
	}

	@RequestMapping(value = "/listMeetingJson", produces = "appliction/json;charset=utf-8")
	@ResponseBody
	public String listMeetingJson(Model model, int pageNo, String id) {
		Gson gson = new Gson();
		if (id.equals("null") || id.equals("") || id.equals(null) || "".equals(id) ||  "null".equals(id)) {
			id = "%";
		}
		
		totRecord = mdao.totMRecord(id); 
//		System.out.println("=========================");
//		System.out.println("*** totRecord"+totRecord);
//		System.out.println("*** recordSize : "+recordSize);
//		System.out.println("*** pageNo : "+pageNo);
		
		// 페이지에 출력되는 레코드 번호
		int start = (pageNo-1)*recordSize+1;
		int end = start+recordSize-1;
		if(end>totRecord) {
			end = totRecord;
		}
		
		//System.out.println("*** start : "+start);
		//System.out.println("*** end : "+end);
		map.put("start", start);
		map.put("end", end);
		map.put("totRecord", totRecord);
		map.put("id", id);
		map.put("list", mdao.listMeeting(map));
		
		//System.out.println("*** : "+gson.toJson(map));
		return gson.toJson(map);
	}
	
	
	@RequestMapping(value = "/detailMeeting", produces = "application/json;charset=utf-8")
	public void detailMeeting(HttpServletRequest request, Model model, int m_no) {
		String path = request.getRealPath("/courseLine")+"/";
		mdao.updateHit(m_no);
		MeetingVo mt = mdao.detailMeeting(m_no);
		List<Meeting_fileVo> mf = mdao.detailMFile(m_no);
		
		int c_no = mt.getC_no();
		
		int totalRecordR = mdao.cntRep(m_no);
		int totalPageNum = (int)Math.ceil((double)totalRecordR/recordSizeR);
		//System.out.println("토탈페이지넘 : " +totalPageNum);
		int start = 1;
		int end = start+recordSizeR-1;
			
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
		model.addAttribute("mf", mf);			
		model.addAttribute("mfJson", gson.toJson(mf));
	}
	
	@GetMapping(value = "/mPeopleList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String mPeopleList(int m_no) {
		
		return new Gson().toJson(mdao.detailMPeople(m_no));
	}
	
	@PostMapping(value = "/user/attendMpeople", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String attendMpeople(int m_no, String id) {
//		System.out.println(m_no);
//		System.out.println(id);
		int re = mdao.insertMPeople(new Meeting_peopleVo(id, m_no, "", "", ""));
		return Integer.toString(re); 
	}
	
	@PostMapping(value = "/user/deleteMpeople", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String deleteMpeople(int m_no, String id) {
		int re = mdao.deleteOneMp(new Meeting_peopleVo(id, m_no, "", "", ""));
		return Integer.toString(re);
	}
	
	@GetMapping(value = "/detailMRep", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String detailMrep(int m_no, int num) {
		int end = num*recordSizeR;
		int start = end-recordSizeR+1;
		
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
		//System.out.println("작동완");
		Gson gson = new Gson();
		String path = request.getRealPath("/courseLine");
		MeetingVo mt = mdao.detailMeeting(m_no);
		List<Meeting_fileVo> mf = mdao.detailMFile(m_no);
		String meetingFilePath = request.getServletContext().getRealPath("/meetingFile");
		String meetingFile_tempPath = request.getServletContext().getRealPath("/meetingFile_temp");
		for(Meeting_fileVo mfvo : mf) {
			try {
				String mf_savename = mfvo.getMf_savename();
				FileInputStream fis = new FileInputStream(meetingFilePath+"/"+mf_savename);
				byte[] data = fis.readAllBytes();
				fis.close();
				File file = new File(meetingFile_tempPath+"/"+mf_savename);
				FileOutputStream fos = new FileOutputStream(file);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		String m_title = mt.getM_title().replace("\"", "\\\"").replace("\'", "\\\'");		// JS에서 원활한 string처리를 위해 변경처리
		// 사진임시저장폴더의 이미지를 사용하기 위해 경로변경
		String m_content = mt.getM_content().replace("<img src=\"/meetingFile/", "<img src=\"/meetingFile_temp/");
		m_content = m_content.replace("\"", "\\\"").replace("\'", "\\\'");
				
		mt.setM_title(m_title);
		mt.setM_content(m_content);
		
		model.addAttribute("mt", mt);
		model.addAttribute("mf", mf);
		model.addAttribute("mtJson", gson.toJson(mt));
		model.addAttribute("mfJson", gson.toJson(mdao.detailMFile(m_no)));
		model.addAttribute("cs", cdao.getCourseByCno(c_no, path));
		model.addAttribute("cList", cdao.listCourse());
		//System.out.println("*** mt(updtMtng) : "+mt);
		//System.out.println("*** mf(updtMtng) : "+mf);

	}
	
	@PostMapping(value = "/user/updateMeeting", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String updateMSubmit(@RequestParam HashMap map, HttpServletRequest request) {
//		System.out.println("*** map(updtCntr Sbmt) : "+map);
		
		int m_no = Integer.parseInt((String)map.get("m_no"));
		int c_no = Integer.parseInt((String)map.get("c_no"));
		String id = "";
		String m_title = (String)map.get("m_title");
		String m_content = (String)map.get("real_content");
		m_content = m_content.replace("<img src=\"/meetingFile_temp/", "<img src=\"/meetingFile/");
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
		int re = mdao.updateMeeting(mtvo);
		if(re > 0) {	// mvo update성공 시
			List<Meeting_fileVo> mflist = mdao.detailMFile(m_no);
			String urls = (String)map.get("image_urls");
			
			if(!urls.equals("")) {	// 게시글에 사진이 있을 경우
				String[] image_urls = urls.split(",");	// JS에서 FormData로 배열 보낼경우 쉼표(,)로 구분해서 보내짐.
				String path = request.getServletContext().getRealPath("/");
				
				for(int i = 0; i < image_urls.length; i++) {
					String mf_savename = image_urls[i].substring(image_urls[i].lastIndexOf("/") + 1);
					String decodeResult = "";
					try {
						// DB에 decode된 파일명으로 저장되어있으므로 비교를 위해 똑같이 decode한다.
						decodeResult = URLDecoder.decode(mf_savename, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					File temp_file = new File(path+"/meetingFile_temp/"+decodeResult);
					
					boolean isNew = true;	// 신규 사진인지여부 저장 변수
					for(Meeting_fileVo mfvo : mflist) {
						if(decodeResult.equals(mfvo.getMf_savename())) {
							isNew = false;	// DB에 같은 사진이 있으면 false
							temp_file.delete();	// DB에 같은 사진이 있으므로 temp폴더의 사진 삭제
						}
					}
					if(isNew) {				// DB에 같은 사진이 없으면 insert처리
						Meeting_fileVo mfvo = new Meeting_fileVo();
						mfvo.setMf_no(0);	// 시퀀스 처리
						mfvo.setM_no(m_no);	
						mfvo.setMf_savename(decodeResult);
						String mf_name = decodeResult.substring(6);
						mfvo.setMf_name(mf_name);
						String mf_path = "meetingFile";
						mfvo.setMf_path(mf_path);
						long mf_size = temp_file.length();
						mfvo.setMf_size(mf_size);
						mdao.insertMFile(mfvo);
						// 임시폴더에서 원본폴더로 사진복사
						try {
							FileInputStream fis = new FileInputStream(temp_file);
							byte[] data = fis.readAllBytes();
							fis.close();
							temp_file.delete();		// 복사끝나면 임시파일 삭제
							File file = new File(path+"/meetingFile/"+decodeResult);
							FileOutputStream fos = new FileOutputStream(file);
							fos.write(data);
							fos.close();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}	
				}
				// 만약 수정하면서 게시글의 사진을 삭제했다면 DB에서도 제거해야 함. 따라서 게시글에 사진이 있든없든 검사해야함.
				for(Meeting_fileVo mfvo : mflist) {
					boolean isExist = false;	// DB의 사진이 수정된 게시글 사진목록에 존재여부
					for(int i = 0; i < image_urls.length; i++) {
						String mf_savename = image_urls[i].substring(image_urls[i].lastIndexOf("/") + 1);
						String decodeResult = "";
						try {
							// DB에 decode된 파일명으로 저장되어있으므로 비교를 위해 똑같이 decode한다.
							decodeResult = URLDecoder.decode(mf_savename, "UTF-8");
						} catch (UnsupportedEncodingException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
						if(mfvo.getMf_savename().equals(decodeResult)) {
							isExist = true;		// 게시글에 동일한 사진이 존재하면 true
							break;
						}
					}
					if(!isExist) {				// 게시글에 동일한 사진이 존재하지 않으면 삭제
						File file = new File(path+"/meetingFile/"+mfvo.getMf_savename());
						file.delete();
						mdao.deleteMfOne(mfvo.getMf_no());
					}
				}
			}else {		// 게시글에 사진이 없을 경우 전부 삭제
				mdao.deleteMFile(m_no);
			}
			
		}
		return Integer.toString(m_no);
	}
	
	@RequestMapping("/deleteMeeting")
	public ModelAndView deleteMeeting(int m_no, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("redirect:/listMeeting");
		// System.out.println("*** m_no(deleteM cntr) : "+m_no);
		
		String path = request.getRealPath("meetingFile");
		// System.out.println("*** path (DltMtng Cntr) : "+path);
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
		re = mdao.deleteMRep(m_no);
		

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
		map.put("start", start);
		map.put("end", end);
		map.put("id", getMemberId(httpSession));
		
//		System.out.println("===================");
//		System.out.println("totRecord: "+totRecord+" /totPage: "+totPage);
//		System.out.println("start: "+start+" /end: "+end);
//		System.out.println("startPage: "+startPage+" /endPage: "+endPage);
		
		model.addAttribute("pageStr", pageStr);
		model.addAttribute("list", mdao.myPageListMeeting(map));
	}
	
	@PostMapping(value = "/user/deleteMeetingRep", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteMeetingRep(int m_no, int mr_no) {
		int re = 0;
		re = mdao.deleteMrOne(mr_no);
		ResponseDataVo responseDataVo = new ResponseDataVo();
		responseDataVo.setCode(ResponseDataCode.ERROR);
		if(re>0) {
			responseDataVo.setCode(ResponseDataCode.SUCCESS);
		}
		return new Gson().toJson(responseDataVo);
	}
	
	// 사용자가 예전에 작성하던 게시글이 없을 경우 insert문으로 empty record생성. 그래야만 autosave로 update 가능(insert하기전에 update가 불가능하기 때문)
	@RequestMapping(value = "/createMeetingTempRecord", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void createMeetingTempRecord(HttpSession session) {
		Meeting_tempVo mtvo = new Meeting_tempVo();
		MemberVo mvo = (MemberVo)session.getAttribute("m");
		mdao.insertTempId(mvo.getId());
	}
}