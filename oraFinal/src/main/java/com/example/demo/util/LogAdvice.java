package com.example.demo.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.admin.PointCause;
import com.example.demo.admin.PointGet;
import com.example.demo.dao.CourseDao;
import com.example.demo.dao.LogDao;
import com.example.demo.dao.MeetingDao;
import com.example.demo.dao.MemberDao;
import com.example.demo.dao.ReviewDao;
import com.example.demo.vo.LogVo;
import com.example.demo.vo.MeetingVo;
import com.example.demo.vo.Meeting_repVo;
import com.example.demo.vo.PointVo;
import com.example.demo.vo.ReviewVo;
import com.example.demo.vo.Review_repVo;

import lombok.Setter;

@Service
@Aspect
public class LogAdvice {

	@Autowired
	CourseDao cdao;
	
	@Autowired
	MeetingDao medao;
	
	@Autowired
	ReviewDao rdao;
	
	@Autowired
	MemberDao mdao;
	
	@Autowired
	LogDao ldao;
	
	
	@Before("PointCut.detailCoursePointCut()")  // 디테일코스에서 어떤 코스번호를 선택했는지 로그로 기록하기 위해 
	public void detatilCourseBefore(JoinPoint jp) {
		Object[] detailCourseArg = jp.getArgs();
		
		try {
			System.out.println("디테일코스로그 : " + detailCourseArg[2].toString());
			ldao.insertLog(new LogVo("00701",(Integer)detailCourseArg[2]+"" , null, 0,null));
		}catch (Exception e) {
			System.out.println("로그어드바이스 디테일코스비포 예외 " +e.getMessage());
		}
		
	}
	
	@Before("PointCut.searchCoursePointCut()")  // 서치코스에서 검색을 위해 어떤 항목들을 선택했는지 로그로 기록하기 위해 
	public void searchCourseBrfore(JoinPoint jp) {
		Object[] detailCourseArg = jp.getArgs();
		String disLog = "";
		String timeLog = "";
		
		try {
				int distance = (Integer)detailCourseArg[2];
				int time = (Integer)detailCourseArg[3];
				
				switch (distance) {
				case 0: disLog ="전체"; break;
				case 10:disLog = "10km 이하";break;
				case 30:disLog = "10-30km";break;
				case 50:disLog = "30-50km";break;
				case 1000:disLog = "50km 이상";break;
				}
				
				switch (time) {
				case 0:timeLog = "전체";break;
				case 60:timeLog = "1시간 미만";break;
				case 120:timeLog = "1-2 시간";break;
				case 180:timeLog = "2-3 시간";break;
				case 1000:timeLog = "3시간 이상";break;
				}
				
				ldao.insertLog(new LogVo("00702", disLog, null, 0,null));
				ldao.insertLog(new LogVo("00703", timeLog, null, 0,null));
				
				if(detailCourseArg[4] != null) {
					for(String v : (List<String>)detailCourseArg[4]) {
						ldao.insertLog(new LogVo("00704", v, null, 0,null));
					}
				}
				else {
					ldao.insertLog(new LogVo("00704", "선택안함", null, 0,null));
				}
		
			
		}catch (Exception e) {
			System.out.println("로그어드바이스 서치코스비포 예외 " +e.getMessage());
		}
		
		
	}
	
	@Before("PointCut.tagSearchCoursePointCut()")  // 태그검색에서 검색을 위해 어떤 항목들을 검색했는지 로그로 기록하기 위해 
	public void tagSearchCoursePointCutBrfore(JoinPoint jp) {
		Object[] detailCourseArg = jp.getArgs();

		try {
			String tags = (String)detailCourseArg[0];
			
			if(!tags.equals("") && tags != null) {
				ArrayList<String> tagLogList = new ArrayList<String>();
				String [] tagArr = (((String)detailCourseArg[0]).replaceAll(" ", "")).split(",");
				for(String t : tagArr) {
					if(!t.equals("")) {
						tagLogList.add(t);
					}
				}
				
				for(String t : tagLogList) {
					ldao.insertLog(new LogVo("00705", t, null, 0,null));
				}
			}

		}catch (Exception e) {
			System.out.println("로그어드바이스 태그서치코스비포 예외 " +e.getMessage());
		}
		
		

	}

