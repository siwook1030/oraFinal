package com.example.demo.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.CourseDao;
import com.example.demo.util.FileUtilCollection;
import com.example.demo.util.ResponseDataCode;
import com.example.demo.vo.CoursePhotoVo;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.PublicTransportVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class MakingCourseController {
	
	public static String courseLinePath = "/courseLine";    // 코스라인 경로
	public static String courseLineName = "_CycleCourse.gpx";    // 코스라인파일 이름 (앞에는 기본키 코스번호 붙임)
	public static String coursePhotoPath = "/coursePhoto";  // 코스포토 경로
	public static String coursePhotoPathSub = "/course";    // 각 코스번호마다 공통 폴더명 (뒤에는 기본키 코스번호 붙임)
	
	@Autowired
	CourseDao cdao;
	
	@GetMapping("/user/makingCourse")
	public void makingCourse() {
		
	}
	
	@GetMapping(value = "/user/subway", produces = "application/json; charset=utf-8")  // 지하철역정보 불러오는 곳
	@ResponseBody
	public String subway(HttpServletRequest request) {
		String path = request.getRealPath("/publictransport")+"/";
		System.out.println(FileUtilCollection.readText("subway.txt", path));
		return new Gson().toJson(FileUtilCollection.readText("subway.txt", path));
	}
	
	@PostMapping(value = "/user/cnameDupCheck", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String cnameDupCheck(String c_name) {
		int re = 1;
		re = cdao.cnameDupCheck(c_name);
		return Integer.toString(re);
	}
	
	@PostMapping(value = "/user/previewMakingCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String makingCoursePreview(HttpSession session,HttpServletRequest request,Model model,
			@RequestParam Map<String, Object> map,@RequestParam(value="c_views",required = false) String[] c_views,
			@RequestParam(value="c_tags",required = false) List<String> c_tags,
			List<MultipartFile> uploadfile){
		
		 int c_no = 0;
		 String code_value = (String)map.get("code_value");
		 String id = (String)map.get("id");
		 String nickName = (String)map.get("nickName");
		 String c_name = (String)map.get("c_name");
		 String c_s_locname =(String)map.get("c_s_locname");
		 double c_s_latitude = Double.parseDouble((String)map.get("c_s_latitude"));
		 double c_s_longitude = Double.parseDouble((String)map.get("c_s_longitude"));
		 String c_e_locname = (String)map.get("c_e_locname");
		 double c_e_latitude = Double.parseDouble((String)map.get("c_e_latitude"));
		 double c_e_longitude = Double.parseDouble((String)map.get("c_e_longitude"));
		 String c_loc = (String)map.get("c_loc"); 
		 double c_distance = Double.parseDouble((String)map.get("c_distance"));
		 int c_time = Integer.parseInt((String)map.get("c_time"));
		 int c_difficulty = Integer.parseInt((String)map.get("c_difficulty"));
		 String c_tag = (String)map.get("c_tag");
		 String c_view = (String)map.get("c_view");
		 String c_words = (String)map.get("c_words");
		 String c_line=(String)map.get("c_line");
		 String c_temp = "Y";
		 double userDis = 0; //코스와 유저의현재위치와의  거리
		 List<CoursePhotoVo> c_photo = null;
		
		 CourseVo c = new CourseVo(c_no, code_value, id, nickName, c_name, c_s_locname, c_s_latitude, c_s_longitude, c_e_locname, c_e_latitude, c_e_longitude, c_loc, c_distance, c_time, c_difficulty, c_tag, c_tags, null,c_view, c_views, c_words, c_line, c_temp, userDis, c_photo);
		 
		 int pt_noPS = 0;
		 String code_valuePS = "00201";
		 int c_noPS = c_no;
		 double pt_latitudePS = Double.parseDouble((String)map.get("pt_latitudePS"));
		 double pt_longitudePS= Double.parseDouble((String)map.get("pt_longitudePS"));
		 String pt_imgPS = (String)map.get("pt_imgPS");
		 String pt_stationPS =(String)map.get("pt_stationPS");
		 double pt_distancePS = Double.parseDouble((String)map.get("pt_distancePS"));
		 String pt_linePS = (String)map.get("pt_linePS");
		
		 PublicTransportVo sPT = new PublicTransportVo(pt_noPS, code_valuePS, c_noPS, pt_latitudePS, pt_longitudePS, pt_imgPS, pt_stationPS, pt_distancePS, pt_linePS);
		 
		 int pt_noPE = 0;
		 String code_valuePE = "00202";
		 int c_noPE = c_no;
		 double pt_latitudePE = Double.parseDouble((String)map.get("pt_latitudePE"));
		 double pt_longitudePE= Double.parseDouble((String)map.get("pt_longitudePE"));
		 String pt_imgPE = (String)map.get("pt_imgPE");
		 String pt_stationPE =(String)map.get("pt_stationPE");
		 double pt_distancePE = Double.parseDouble((String)map.get("pt_distancePE"));
		 String pt_linePE = (String)map.get("pt_linePE");
		 
		 PublicTransportVo ePT = new PublicTransportVo(pt_noPE, code_valuePE, c_noPE, pt_latitudePE, pt_longitudePE, pt_imgPE, pt_stationPE, pt_distancePE, pt_linePE);
		 
		 List<PublicTransportVo> ptList = new ArrayList<PublicTransportVo>();
		 ptList.add(sPT);
		 ptList.add(ePT);
		 
		 String previewPhotoPath = request.getRealPath("/previewPhoto")+"/";
		 List<String> uploadFilesName = new ArrayList<String>();
		 try {
			 for(MultipartFile mf : uploadfile) {
					String fname = FileUtilCollection.filePrefixName()+".png";
					uploadFilesName.add(fname);
					//mf.transferTo(new File(previewPhotoPath+fname));
					FileUtilCollection.saveImage(mf, previewPhotoPath+fname);
				 } 
		} catch (Exception e) {
			System.out.println("프리뷰사진저장 예외 " +e.getMessage());
		}
		
		 	 
		 session.setAttribute("c", c);
		 session.setAttribute("ptList", ptList);
		 session.setAttribute("uploadFilesName", uploadFilesName);
		 
		 return "1";
		 
	}
	
	@RequestMapping(value = "/user/preview", produces = "application/json; charset=utf-8")
	public String preview(Model model, HttpSession session) {
		CourseVo c = (CourseVo)session.getAttribute("c");
		List<PublicTransportVo> ptList = (ArrayList<PublicTransportVo>)session.getAttribute("ptList");
		List<String> uploadFilesName = (ArrayList<String>)session.getAttribute("uploadFilesName");
		Gson gson = new Gson();
		 model.addAttribute("c", c);
		 model.addAttribute("cJson", new Gson().toJson(c));
		 model.addAttribute("ptList", ptList);
		 model.addAttribute("ptJson", gson.toJson(ptList));
		 model.addAttribute("uploadFilesName", uploadFilesName);
		 session.removeAttribute("c");
		 session.removeAttribute("ptList");
		 session.removeAttribute("uploadFilesName");

		return "/user/previewMakingCourse";
	}
	
	
	@PostMapping(value = "/user/regCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String regCourse(HttpSession session,HttpServletRequest request,
			@RequestParam Map<String, Object> map,@RequestParam(value="c_views",required = false) String[] c_views,
			@RequestParam(value="c_tags",required = false) List<String> c_tags,
			List<MultipartFile> uploadfile){
			System.out.println("레그코스 작동한다");
		 int c_no = cdao.nextCno();
		 String code_value = (String)map.get("code_value");
		 String id = (String)map.get("id");
		 String nickName = (String)map.get("nickName");
		 String c_name = (String)map.get("c_name");
		 String c_s_locname =(String)map.get("c_s_locname");
		 double c_s_latitude = Double.parseDouble((String)map.get("c_s_latitude"));
		 double c_s_longitude = Double.parseDouble((String)map.get("c_s_longitude"));
		 String c_e_locname = (String)map.get("c_e_locname");
		 double c_e_latitude = Double.parseDouble((String)map.get("c_e_latitude"));
		 double c_e_longitude = Double.parseDouble((String)map.get("c_e_longitude"));
		 String c_loc = (String)map.get("c_loc"); 
		 double c_distance = Double.parseDouble((String)map.get("c_distance"));
		 int c_time = Integer.parseInt((String)map.get("c_time"));
		 int c_difficulty = Integer.parseInt((String)map.get("c_difficulty"));
		 String c_tag = (String)map.get("c_tag");
		 String c_view = (String)map.get("c_view");
		 String c_words = (String)map.get("c_words");
		 String c_temp = "Y";
		 double userDis = 0; //코스와 유저의현재위치와의  거리
		 
		 String cLinepath = request.getRealPath(courseLinePath);
		 String c_line=c_no+"_"+c_name + courseLineName;
		 String c_lineDat = (String)map.get("c_line");
		 	 	 
		 List<CoursePhotoVo> c_photo = new ArrayList<CoursePhotoVo>();
		 String cPhotoPath = request.getRealPath(coursePhotoPath);
		 String cPhotoPathSub = coursePhotoPathSub+c_no;
		 
		 int cpCnt = 1;
		 for(MultipartFile mf : uploadfile) {
			 String cp_name =  "cp"+c_no+"_"+cpCnt+"_"+FileUtilCollection.filePrefixName()+".png";
			 c_photo.add(new CoursePhotoVo(0, c_no,cp_name, coursePhotoPath+cPhotoPathSub, 0, 0));
		 }
		 
		 CourseVo c = new CourseVo(c_no, code_value, id, nickName, c_name, c_s_locname, c_s_latitude, c_s_longitude, c_e_locname, c_e_latitude, c_e_longitude, c_loc, c_distance, c_time, c_difficulty, c_tag, c_tags, null,c_view, c_views, c_words, c_line, c_temp, userDis, c_photo);
	
		 
		 int pt_noPS = 0;
		 String code_valuePS = "00201";
		 int c_noPS = c_no;
		 double pt_latitudePS = Double.parseDouble((String)map.get("pt_latitudePS"));
		 double pt_longitudePS= Double.parseDouble((String)map.get("pt_longitudePS"));
		 String pt_imgPS = (String)map.get("pt_imgPS");
		 String pt_stationPS =(String)map.get("pt_stationPS");
		 double pt_distancePS = Double.parseDouble((String)map.get("pt_distancePS"));
		 String pt_linePS = (String)map.get("pt_linePS");
		
		 PublicTransportVo sPT = new PublicTransportVo(pt_noPS, code_valuePS, c_noPS, pt_latitudePS, pt_longitudePS, pt_imgPS, pt_stationPS, pt_distancePS, pt_linePS);
		 
		 int pt_noPE = 0;
		 String code_valuePE = "00202";
		 int c_noPE = c_no;
		 double pt_latitudePE = Double.parseDouble((String)map.get("pt_latitudePE"));
		 double pt_longitudePE= Double.parseDouble((String)map.get("pt_longitudePE"));
		 String pt_imgPE = (String)map.get("pt_imgPE");
		 String pt_stationPE =(String)map.get("pt_stationPE");
		 double pt_distancePE = Double.parseDouble((String)map.get("pt_distancePE"));
		 String pt_linePE = (String)map.get("pt_linePE");
		 
		 PublicTransportVo ePT = new PublicTransportVo(pt_noPE, code_valuePE, c_noPE, pt_latitudePE, pt_longitudePE, pt_imgPE, pt_stationPE, pt_distancePE, pt_linePE);
		 
		 ResponseDataVo responseDataVo = new ResponseDataVo();
		 responseDataVo.setCode(ResponseDataCode.ERROR);
		 responseDataVo.setMessage("등록에 실패하였습니다.");
		 int re = -1;
		 re = cdao.insertCourse(c, sPT, ePT);
		 System.out.println(c);
		 System.out.println(sPT);
		 System.out.println(ePT);
		 
		 if( re > 0) {
			 try {
				 FileUtilCollection.saveText(c_lineDat, cLinepath+"/"+c_line);
				 
				 FileUtilCollection.createFolder(cPhotoPath+cPhotoPathSub); 
				 for(int i=0; i<uploadfile.size(); i++) {
					 FileUtilCollection.saveImage(uploadfile.get(i), cPhotoPath+cPhotoPathSub+"/"+c_photo.get(i).getCp_name());
				 }		 
			 }catch (Exception e) {
				System.out.println("메이킹코스 파일예외 " + e.getMessage());
			}	 
			 responseDataVo.setCode(ResponseDataCode.SUCCESS);
			 responseDataVo.setMessage("등록에 성공하였습니다.\r\n(최종 등록은 관리자 승인 후 진행되며 등록문자가 발송됩니다. 마이페이지 '내가 만든코스'에서 확인 할 수 있습니다.\r\n코스를 등록해주셔서 감사합니다.-오늘의 라이딩-)");
		 }
		 	 
		 Gson gson = new Gson();
		 return gson.toJson(responseDataVo);
		 
	}
}
