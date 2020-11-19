package com.example.demo.util;

import javax.servlet.ServletContext;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
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
	ServletContext sc;
	
	@Autowired
	MemberDao mdao;
	
	
	@Before("PointCut.detailCoursePointCut()")  // 디테일코스에서 어떤 코스번호를 선택했는지 로그로 기록하기 위해 
	public void detatilCourseBefore(JoinPoint jp) {
		Object[] detailCourseArg = jp.getArgs();
		System.out.println("코스경로 : " + sc.getRealPath("/courseLine"));
		System.out.println("디테일코스정보 : " + detailCourseArg[2].toString());
	}
	
	@Before("PointCut.searchCoursePointCut()")  // 서치코스에서 검색을 위해 어떤 항목들을 선택했는지 로그로 기록하기 위해 
	public void searchCourseBrfore(JoinPoint jp) {
		Object[] detailCourseArg = jp.getArgs();
		System.out.println("서치코스 거리 : " + detailCourseArg[2].toString());
		System.out.println("서치코스 시간 : " + detailCourseArg[3].toString());
		//System.out.println("서치코스  뷰 : " + detailCourseArg[4].toString());
	}

	 @AfterReturning(pointcut = "PointCut.insertReview() || PointCut.insertReviewReply() || PointCut.insertMeeting() || PointCut.insertMeetingReply()", returning = "ret") 
	 public void insertRankPoint(JoinPoint jp, Object ret) { // 게시판글, 댓글 남길 시 랭크점수 추가하기위해 System.out.println("인서트랭크포인트 작동함");
		 try {
			 String mName = jp.getSignature().getName();
			 Object param = jp.getArgs()[0];
			 System.out.println("파람 : " +param);
			 int re  = (int) ret;
			 if(re >= 1) {
				switch (mName) {
				case "insertMeeting": mdao.insertPoint(new PointVo(((MeetingVo)param).getId(), PointGet.writeMeetingReplyPonit, PointCause.writeMeetingReplyCause));break;
				case "insertMRep": mdao.insertPoint(new PointVo(((Meeting_repVo)param).getId(), PointGet.writeMeetingReplyPonit, PointCause.writeMeetingReplyCause));break;
				case "insert": mdao.insertPoint(new PointVo(((ReviewVo)param).getId(), PointGet.writeReviewPonit, PointCause.writeReviewCause));break;
				case "insertRep": mdao.insertPoint(new PointVo(((Review_repVo)param).getId(), PointGet.writeMeetingReplyPonit, PointCause.writeReviewReplyCause));break;

				}
			 }
		 }catch (Exception e) {
			System.out.println("로그어드바이스 인서트랭크포인트 예외 " +e.getMessage());
		}
		
	 
	 }
	 


	 
}