	 @AfterReturning(pointcut = 
			 "PointCut.insertReview() || PointCut.insertReviewReply() || PointCut.insertMeeting() || "
			 + "PointCut.insertMeetingReply() || PointCut.approveCourse()", 
			 returning = "ret") 
	 public void insertRankPoint(JoinPoint jp, Object ret) { // 게시판글, 댓글 남길 시 랭크점수 추가하기위해 System.out.println("인서트랭크포인트 작동함");
		 try {
			 String mName = jp.getSignature().getName();
			 Object param = jp.getArgs()[0];
			 System.out.println("파람 : " +param);
			 int re  = (int) ret;
			 if(re >= 1) {
				switch (mName) {
				case "insert": mdao.insertPoint(new PointVo(((ReviewVo)param).getId(), PointGet.writeReviewPonit, PointCause.writeReviewCause));break;
				case "insertRep": mdao.insertPoint(new PointVo(((Review_repVo)param).getId(), PointGet.writeMeetingReplyPonit, PointCause.writeReviewReplyCause));break;
				case "insertMeeting": mdao.insertPoint(new PointVo(((MeetingVo)param).getId(), PointGet.writeMeetingReplyPonit, PointCause.writeMeetingReplyCause));break;
				case "insertMRep": mdao.insertPoint(new PointVo(((Meeting_repVo)param).getId(), PointGet.writeMeetingReplyPonit, PointCause.writeMeetingReplyCause));break;
				case "approveCourse": mdao.insertPoint(new PointVo(cdao.getCourseByCno((Integer)param, "").getId(), PointGet.makingCoursePonit, PointCause.makingCourseCause));break;
				}
			 }
		 }catch (Exception e) {
			System.out.println("로그어드바이스 인서트랭크포인트 예외 " +e.getMessage());
		}
		
	 
	 }
	 
	 @Around(value = "PointCut.deleteReview() || PointCut.deleteReviewReply() || PointCut.deleteMeeting() || PointCut.deleteMeetingReply()") 
	 public Object deleteRankPoint(ProceedingJoinPoint jp) { // 게시판글, 댓글 남길 시 랭크점수 추가하기위해 System.out.println("인서트랭크포인트 작동함");
		 int re = 0;
		 try {
			 String mName = jp.getSignature().getName();
			 int no = (Integer)jp.getArgs()[0];
			 String id="";
			 
			 switch (mName) {
				case "delete": id=rdao.selectOne(no).getId(); break;
				case "deleteRepOne": id=rdao.getReviewRepOne(no).getId(); break;
				case "deleteMeeting": id=medao.detailMeeting(no).getId();break;
				case "deleteMrOne":  id=medao.getMeetingRepOne(no).getId();break;
				}
			 
			 System.out.println(mName);
			 System.out.println(no);
			 System.out.println(id);
			 
			 Object obj= jp.proceed();
			 
			if(obj != null) {
				re = (Integer)obj;
			}
			  
			 if(re >= 1) {
				switch (mName) {
				case "delete": mdao.insertPoint(new PointVo(id, PointGet.deleteReviewPonit, PointCause.deleteReviewCause));break;
				case "deleteRepOne": mdao.insertPoint(new PointVo(id, PointGet.deleteReviewReplyPonit, PointCause.deleteReviewReplyCause));break;
				case "deleteMeeting": mdao.insertPoint(new PointVo(id, PointGet.deleteMeetingPonit, PointCause.deleteMeetingCause));break;
				case "deleteMrOne": mdao.insertPoint(new PointVo(id, PointGet.deleteMeetingReplyPonit, PointCause.deleteMeetingReplyCause));break;
				}
			 }
		 }catch (Throwable t) {
			System.out.println("로그어드바이스 딜리트랭크포인트 예외 " +t.getMessage());
		}
		
		 return re;
	 
	 }
	 
	 
	 


	 
}
