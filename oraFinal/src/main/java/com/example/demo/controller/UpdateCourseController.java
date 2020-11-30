package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.example.demo.dao.CourseDao;
import com.example.demo.util.FileUtilCollection;
import com.example.demo.util.ResponseDataCode;
import com.example.demo.vo.CoursePhotoVo;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.PublicTransportVo;
import com.example.demo.vo.ResponseDataVo;
import com.google.gson.Gson;

@Controller
public class UpdateCourseController {
	
	@Autowired
	CourseDao cdao;
	
	@GetMapping(value = "/admin/updateCourse")
	public void updateCourseForm(Model model, int c_no) {
		model.addAttribute("c_no", c_no);
	}

	@GetMapping(value = "/admin/getUpdateCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getUpdateCourse(Model model,HttpServletRequest request,int c_no) {
		Gson gson = new Gson();
		System.out.println("작동한다");
		String path = request.getRealPath("/courseLine")+"/";
		HashMap map = new HashMap();
		map.put("cJson", cdao.getCourseByCno(c_no, path));
		map.put("ptJson",cdao.getPublicTransportByCno(c_no));
		return gson.toJson(map);

	}
	

	@PostMapping(value = "/admin/updateCourse", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String updateCourse(HttpSession session,HttpServletRequest request,
			@RequestParam Map<String, Object> map,@RequestParam(value="c_views",required = false) String[] c_views,
			@RequestParam(value="c_tags",required = false) List<String> c_tags,
			List<MultipartFile> uploadfile){

		 int c_no = Integer.parseInt((String)map.get("c_no"));
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
		 
		 String cLinepath = request.getRealPath(MakingCourseController.courseLinePath);
		 String c_line=c_no+"_"+c_name + MakingCourseController.courseLineName;
		 String c_lineDat = (String)map.get("c_line");
		 	 	 
		 List<CoursePhotoVo> c_photo = new ArrayList<CoursePhotoVo>();
		 String cPhotoPath = request.getRealPath(MakingCourseController.coursePhotoPath);
		 String cPhotoPathSub = "/course"+c_no;
		 
		 int cpCnt = 1;
		 for(MultipartFile mf : uploadfile) {
			 String cp_name =  "cp"+c_no+"_"+cpCnt+"_"+FileUtilCollection.filePrefixName()+".png";
			 c_photo.add(new CoursePhotoVo(0, c_no,cp_name, MakingCourseController.coursePhotoPath+cPhotoPathSub, 0, 0));
			 cpCnt++;
		 }
		
		 CourseVo c = new CourseVo(c_no, code_value, id, nickName, c_name, c_s_locname, c_s_latitude, c_s_longitude, c_e_locname, c_e_latitude, c_e_longitude, c_loc, c_distance, c_time, c_difficulty, c_tag, c_tags, null,c_view, c_views, c_words, c_line, c_temp, userDis, c_photo);
	
		 
		 int pt_noPS = Integer.parseInt((String)map.get("pt_noPS"));
		 String code_valuePS = "00201";
		 int c_noPS = c_no;
		 double pt_latitudePS = Double.parseDouble((String)map.get("pt_latitudePS"));
		 double pt_longitudePS= Double.parseDouble((String)map.get("pt_longitudePS"));
		 String pt_imgPS = (String)map.get("pt_imgPS");
		 String pt_stationPS =(String)map.get("pt_stationPS");
		 double pt_distancePS = Double.parseDouble((String)map.get("pt_distancePS"));
		 String pt_linePS = (String)map.get("pt_linePS");
		
		 PublicTransportVo sPT = new PublicTransportVo(pt_noPS, code_valuePS, c_noPS, pt_latitudePS, pt_longitudePS, pt_imgPS, pt_stationPS, pt_distancePS, pt_linePS);
		 
		 
		 int pt_noPE = Integer.parseInt((String)map.get("pt_noPE"));
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
		 responseDataVo.setMessage("수정에 실패하였습니다.");
		 int re = -1;
		 re = cdao.updateCourse(c, sPT, ePT);
		 System.out.println(c);
		 System.out.println(sPT);
		 System.out.println(ePT);
		 
		 if( re > 0) {
			 try {
				 FileUtilCollection.saveText(c_lineDat, cLinepath+"/"+c_line);
				 FileUtilCollection.deleteFilesInFolder(cPhotoPath+cPhotoPathSub);
				 //FileUtilCollection.createFolder(cPhotoPath+cPhotoPathSub); 
				 for(int i=0; i<uploadfile.size(); i++) {
					 FileUtilCollection.saveImage(uploadfile.get(i), cPhotoPath+cPhotoPathSub+"/"+c_photo.get(i).getCp_name());
				 }		 
			 }catch (Exception e) {
				System.out.println("업데이트코스 파일예외 " + e.getMessage());
			}	 
			 responseDataVo.setCode(ResponseDataCode.SUCCESS);
			 responseDataVo.setMessage("수정에 성공하였습니다");
		 }
		 	 
		 Gson gson = new Gson();
		 return gson.toJson(responseDataVo);
		 
	}
}
