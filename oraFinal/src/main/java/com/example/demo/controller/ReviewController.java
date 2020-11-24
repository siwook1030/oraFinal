package com.example.demo.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.axis.attachments.MultiPartInputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.admin.PointCause;
import com.example.demo.admin.PointGet;
import com.example.demo.dao.CourseDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.dao.ReviewDao;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.PointVo;
import com.example.demo.vo.RankVo;
import com.example.demo.vo.ReviewVo;
import com.example.demo.vo.Review_fileVo;
import com.example.demo.vo.Review_repVo;
import com.example.demo.vo.Review_tempVo;
import com.google.gson.Gson;



@Controller
public class ReviewController {
	
	@Autowired
	private ReviewDao rdao;
	@Autowired
	private CourseDao cdao;
	@Autowired
	private MemberDao mdao;
	
	int c_no;
	String c_name;
	String id;
	String nickName;
	String rank_name;
	String rank_icon;
	CourseVo cvo;
	MemberVo mvo;
	RankVo rkvo;
	public String getC_name(int c_no) {				// 코스명 가져오기
		cvo = cdao.getCourseByCno(c_no, "");
		c_name = cvo.getC_name();
		return c_name;
	}
	public String getNickName(String id) {			// 닉네임 가져오기
		mvo = mdao.selectMember(id);
		nickName = mvo.getNickName();
		return nickName;
	}
	public String getRankIcon(String rank_name) {	// 랭크아이콘 가져오기
		rkvo = mdao.selectRank(rank_name);
		rank_icon = rkvo.getRank_icon();
		return rank_icon;
	}
	public String getDate_diff_str(long date_diff, Date r_regdate) {
		if(date_diff > 2592000) {					// 30일 : 30*24*60*60
			return r_regdate.toString();
		}else if (date_diff > 86400) {				// 1일 : 24*60*60
			return (date_diff / 86400) + " 일 전";	
		}else if (date_diff > 3600) {				// 1시간 : 60*60
			return (date_diff / 3600) + " 시간 전";
		}else if (date_diff > 60) {					// 1분 : 60
			return (date_diff / 60) + " 분 전";
		}else {										// 1분 미만
			return "방금 전";
		}
	}
	@RequestMapping("/listReview")
	public void listReview() {
		
	}
	@RequestMapping("/listReviewJson")
	@ResponseBody
	public String listReviewJson(int page, int RECORDS_PER_PAGE, String searchType, String searchValue, int searchMethod) {
		//System.out.println("searchType:"+searchType);
		//System.out.println("searchValue:"+searchValue);
		//System.out.println("searchMethod:"+searchMethod);
		HashMap mybatis_map = new HashMap();
		// listReview.jsp에서 검색하는 것은 post방식. mypage에서 내가 쓴 게시글 조회는 get방식
		// id로 검색 ==> searchType=id&searchValue=hoja2242
		// 코스번호로 검색 ==> searchType=c_no&searchValue=7
		// 제목으로 검색 ==> searchType=r_title&searchValue=오라오라!&searchMethod=1 (1:일치, 2:포함)
		// 내용으로 검색 ==> searchType=r_content&searchValue=라이딩합시다&searchMethod=2 (1:일치, 2:포함)
		mybatis_map.put("searchType", searchType);

		if(searchType.equals("c_no")) {
			mybatis_map.put("searchValue", Integer.parseInt(searchValue));
		}else {
			mybatis_map.put("searchValue", searchValue);
		}
		mybatis_map.put("searchMethod", searchMethod);
		
		int total_records = rdao.count(mybatis_map);		// 총 레코드 수
		// 총 페이지 수 계산
		int total_pages = total_records / RECORDS_PER_PAGE;	
		if(total_records % RECORDS_PER_PAGE > 0) {
			total_pages++;
		}
		// 시작 레코드, 종료 레코드 계산 
		int end_record = page * RECORDS_PER_PAGE;
		int begin_record = end_record - (RECORDS_PER_PAGE - 1);
		if(end_record > total_records) {
			end_record = total_records;
		}
		// map에 시작 레코드, 종료 레코드 담아서 해당하는 범위의 레코드만 쿼리
		mybatis_map.put("begin_record", begin_record);
		mybatis_map.put("end_record", end_record);
		
		List<ReviewVo> list = rdao.selectList(mybatis_map);
		for(ReviewVo rvo : list) {
			rvo.setTotal_reply(rdao.countRep(rvo.getR_no()));	// 게시글의 댓글 수
			rvo.setDate_diff_str(getDate_diff_str(rvo.getDate_diff(),rvo.getR_regdate()));	// 게시글 등록시간차이
			rvo.setC_name(getC_name(rvo.getC_no()));			// 게시판 코스명 설정
			rvo.setNickName(getNickName(rvo.getId()));			// 게시판 닉네임 설정
			rvo.setRank_icon(getRankIcon(mvo.getRank_name()));	// 게시판 랭크아이콘 설정
		}
		
		HashMap map = new HashMap();
		map.put("list", list);
		map.put("total_pages", total_pages);	// JS에서 page계산 용도
		
		Gson gson = new Gson();
		return gson.toJson(map);
	}
	// listReview.jsp에서 코스명으로 검색하기위해 동적으로 select-option노드 생성을 위한 데이터 제공
	@RequestMapping(value = "/getCourseList", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String getCourseList() {
		Gson gson = new Gson();
		return gson.toJson(cdao.listCourse());
	}
	
	//내가쓴 게시물목록 by 김길모
	@RequestMapping("/myPageListReview")
	public void myPageListReview(Model model,HttpSession httpSession) {
		List<ReviewVo> list = rdao.myPageSelectList(httpSession);
		for(ReviewVo rvo : list) {
			rvo.setC_name(getC_name(rvo.getC_no()));			// 게시판 코스명 설정
			rvo.setNickName(getNickName(rvo.getId()));			// 게시판 닉네임 설정
			rvo.setRank_icon(getRankIcon(mvo.getRank_name()));	// 게시판 랭크아이콘 설정
		}
		model.addAttribute("list", list);
	}
	@RequestMapping("/detailReview")
	public void detailReview(int r_no, Model model, HttpServletRequest request) {
		rdao.incHit(r_no);		// 히트수 증가
		ReviewVo rvo = rdao.selectOne(r_no);
		//rvo.setR_content(rvo.getR_content().replaceAll("\n", "<br>"));	// div태그에 줄바꿈처리를 위함 <== ckeditor적용해서 필요없음
		rvo.setDate_diff_str(getDate_diff_str(rvo.getDate_diff(),rvo.getR_regdate()));	// 게시글 등록시간차이
		rvo.setC_name(getC_name(rvo.getC_no()));			// 게시글 코스명 설정
		rvo.setNickName(getNickName(rvo.getId()));			// 게시글 닉네임 설정
		rvo.setRank_icon(getRankIcon(mvo.getRank_name()));	// 게시글 랭크아이콘 설정
		
		List<Review_repVo> rrlist = rdao.selectListRep(r_no);		// 댓글 가져오기
		for(Review_repVo rrvo : rrlist) {
			rrvo.setNickName(getNickName(rrvo.getId()));			// 댓글 닉네임 설정
			rrvo.setRank_icon(getRankIcon(mvo.getRank_name()));		// 댓글 랭크아이콘 설정
		}
		
		model.addAttribute("rvo", rvo);
		model.addAttribute("rrlist", rrlist);
	}
	// detailReview.jsp 댓글 ajax처리 용도
	@RequestMapping(value = "/detailReviewReply", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String detailReviewReply(int r_no) {
		int total_reply = rdao.countRep(r_no);		// 게시글의 댓글 수
		List<Review_repVo> rrlist = rdao.selectListRep(r_no);		// 댓글 가져오기	
		for(Review_repVo rrvo : rrlist) {
			//System.out.println("댓글내용 : " + rrvo.getRr_content());
			rrvo.setRr_content(rrvo.getRr_content().replaceAll("\n", "<br>"));	// div태그에 줄바꿈처리를 위함
			rrvo.setDate_diff_str(getDate_diff_str(rrvo.getDate_diff(),rrvo.getRr_regdate()));	// 댓글 등록시간차이
			rrvo.setNickName(getNickName(rrvo.getId()));			// 댓글 닉네임 설정
			rrvo.setRank_icon(getRankIcon(mvo.getRank_name()));		// 댓글 랭크아이콘 설정
		}
		HashMap map = new HashMap();
		map.put("total_reply", total_reply);
		map.put("rrlist", rrlist);
		Gson gson = new Gson();
		return gson.toJson(map);
	}
	// detailReview.jsp 댓글 입력을 위한 용도
	@RequestMapping("/insertReviewReply")
	@ResponseBody
	public int insertReviewReply(int r_no, int rr_ref, String rr_content, HttpSession session) {
		int re = 0;
		Review_repVo rrvo = new Review_repVo();
		mvo = (MemberVo)session.getAttribute("m");
		String id = mvo.getId();
		int rr_no = rdao.nextRr_no();
		int rr_step;
		if(rr_ref == 0) {	// rr_ref가 0 이면 본문 댓글
			rr_ref = rr_no;
			rr_step = 0;
		}else {				//  rr_ref가 0아니면 대댓글
			rr_step = rdao.nextRr_step(rr_ref);
		}
		rrvo.setRr_no(rr_no);
		rrvo.setR_no(r_no);
		rrvo.setId(id);
		rrvo.setRr_content(rr_content);
		rrvo.setRr_ref(rr_ref);
		rrvo.setRr_step(rr_step);
		re = rdao.insertRep(rrvo);
		return re;
	}
	
	@RequestMapping(value = "/user/insertReview", method = RequestMethod.GET)
	public void insertReviewForm(Model model, HttpSession session) {
		List<CourseVo> list = cdao.listCourse();	// 코스선택을 위한 코스정보 가져오기
		MemberVo mvo = (MemberVo)session.getAttribute("m");
		Review_tempVo rtvo = rdao.selectTemp(mvo.getId());	// id로 temp테이블 조회해서 이전에 작성하던 글이 있는지 조회
		
		if(rtvo != null) {
			String r_title = rtvo.getR_title();
			if(r_title != null) {
				r_title = r_title.replace("\"", "\\\"").replace("\'", "\\\'");		// JS에서 원활한 string처리를 위해 변경처리
			}
			String r_content = rtvo.getR_content();
			if(r_content != null) {
				r_content = r_content.replace("\"", "\\\"").replace("\'", "\\\'");	// JS에서 원활한 string처리를 위해 변경처리
			}
			rtvo.setR_title(r_title);
			rtvo.setR_content(r_content);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("rtvo", rtvo);
	}
	
	@RequestMapping(value = "/user/insertReview", method = RequestMethod.POST)
	public ModelAndView insertReviewSubmit(HttpServletRequest request, ReviewVo rvo, String[] image_urls) {
		/*for(String url : image_urls) {
			System.out.println(url);
		}*/
		ModelAndView mav = new ModelAndView();
		//System.out.println("글내용:"+vo.getR_content());
		// review테이블 insert코드
		int re = 0;						// ReviewVo insert결과
		int r_no = rdao.nextR_no();		// 후기게시판 다음 글번호 가져오기
		rvo.setR_no(r_no);
		mvo = (MemberVo)request.getSession().getAttribute("m");
		String id = mvo.getId();
		rvo.setId(id);
		re = rdao.insert(rvo);
		if(re > 0) {	// rvo insert성공 시
			if(image_urls.length > 0) {	// 게시글에 사진이 있을 경우
				String path = request.getServletContext().getRealPath("/");
				
				// autosave하면 사진파일은 저장되지만 review_file테이블에는 저장되지 않는다.
				// 저장하지 않아도 image_urls를 통해서 저장된 img파일명을 알 수 있다.
				for(int i = 0; i < image_urls.length; i++) {
					Review_fileVo rfvo = new Review_fileVo();
					rfvo.setRf_no(rdao.nextRf_no());
					rfvo.setR_no(r_no);
					String rf_savename = image_urls[i].substring(image_urls[i].lastIndexOf("/") + 1);
					String decodeResult = "";
					try {
						// DB에 파일명을 저장할때 실제파일명이 저장되도록 decode처리한다.
						decodeResult = URLDecoder.decode(rf_savename, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					rfvo.setRf_savename(decodeResult);
					String rf_name = decodeResult.substring(6);
					rfvo.setRf_name(rf_name);
					String rf_path = "review";
					rfvo.setRf_path(rf_path);
					File file = new File(path+"/"+rf_path+"/"+rf_savename);
					long rf_size = file.length();
					rfvo.setRf_size(rf_size);
					rdao.insertFile(rfvo);
				}
			}
			rdao.deleteTemp(id);	// review테이블에 insert성공 후 임시테이블의 record삭제
			mav.setViewName("redirect:/listReview");
			
		}else {
			mav.addObject("msg", "글등록에 실패하였습니다.");
			mav.setViewName("errorPage");
		}
		return mav;
	}
	// ckeditor image insert 설정
	@RequestMapping(value = "/reviewImageInsert", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String reviewImageInsert(MultipartFile upload, HttpServletRequest request) {
		// ckeditor에서 image insert를 매개변수로 받을 때 반드시 upload로 설정해야 한다.
		String uploadFolder = request.getHeader("uploadFolder");
		String rf_name = upload.getOriginalFilename();
		String path = request.getServletContext().getRealPath("/");
		System.out.println("path:"+path);
		String rand = String.valueOf(System.currentTimeMillis());
		String randCode = rand.substring(rand.length() - 6);
		String rf_savename = randCode + rf_name;
		try {
			byte[] data = upload.getBytes();
			FileOutputStream fos = new FileOutputStream(path+"/"+uploadFolder+"/"+rf_savename);
			fos.write(data);
			fos.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		Gson gson = new Gson();
		String encodeResult = "";
		try {
			// 사진 파일명에 특수문자 있을 경우 엑박뜨기때문에 URL퍼센트인코딩해준다. 공백문자를 '+'로 바꾸기 때문에 ' '문자로 다시 바꿔준다.
			encodeResult = URLEncoder.encode(rf_savename, "UTF-8").replace("+", "%20");
		}catch (Exception e) {
			// TODO: handle exception
		}
		HashMap<String, String> map = new HashMap<String, String>();
		// ckeditor에 image insert 성공에 대한 응답으로 url : [image경로]를 반환해야 한다. 그래야만 editor에 이미지가 표시된다.
		map.put("url", "/"+uploadFolder+"/"+encodeResult);
		return gson.toJson(map);
	}
	// ckeditor image를 사용자가 선택해서 delete할 경우
	@RequestMapping(value = "/reviewImageDelete", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void reviewImageDelete(String[] urls, HttpServletRequest request) {
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
	// 사용자가 예전에 작성하던 게시글이 없을 경우 insert문으로 empty record생성. 그래야만 autosave로 update 가능(insert하기전에 update가 불가능하기 때문)
	@RequestMapping(value = "/createReviewTempRecord", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void createReviewTempRecord(HttpSession session) {
		Review_tempVo rtvo = new Review_tempVo();
		MemberVo mvo = (MemberVo)session.getAttribute("m");
		rtvo.setId(mvo.getId());
		rtvo.setR_title("");
		rtvo.setC_no(0);
		rtvo.setR_content("");
		rdao.insertTemp(rtvo);
	}
	// ckeditor 글내용 변화에 따른 autosave처리.
	@RequestMapping(value = "/reviewAutoSave", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void reviewAutoSave(String r_title, int c_no, String r_content, HttpSession session) {
		Review_tempVo rtvo = new Review_tempVo();
		MemberVo mvo = (MemberVo)session.getAttribute("m");
		rtvo.setId(mvo.getId());
		rtvo.setR_title(r_title);
		rtvo.setC_no(c_no);
		rtvo.setR_content(r_content);
		rdao.updateTemp(rtvo);
		//System.out.println("자동저장 글내용 : "+r_content);
	}
	// 게시글 삭제
	@RequestMapping("/deleteReview")
	public ModelAndView deleteReview(int r_no, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int re = 0;
		rdao.deleteRep(r_no);	// 게시글의 댓글삭제
		List<Review_fileVo> rflist = rdao.selectListFile(r_no);
		re = rdao.deleteFile(r_no);	// 게시글의 사진삭제
		if(re > 0) {
			for(Review_fileVo rfvo : rflist) {
				String path = request.getServletContext().getRealPath("/" + rfvo.getRf_path());
				File file = new File(path + "/" + rfvo.getRf_savename());
				file.delete();	// 게시글의 사진파일삭제
			}
		}
		rdao.delete(r_no);		// 게시글 삭제
		
		mav.setViewName("redirect:/listReview");
		return mav;
	}
	
	@RequestMapping(value = "/user/updateReview", method = RequestMethod.GET)
	public void updateReviewForm(int r_no, Model model, HttpServletRequest request) {
		//System.out.println("/user/updateReview컨트롤러!!");
		ReviewVo rvo = rdao.selectOne(r_no);
		List<Review_fileVo> rflist = rdao.selectListFile(r_no);
		String reviewPath = request.getServletContext().getRealPath("/review");
		String review_tempPath = request.getServletContext().getRealPath("/review_temp");
		// 수정중에 에디터에서 사진을 삭제하거나 추가하면 원본사진이 삭제되거나 추가된다.
		// 수정은 자동저장 기능이 없기때문에 수정중에 저장안하고 나가버리면 문제가 생기기 때문에 사진을 임시저장폴더로 복사해서 작업한다. 
		for(Review_fileVo rfvo : rflist) {
			try {
				String rf_savename = rfvo.getRf_savename();
				FileInputStream fis = new FileInputStream(reviewPath+"/"+rf_savename);
				byte[] data = fis.readAllBytes();
				fis.close();
				File file = new File(review_tempPath+"/"+rf_savename);
				FileOutputStream fos = new FileOutputStream(file);
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		String r_title = rvo.getR_title().replace("\"", "\\\"").replace("\'", "\\\'");		// JS에서 원활한 string처리를 위해 변경처리
		// 사진임시저장폴더의 이미지를 사용하기 위해 경로변경
		String r_content = rvo.getR_content().replace("<img src=\"/review/", "<img src=\"/review_temp/");
		r_content = r_content.replace("\"", "\\\"").replace("\'", "\\\'");
				
		rvo.setR_title(r_title);
		rvo.setR_content(r_content);
		//System.out.println("updateGET에서 글내용:"+r_content);
		List<CourseVo> list = cdao.listCourse();	// 코스선택을 위한 코스정보 가져오기
		model.addAttribute("rvo", rvo);
		model.addAttribute("list", list);
	}
	
	@RequestMapping(value = "/user/updateReview", method = RequestMethod.POST)
	public ModelAndView updateReviewSubmit(HttpServletRequest request, ReviewVo rvo, String[] image_urls) {
		ModelAndView mav = new ModelAndView();
		String path = request.getServletContext().getRealPath("/");
		
		int r_no = rvo.getR_no();
		int re = 0;						// ReviewVo update결과
		// 사진경로를 임시폴더에서 원본폴더로 변경
		String r_content = rvo.getR_content().replace("<img src=\"/review_temp/", "<img src=\"/review/");
		rvo.setR_content(r_content);
		//System.out.println("updatePOST에서 글내용:"+r_content);
		re = rdao.update(rvo);
		if(re > 0) {	// rvo update성공 시
			List<Review_fileVo> rflist = rdao.selectListFile(r_no);
			
			if(image_urls.length > 0) {	// 게시글에 사진이 있을 경우
				for(int i = 0; i < image_urls.length; i++) {
					String rf_savename = image_urls[i].substring(image_urls[i].lastIndexOf("/") + 1);
					String decodeResult = "";
					try {
						// DB에 decode된 파일명으로 저장되어있으므로 비교를 위해 똑같이 decode한다.
						decodeResult = URLDecoder.decode(rf_savename, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					File temp_file = new File(path+"/review_temp/"+decodeResult);
					
					boolean isNew = true;	// 신규 사진인지여부 저장 변수
					for(Review_fileVo rfvo : rflist) {
						if(decodeResult.equals(rfvo.getRf_savename())) {
							isNew = false;	// DB에 같은 사진이 있으면 false
							temp_file.delete();	// DB에 같은 사진이 있으므로 temp폴더의 사진 삭제
						}
					}
					if(isNew) {				// DB에 같은 사진이 없으면 insert처리
						Review_fileVo rfvo = new Review_fileVo();
						rfvo.setRf_no(rdao.nextRf_no());
						rfvo.setR_no(r_no);
						
						rfvo.setRf_savename(decodeResult);
						String rf_name = decodeResult.substring(6);
						rfvo.setRf_name(rf_name);
						String rf_path = "review";
						rfvo.setRf_path(rf_path);
						long rf_size = temp_file.length();
						rfvo.setRf_size(rf_size);
						rdao.insertFile(rfvo);
						// 임시폴더에서 원본폴더로 사진복사
						try {
							FileInputStream fis = new FileInputStream(temp_file);
							byte[] data = fis.readAllBytes();
							fis.close();
							temp_file.delete();		// 복사끝나면 임시파일 삭제
							File file = new File(path+"/review/"+decodeResult);
							FileOutputStream fos = new FileOutputStream(file);
							fos.write(data);
							fos.close();
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}	
				}
			}
			// 만약 수정하면서 게시글의 사진을 삭제했다면 DB에서도 제거해야 함. 따라서 게시글에 사진이 있든없든 검사해야함.
			for(Review_fileVo rfvo : rflist) {
				boolean isExist = false;	// DB의 사진이 수정된 게시글 사진목록에 존재여부
				for(int i = 0; i < image_urls.length; i++) {
					String rf_savename = image_urls[i].substring(image_urls[i].lastIndexOf("/") + 1);
					String decodeResult = "";
					try {
						// DB에 decode된 파일명으로 저장되어있으므로 비교를 위해 똑같이 decode한다.
						decodeResult = URLDecoder.decode(rf_savename, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					if(rfvo.getRf_savename().equals(decodeResult)) {
						isExist = true;		// 게시글에 동일한 사진이 존재하면 true
						break;
					}
				}
				if(!isExist) {				// 게시글에 동일한 사진이 존재하지 않으면 삭제
					File file = new File(path+"/review/"+rfvo.getRf_savename());
					file.delete();
					rdao.deleteFileOne(rfvo.getRf_no());
				}
			}
			mav.setViewName("redirect:/detailReview?r_no="+r_no);
		}else {
			mav.addObject("msg", "글등록에 실패하였습니다.");
			mav.setViewName("errorPage");
		}
		return mav;
	}
	
	@RequestMapping(value = "/deleteRepOne", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void deleteRepOne(int rr_no) {
		rdao.deleteRepOne(rr_no);
	}
	
	@RequestMapping(value = "/updateRep", produces = "application/json;charset=utf-8")
	@ResponseBody
	public void updateRep(Review_repVo rrvo) {
		//System.out.println("rr_no:"+rrvo.getRr_no());
		//System.out.println("rr_content:"+rrvo.getRr_content());
		rdao.updateRep(rrvo);
	}
}
