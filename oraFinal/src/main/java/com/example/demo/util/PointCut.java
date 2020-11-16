package com.example.demo.util;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

@Service
@Aspect
public class PointCut {
	
	@Pointcut("execution(* com.example.demo.controller.CourseController.detailCourse(..))") 
	public void detailCoursePointCut() {}  // 디테일코스에서 어떤 코스번호를 선택했는지 알기 위해 포인트컷 지정
	
	@Pointcut("execution(* com.example.demo.controller.CourseController.searchCourse(..))") 
	public void searchCoursePointCut() {}  // 서치코스에서 검색을 위해 어떤 항목들을 선택했는지 알기 위해 포인트컷 지정
	
	// 랭크점수 추가위해 게시판글, 댓글 매니저 포인트컷
	@Pointcut("execution(* com.example.demo.db.ReviewManager.insert(..))")
	public void insertReview() {}
	
	@Pointcut("execution(* com.example.demo.db.ReviewManager.insertRep(..))")
	public void insertReviewReply() {}
	
	@Pointcut("execution(* com.example.demo.db.ReviewManager.insertMeeting(..))")
	public void insertMeeting() {}
	
	@Pointcut("execution(* com.example.demo.db.ReviewManager.insertMRep(..))")
	public void insertMeetingReply() {}
}
