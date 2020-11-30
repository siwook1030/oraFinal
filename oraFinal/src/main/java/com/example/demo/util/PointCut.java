package com.example.demo.util;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

@Service
@Aspect
public class PointCut {
	
	@Pointcut("execution(* com.example.demo.controller.CourseController.detailCourse(..))") 
	public void detailCoursePointCut() {}  // 디테일코스에서 어떤 코스번호를 선택했는지 알기 위해 포인트컷 지정
	
	@Pointcut("execution(* com.example.demo.controller.SearchCourseController.searchCourse(..))") 
	public void searchCoursePointCut() {}  // 맞춤코스검색에서 검색을 위해 어떤 항목들을 선택했는지 알기 위해 포인트컷 지정
	
	@Pointcut("execution(* com.example.demo.controller.SearchCourseController.tagSearchCourse(..))") 
	public void tagSearchCoursePointCut() {}  // 태그코스검색에서 검색을 위해 어떤 항목들을 선택했는지 알기 위해 포인트컷 지정
	
	// 랭크점수 추가위해 게시판글, 댓글, 코스만들기 dao 포인트컷
	@Pointcut("execution(* com.example.demo.dao.ReviewDao.insert(..))")
	public void insertReview() {}
	
	@Pointcut("execution(* com.example.demo.dao.ReviewDao.insertRep(..))")
	public void insertReviewReply() {}
	
	@Pointcut("execution(* com.example.demo.dao.MeetingDao.insertMeeting(..))")
	public void insertMeeting() {}
	
	@Pointcut("execution(* com.example.demo.dao.MeetingDao.insertMRep(..))")
	public void insertMeetingReply() {}
	
	@Pointcut("execution(* com.example.demo.dao.CourseDao.approveCourse(..))")
	public void approveCourse() {}
	
	
	// 삭제했을시 랭크점수 깍기위해 게시판글, 댓글 dao 포인트컷
	@Pointcut("execution(* com.example.demo.dao.ReviewDao.delete(..))")
	public void deleteReview() {}
	
	@Pointcut("execution(* com.example.demo.dao.ReviewDao.deleteRepOne(..))")
	public void deleteReviewReply() {}
	
	@Pointcut("execution(* com.example.demo.dao.MeetingDao.deleteMeeting(..))")
	public void deleteMeeting() {}
	
	@Pointcut("execution(* com.example.demo.dao.MeetingDao.deleteMrOne(..))")
	public void deleteMeetingReply() {}
}
