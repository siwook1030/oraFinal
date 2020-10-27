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
<jsp:include page="header.jsp"/>
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
  	<jsp:include page="footer.jsp"/>
</body>
</html>