package com.example.demo.controller;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.ResponseDataCode;
import com.example.demo.dao.CourseDao;
import com.example.demo.vo.CoursePhotoVo;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.PublicTransportVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

import lombok.Setter;

@Controller
public class MakingCourseController {
	
	@Autowired
	@Setter
	CourseDao cdao;
	
	@GetMapping("/user/makingCourse")
	public void makingCourse() {
		
	}
	
	@PostMapping(value = "/user/cnameDupCheck", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String cnameDupCheck(String c_name) {
		int re = 1;
		re = cdao.cnameDupCheck(c_name);
		return Integer.toString(re);
	}
	
	@PostMapping("/user/previewMakingCourse")
	@ResponseBody
	public String makingCoursePreview(HttpSession session,Model model,@RequestParam Map<String, Object> map){
		 //,@RequestParam(value="c_views[]",required = false) String[] c_views
		MemberVo m = (MemberVo)session.getAttribute("m");
			
		 int c_no = 0;
		 String code_value = m.getCode_value();
		 String id = m.getId();
		 String c_name = (String)map.get("c_name")+".feat "+m.getNickName(); 
		 String c_s_locname =(String)map.get("c_s_locname");
		 double c_s_latitude = Double.parseDouble((String)map.get("c_s_latitude"));
		 double c_s_longitude = Double.parseDouble((String)map.get("c_s_longitude"));
		 String c_e_locname = (String)map.get("c_e_locname");
		 double c_e_latitude = Double.parseDouble((String)map.get("c_e_latitude"));
		 double c_e_longitude = Double.parseDouble((String)map.get("c_e_longitude"));
		 String[] sLoc = c_s_locname.split(" ");
		 String[] eLoc = c_e_locname.split(" ");
		 String c_loc = "#"+sLoc[0];
		 if(!sLoc[0].equals(eLoc[0])) {
			 c_loc += "#"+eLoc[0];
		 }
		 double c_distance = Double.parseDouble((String)map.get("c_distance"));
		 int c_time = Integer.parseInt((String)map.get("c_time"));
		 int c_difficulty = Integer.parseInt((String)map.get("c_difficulty"));
		 String c_view = null;
		 //String[] c_views = (String[])map.get("c_views"); // 디비에서 꺼내온 뷰를 "-" 나눠서 다시 배열로 넣기위해
		 ArrayList<String> c_v = (ArrayList<String>)map.get("c_views");
		 System.out.println("풍경이다!!" + c_v);
		 String[] c_views = null;
		 String c_words = (String)map.get("c_words");
		 String c_line=(String)map.get("c_line");
		 if(c_line == null || c_line.equals("")) {
			 c_line = "0";
		 }
		 String c_temp = "Y";
		 double userDis = 0; //코스와 유저의현재위치와의  거리
		 List<CoursePhotoVo> c_photo = null;
		
		 CourseVo c = new CourseVo(c_no, code_value, id, c_name, c_s_locname, c_s_latitude, c_s_longitude, c_e_locname, c_e_latitude, c_e_longitude, c_loc, c_distance, c_time, c_difficulty, c_view, c_views, c_words, c_line, c_temp, userDis, c_photo);
		
		 int pt_noPS = 0;
		 String code_valuePS = "00201";
		 int c_noPS = 0;
		 double pt_latitudePS = Double.parseDouble((String)map.get("pts_latitude"));
		 double pt_longitudePS= Double.parseDouble((String)map.get("pts_longitude"));
		 String pt_imgPS = (String)map.get("pts_img");
		 String pt_stationPS = pt_imgPS +" "+(String)map.get("pts_station");
		 pt_imgPS += ".png";
		 double pt_distancePS = Double.parseDouble((String)map.get("pts_distance"));;
		 String pt_linePS = (String)map.get("pts_line");;
		
		 PublicTransportVo sPT = new PublicTransportVo(pt_noPS, code_valuePS, c_noPS, pt_latitudePS, pt_longitudePS, pt_imgPS, pt_stationPS, pt_distancePS, pt_linePS);
		 
		 int pt_noPE = 0;
		 String code_valuePE = "00202";
		 int c_noPE = 0;
		 double pt_latitudePE = Double.parseDouble((String)map.get("pte_latitude"));
		 double pt_longitudePE= Double.parseDouble((String)map.get("pte_longitude"));
		 String pt_imgPE = (String)map.get("pte_img");
		 String pt_stationPE = pt_imgPE +" "+(String)map.get("pte_station");
		 pt_imgPE += ".png";
		 double pt_distancePE = Double.parseDouble((String)map.get("pte_distance"));;
		 String pt_linePE = (String)map.get("pte_line");;
		 
		 PublicTransportVo ePT = new PublicTransportVo(pt_noPE, code_valuePE, c_noPE, pt_latitudePE, pt_longitudePE, pt_imgPE, pt_stationPE, pt_distancePE, pt_linePE);
		 
		 List<PublicTransportVo> ptList = new ArrayList<PublicTransportVo>();
		 ptList.add(sPT);
		 ptList.add(ePT);
		 
		 model.addAttribute("c", c);
		 model.addAttribute("ptList", ptList);
		 session.setAttribute("c", c);
		 session.setAttribute("ptList", ptList);
		 
		 return "1";
		 
	}
	
	@RequestMapping(value = "/user/preview", produces = "application/json; charset=utf-8")
	public String preview(Model model, HttpSession session) {
		CourseVo c = (CourseVo)session.getAttribute("c");
		List<PublicTransportVo> ptList = (ArrayList<PublicTransportVo>)session.getAttribute("ptList");
		Gson gson = new Gson();
		 model.addAttribute("c", c);
		 model.addAttribute("ptList", ptList);
		 model.addAttribute("ptJson", gson.toJson(ptList));
		 session.removeAttribute("c");
		 session.removeAttribute("ptList");

		return "/user/previewMakingCourse";
	}
	
	@PostMapping(value = "/user/regCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String regCourse(HttpSession session,HttpServletRequest request,Model model,@RequestParam Map<String, Object> map,@RequestParam(value="c_views[]",required = false) String[] c_views){
		 
		MemberVo m = (MemberVo)session.getAttribute("m");
			
		 int c_no = cdao.nextCno();
		 String code_value = m.getCode_value();
		 String id = m.getId();
		 String c_name = (String)map.get("c_name")+".feat "+m.getNickName(); 
		 String c_s_locname =(String)map.get("c_s_locname");
		 double c_s_latitude = Double.parseDouble((String)map.get("c_s_latitude"));
		 double c_s_longitude = Double.parseDouble((String)map.get("c_s_longitude"));
		 String c_e_locname = (String)map.get("c_e_locname");
		 double c_e_latitude = Double.parseDouble((String)map.get("c_e_latitude"));
		 double c_e_longitude = Double.parseDouble((String)map.get("c_e_longitude"));
		 String[] sLoc = c_s_locname.split(" ");
		 String[] eLoc = c_e_locname.split(" ");
		 String c_loc = "#"+sLoc[0];
		 if(!sLoc[0].equals(eLoc[0])) {
			 c_loc += "#"+eLoc[0];
		 }
		 double c_distance = Double.parseDouble((String)map.get("c_distance"));
		 int c_time = Integer.parseInt((String)map.get("c_time"));
		 int c_difficulty = Integer.parseInt((String)map.get("c_difficulty"));
		 String c_view = "";
		 for(int i=0; i<c_views.length; i++) {
			 c_view += c_views[i];
			 if(i < c_views.length-1) {
				 c_view += "-";
			 }
		 }
		 String c_words = (String)map.get("c_words");
		 
		 String path = request.getRealPath("/courseLine")+"/";
		 String c_line=c_no+"_"+ System.currentTimeMillis() +"_c_line.dat";
		 String c_lineDat = (String)map.get("c_line");

		 try {
			 BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(path+c_line, false));
			 bufferedWriter.write(c_lineDat);
			 bufferedWriter.flush();
			 bufferedWriter.close();
		 }catch (Exception e) {
			System.out.println("메이킹코스 파일예외 " + e.getMessage());
		}
		 
		  
		 
		 String c_temp = "Y";
		 double userDis = 0; //코스와 유저의현재위치와의  거리
		 List<CoursePhotoVo> c_photo = null;
		
		 CourseVo c = new CourseVo(c_no, code_value, id, c_name, c_s_locname, c_s_latitude, c_s_longitude, c_e_locname, c_e_latitude, c_e_longitude, c_loc, c_distance, c_time, c_difficulty, c_view, c_views, c_words, c_line, c_temp, userDis, c_photo);
		
		 int pt_noPS = 0;
		 String code_valuePS = "00201";
		 int c_noPS = c_no;
		 double pt_latitudePS = Double.parseDouble((String)map.get("pts_latitude"));
		 double pt_longitudePS= Double.parseDouble((String)map.get("pts_longitude"));
		 String pt_imgPS = (String)map.get("pts_img");
		 String pt_stationPS = pt_imgPS +" "+(String)map.get("pts_station");
		 pt_imgPS += ".png";
		 double pt_distancePS = Double.parseDouble((String)map.get("pts_distance"));;
		 String pt_linePS = (String)map.get("pts_line");;
		
		 PublicTransportVo sPT = new PublicTransportVo(pt_noPS, code_valuePS, c_noPS, pt_latitudePS, pt_longitudePS, pt_imgPS, pt_stationPS, pt_distancePS, pt_linePS);
		 
		 int pt_noPE = 0;
		 String code_valuePE = "00202";
		 int c_noPE = c_no;
		 double pt_latitudePE = Double.parseDouble((String)map.get("pte_latitude"));
		 double pt_longitudePE= Double.parseDouble((String)map.get("pte_longitude"));
		 String pt_imgPE = (String)map.get("pte_img");
		 String pt_stationPE = pt_imgPE +" "+(String)map.get("pte_station");
		 pt_imgPE += ".png";
		 double pt_distancePE = Double.parseDouble((String)map.get("pte_distance"));;
		 String pt_linePE = (String)map.get("pte_line");;
		 
		 PublicTransportVo ePT = new PublicTransportVo(pt_noPE, code_valuePE, c_noPE, pt_latitudePE, pt_longitudePE, pt_imgPE, pt_stationPE, pt_distancePE, pt_linePE);
		 
		 ResponseDataVo responseDataVo = new ResponseDataVo();
		 responseDataVo.setCode(ResponseDataCode.ERROR);
		 responseDataVo.setMessage("등록에 실패하였습니다.");
		 int re = -1;
		 re = cdao.insertCourse(c, sPT, ePT);
		 
		 if( re > 0) {
			 responseDataVo.setCode(ResponseDataCode.SUCCESS);
			 responseDataVo.setMessage("등록에 성공하였습니다.\r\n(최종 등록은 관리자 승인 후 진행되며 등록문자가 발송됩니다. 마이페이지 'My Making-Course'에서 확인 할 수 있습니다.\r\n코스를 등록해주셔서 감사합니다.-오늘의 라이더-)");
		 }
		 
		 
		 Gson gson = new Gson();
		 return gson.toJson(responseDataVo);
		 
	}
}
