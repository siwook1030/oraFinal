<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>오늘의라이딩</title>
<style type="text/css">
     * {
      margin: 0px;
      padding: 0px;
   }
   header {
      width: 1000px;
      height: 100px;
      margin-top: 10px;
      font-family: 'NEXON Lv1 Gothic Low OTF';
      border: solid 1px red;
      margin: 10px auto;
   }
   #logo {
       float: left; 
   }
   #top {
      margin: 30px 20px 0 0;
      font-size: 12px;
      float: right;
      text-align: right;   
   }
   #login {
      font-size: 11px;
      text-align: right;
   }
   /*매인섹션부분css------------ ----------------*/
   section {
   	margin: 0 auto;
	   	width: 1000px;
	   	font-family: 'NEXON Lv1 Gothic Low OTF';
	   	text-align: center;
   }
   #recommendCourse{
   		margin-top: 20px;
   		text-align: center;
   }
    #rcTitle{
	border-bottom : solid 1px gray;
   	font-size : 110%;
   	width : 40%;
   	padding-bottom : 5px;
   	color: gray;
   	margin-left: auto; 
   	margin-right: auto;
   }
   #rcList{
   	width: 100%;
   }
	
	#rcBox{
		display: inline-table;
		width: 20%;
		height: 200px;
		margin: 0 10px 0 10px;
		word-break:break-all;
	}
 	
 	#rcBoxName{
 		background-color: black; 
 		padding: 5px 0 5px 0;
   		text-align : center;
    	opacity: 0.5;
    	margin-top: 80px;
    	font-size: 130%;
 	}
 	#rcBoxName span{
 		color: white;
 		
 	}
 	
    #helpDesk{
   		margin-top: 100px;
   		text-align: center;
   }
     #hdTitle{
	border-bottom : solid 1px gray;
   	font-size : 110%;
   	width : 40%;
   	padding-bottom : 5px;
   	color: gray;
   	margin-left: auto; 
   	margin-right: auto;
   }
   #hdList{
   	display: inline-block;
   	width: 100%;
   }
  #hdBox{
 	word-break:break-all;
  	display: inline-table;
  	width: 14%;
  	height: 140px;
  	margin: 0 10px 0 10px;
  	background-size: cover;
  }
   /*메인섹션 끝css--------------------------*/
   footer {
   margin: 30px auto;
       width: 1000px;
       height: 150px;
       font-family: 'NEXON Lv1 Gothic Low OTF';
       border: solid 1px green;
      }
    #footer_box {
       width: 1000px;
       height: 150px;
       margin: 0 auto;
       text-align: center;
      
    }
    #footer_icon{
       margin: 0 auto;
    }
    #address {
       margin: 10px 0 0 0;
       font-size: 11px;
    }
   /*float 초기화 아이디*/
   #clear{
   	clear: both; 
   }
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function(){

})
</script>
</head>
<body>

<header>
  <div id="logo">
         <a href="/mainPage"><img src='/headerImg/logo.png' height="100"></a>
      </div>
      <div id="login">
      <c:choose>
      	<c:when test="${m == null }">
      		<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
      	</c:when>
      	<c:when test="${m != null }">
      		${m.nickName } 라이더! &nbsp;&nbsp;<a href="/logout">로그아웃</a>&nbsp;&nbsp;<a href="/myPage">마이페이지</a>
      	</c:when>
      </c:choose>
         <img src="/headerImg/myIcon.png" height="40">
         &nbsp;&nbsp;
      </div>
      <div id="top">
         <a href="/searchCourse">오늘의 라이딩</a>&nbsp;&nbsp;&nbsp;&nbsp;자전거길&nbsp;&nbsp;&nbsp;&nbsp;<a href="listReview">후기게시판</a>&nbsp;&nbsp;&nbsp;&nbsp;
         <a href="listMeeting">번개게시판</a>&nbsp;&nbsp;&nbsp;&nbsp;정보게시판
      </div>
 </header>
      <div id="clear"></div>
  	<section>
  	<div id="mainPhoto" style="width: 100%; height: 500px; background-image: url('/mainPageImg/mainPhoto1.png');background-size: cover;"></div>
  		<h4><span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
  		<font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</span></font>과 함께 달려보세요!</h4>
  		
  		<div id="recommendCourse">
  		<div id="rcTitle">
  		Today's&nbsp;Riding<span style="font: italic bold 1.5em/1em Georgia,serif; font-size:15px; color: gray;">&nbsp;&nbsp;&nbsp;view is ${view }</span>
  		</div>
  		<br>
  		<div id="rcList">
  				<c:forEach var="c" items="${clist }">
  				<a href="detailCourse?c_no=${c.c_no }"><div id="rcBox" style="background-image: url('/coursePhoto/${c.c_photo.get(0).cp_name}'); background-size: cover;">		
  				<div id="rcBoxName"><span>${c.c_name }</span></div> 				
  				</div></a>
  				</c:forEach>
  		</div>
  		</div>
  		<div id="helpDesk">
  		<div id="hdTitle">
  		HELP DESK
  		</div>
  		<br>
  		<div id="hdList">
  			<a><div id="hdBox" style="background-image: url('/mainPageImg/howToUse.png');"></div></a>
  			<a href="listNotice"><div id="hdBox" style="background-image: url('/mainPageImg/notice.png');"></div></a>
  			<a><div id="hdBox" style="background-image: url('/mainPageImg/event.png');"></div></a>
  			<a href="/user/makingCourse"><div id="hdBox" style="background-image: url('/mainPageImg/cs.png');"></div></a>
  		</div>
  		</div>
  	</section>
  	
  	<div id="clear"></div>
  	
   <footer>
      <div id='footer_box'>
            <div id="footer_icon" >
               <img src='/footerImg/instagram.png' height="50px">
               <img src='/footerImg/facebook.png' height="50px">
               <img src='/footerImg/twitter.png' height="50px">
               <ul id="address">
                  <li>04108 | 서울시 마포구 백범로 23 구프라자 3층</li>
                  <li>TEL: 02-707-1480 | Email: ora@bit.com</li>
                  <li>COPYRIGHT (C)2020 오늘의 라이딩 ALL RIGHTS RESERVED</li>
               </ul>
            </div>
            
         </div>
   </footer>
</body>
</html>