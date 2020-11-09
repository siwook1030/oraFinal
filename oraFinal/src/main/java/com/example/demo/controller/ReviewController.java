package com.example.demo.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dao.CourseDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.dao.ReviewDao;
import com.example.demo.vo.CourseVo;
import com.example.demo.vo.MemberVo;
import com.example.demo.vo.RankVo;
import com.example.demo.vo.ReviewVo;
import com.example.demo.vo.Review_fileVo;
import com.example.demo.vo.Review_repVo;
import com.google.gson.Gson;



@Controller
public class ReviewController {
	@Autowired
	private ReviewDao rdao;
	@Autowired
	private CourseDao cdao;
	@Autowired
	private MemberDao mdao;
	public void setRdao(ReviewDao rdao) {
		this.rdao = rdao;
	}
	public void setCdao(CourseDao cdao) {
		this.cdao = cdao;
	}
	public void setMdao(MemberDao mdao) {
		this.mdao = mdao;
	}
	
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
	public String listReviewJson(int page, int RECORDS_PER_PAGE) {
		// System.out.println("리뷰page입니다 : " + page);
		int total_records = rdao.count();		// 총 레코드 수
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
		HashMap<String, Integer> record_map = new HashMap<String, Integer>();
		record_map.put("begin_record", begin_record);
		record_map.put("end_record", end_record);
		List<ReviewVo> list = rdao.selectList(record_map);
		for(ReviewVo rvo : list) {
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
	@RequestMapping("/detailReview")
	public void detailReview(int r_no, Model model, HttpServletRequest request) {
		rdao.incHit(r_no);		// 히트수 증가
		ReviewVo rvo = rdao.selectOne(r_no);
		//rvo.setR_no(r_no);
		rvo.setDate_diff_str(getDate_diff_str(rvo.getDate_diff(),rvo.getR_regdate()));	// 게시글 등록시간차이
		rvo.setC_name(getC_name(rvo.getC_no()));			// 게시글 코스명 설정
		rvo.setNickName(getNickName(rvo.getId()));			// 게시글 닉네임 설정
		rvo.setRank_icon(getRankIcon(mvo.getRank_name()));	// 게시글 랭크아이콘 설정
		//rvo.setTotal_reply(rdao.countRep(r_no));			// 게시글 답글 수 설정
		
		List<Review_fileVo> rflist = rdao.selectListFile(r_no);		// 게시글 사진 가져오기
		for(Review_fileVo rfvo : rflist) {
			try {
				// 사진 파일명에 특수문자 있을 경우 엑박뜨기때문에 URL퍼센트인코딩해준다. 공백문자를 '+'로 바꾸기 때문에 ' '문자로 다시 바꿔준다.
				String encodeResult = URLEncoder.encode(rfvo.getRf_savename(), "UTF-8").replace("+", "%20");
				rfvo.setRf_savename(encodeResult);					
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		List<Review_repVo> rrlist = rdao.selectListRep(r_no);		// 댓글 가져오기
		for(Review_repVo rrvo : rrlist) {
			rrvo.setNickName(getNickName(rrvo.getId()));			// 댓글 닉네임 설정
			rrvo.setRank_icon(getRankIcon(mvo.getRank_name()));		// 댓글 랭크아이콘 설정
		}
		
		// 답글처리 -> js로 처리예정
		if(request.getParameter("rep_no") != null) {		
			int rep_no = Integer.parseInt(request.getParameter("rep_no"));
			request.setAttribute("rep_no", rep_no);
		}
		
		model.addAttribute("rvo", rvo);
		model.addAttribute("rflist", rflist);
		model.addAttribute("rrlist", rrlist);
	}
	@RequestMapping(value = "/detailReviewReply", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String detailReviewReply(int r_no) {
		int total_reply = rdao.countRep(r_no);
		List<Review_repVo> rrlist = rdao.selectListRep(r_no);		// 댓글 가져오기
		for(Review_repVo rrvo : rrlist) {
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
	@RequestMapping("/insertReviewReply")
	@ResponseBody
	public int insertReviewReply(int r_no, int rr_ref, String rr_content, HttpSession session) {
		int re = 0;
		Review_repVo rrvo = new Review_repVo();
		mvo = (MemberVo)session.getAttribute("m");
		String id = mvo.getId();
		int rr_no = rdao.nextRr_no();
		int rr_step;
		if(rr_ref == 0) {
			rr_ref = rr_no;
			rr_step = 0;
		}else {
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
	
	
	/*@RequestMapping(value = "/getRvo", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String detailReviewRvo(int r_no) {
		rdao.incHit(r_no);		// 히트수 증가
		ReviewVo rvo = rdao.selectOne(r_no);
		rvo.setR_no(r_no);
		rvo.setC_name(getC_name(rvo.getC_no()));			// 게시글 코스명 설정
		rvo.setNickName(getNickName(rvo.getId()));			// 게시글 닉네임 설정
		rvo.setRank_icon(getRankIcon(mvo.getRank_name()));	// 게시글 랭크아이콘 설정
		rvo.setTotal_reply(rdao.countRep(r_no));			// 게시글 답글 수 설정
		Gson gson = new Gson();
		return gson.toJson(rvo);
	}*/
	@RequestMapping(value = "/insertReview", method = RequestMethod.GET)
	public void insertReviewForm(Model model) {
		List<CourseVo> list = cdao.listCourse();
		model.addAttribute("list", list);
	}
	@RequestMapping(value = "/insertReview", method = RequestMethod.POST)
	public ModelAndView insertReviewSubmit(HttpServletRequest request, ReviewVo vo, MultipartFile mf) {
		ModelAndView mav = new ModelAndView();
		
		// review테이블 insert코드
		ReviewVo rvo = new ReviewVo();
		int re = 0;						// ReviewVo insert결과
		int r_no = rdao.nextR_no();		// 후기게시판 다음 글번호 가져오기
		rvo.setR_no(r_no);
		rvo.setC_no(vo.getC_no());
		mvo = (MemberVo)request.getSession().getAttribute("m");
		rvo.setId(mvo.getId());
		rvo.setR_title(vo.getR_title());
		rvo.setR_content(vo.getR_content());
		re = rdao.insert(rvo);
		
		if(re > 0) {
			if(!mf.getOriginalFilename().equals("")) {
				// review_file테이블 insert코드
				int re_rfvo = 0;		// Review_fileVo insert결과
				Review_fileVo rfvo = new Review_fileVo();
				rfvo.setRf_no(rdao.nextRf_no());
				rfvo.setR_no(r_no);
				String rf_name = mf.getOriginalFilename();
				rfvo.setRf_name(rf_name);
				String rand = String.valueOf(System.currentTimeMillis());
				String randCode = rand.substring(rand.length() - 6);
				String rf_savename = randCode + rf_name;
				rfvo.setRf_savename(rf_savename);
				rfvo.setRf_path("review");
				rfvo.setRf_size(mf.getSize());
				re_rfvo = rdao.insertFile(rfvo);
				if(re_rfvo > 0) {
					// review_file 저장코드
					String path = request.getServletContext().getRealPath("/");
					System.out.println("path:"+path);
					String rf_path = "review";
					try {
						byte[] data = mf.getBytes();
						FileOutputStream fos = new FileOutputStream(path+"/"+rf_path+"/"+rf_savename);
						fos.write(data);
						fos.close();
					}catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			mav.setViewName("redirect:/listReview");
		}else {
			mav.addObject("msg", "글등록에 실패하였습니다.");
			mav.setViewName("errorPage");
		}
		return mav;
	}
	@RequestMapping("/deleteReview")
	public ModelAndView deleteReview(int r_no, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		int re = 0;
		rdao.deleteRep(r_no);
		List<Review_fileVo> rflist = rdao.selectListFile(r_no);
		re = rdao.deleteFile(r_no);
		if(re > 0) {
			for(Review_fileVo rfvo : rflist) {
				String path = request.getServletContext().getRealPath("/" + rfvo.getRf_path());
				File file = new File(path + "/" + rfvo.getRf_savename());
				file.delete();
			}
		}
		rdao.delete(r_no);
		
		mav.setViewName("redirect:/listReview");
		return mav;
	}
}
