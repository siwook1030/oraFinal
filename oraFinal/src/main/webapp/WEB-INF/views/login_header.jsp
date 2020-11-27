<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
#login {
	font-size: 14px;
	text-align: right;
}

.my{
	padding: 5px;
	margin: 2px;
}

  .my-link_2 {
    font-size: 12px;
    padding-top: .1rem;
    padding-bottom: .1rem;
    padding-left: 1px;
    padding-right: 1px;
    color: #000000;
    font-weight: 400;
    opacity: 1 !important; }

  .my-link {
    font-size: 18px;
    padding-top: .7rem;
    padding-bottom: .7rem;
    padding-left: 20px;
    padding-right: 20px;
    color: #000000;
    font-weight: 600;
    opacity: 1 !important; }
  .my-link:hover {
      color: #c8572d; }

<!--화면 줄어들때 메뉴색-->
.ftco-navbar-light {
    background: #ffffff !important;
    position: relative;
    top: 0;
}

</style>
   <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="resources/css/animate.css">
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="resources/css/animate.css">
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/style.css">


  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
      <div class="container">
         <a style="font-size: 30px;" class="navbar-brand" href="/mainPage">
        <span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
        <font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</span></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
               <span class="oi oi-menu"></span> Menu
            </button>
         
         <div class="collapse navbar-collapse" id="ftco-nav" style="display: block; ">
              <ul class="navbar-nav ml-auto">
               <c:choose>
                  <c:when test="${m == null }">
                     <li class="nav-item"><a style="font-size: 15px; " href="/login" class="my-link">로그인</a></li>
                     <li class="nav-item"><a style="font-size: 15px;" href="/signUp" class="my-link">회원가입</a></li>
                  </c:when>
                  <c:when test="${m != null }">
                     <li class="nav-item"><a style="font-size: 15px;" ">${m.nickName } 라이더님</a></li>
                     <li class="nav-item"><a style="font-size: 15px;" href="/logout" class="my-link">로그아웃</a></li>&nbsp;&nbsp;
                     <li class="nav-item"><a style="font-size: 15px;" href="/myPage" class="my-link">마이페이지</a></li>
            </ul>
         </div>
		<div  class="collapse navbar-collapse" style="display: block; font-size: 12px;">
              <ul class="navbar-nav ml-auto" style="list-style:none float:right">
				<li class="my active"><a href="/myPage" class="my-link_2">정보 수정</a></li>
				<li class="my"><a class="my-link_2" href="/myPageSaveCourse">찜 목록</a></li>
                <li class="my"><a class="my-link_2" href="/myPageMyCourse">내 코스</a></li>
                <li class="my"><a class="my-link_2" href="myPageListReview?id=${m.id}">내 후기</a></li>
                <li class="my"><a class="my-link_2"href="listMeeting?id=${m.id}">내 번개</a></li>
                <li class="my"><a class="my-link_2"href="/myPageMyRank">랭킹</a></li>
                
              
                  </c:when>
               </c:choose>

              </ul>
         </div>      

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="/mainPage" class="my-link">Home</a></li>
	          <li class="nav-item"><a href="/listNotice" class="my-link">오늘의 라이딩</a></li>
	          <li class="nav-item"><a href="/searchCourse" class="my-link">라이딩 코스</a></li>
	          <li class="nav-item"><a href="/listReview" class="my-link">라이딩 후기</a></li>
	          <li class="nav-item"><a href="/listMeeting" class="my-link">번개 라이딩</a></li>
	          <li class="nav-item"><a href="/user/makingCourse" class="my-link">메이킹 코스</a></li>
	        </ul>
	      </div>
        
       </div>
   </nav>
    <!-- END nav -->


</body>
</html>