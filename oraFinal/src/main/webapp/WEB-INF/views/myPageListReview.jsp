<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-작성한 후기글</title>

<style type="text/css">
	  ul { //메뉴 스타일
	         box-pack:center;
	                        justify-content: center; // 창에따라 사이즈 달라짐
	         background-color: #ffffff;
	         list-style-type: none;
	         margin: 50px; //메뉴 위치
	         padding: 50px;
	         overflow: hidden;
	      }
	      li { float: center; }
	      li a {
	         display: block;
	         background-color: #ffffff;
	         color: gray;
	         padding: 15px;
	         float: left; // 수평으로만들기 (지우면 세로로됨)
	         width: 100px;
	         text-decoration: none;
	         text-align: center;
	         font-weight: bold;
	      }
	      li a.current {
	         color: black;
	         background-color: #FF6347; //주황색 클릭
	
	      }
	      li a:hover:not(.current) {
	         background-color: #CD853F; //갈색 마우스위로
	         color: white;
	      }
	
		<!-- 후기게시판 테이블-->
		section {
			margin: 0 auto;
			width:  700px;
			text-align: left;
		}
		table {
			border-collapse: collapse;
			text-align: center;
			width: 100%;
		}
		.pageStr {
			text-align: center;
		}
		td, th {
			border-bottom: 1px #7a7a7a solid;
		}
</style>
</head>
<body>


  <ul>
   <h1>마이페이지</h1>
           <li><a  href="/myPage">정보 수정</a></li>
            <li><a href="/myPageSaveCourse">찜 목록</a></li>
            <li><a href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li><a class="current" href="/myPageListReview">작성 후기</a></li>
            <li><a href="myPageListMeeting">작성 번개</a></li>
 	        <li><a href="/myPageMyRank">랭킹</a></li>
   </ul>

<ul>
		<table width="100%">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;번호&nbsp;&nbsp;&nbsp;</th>
				 <th>코스</th>
				 <th>제목</th>
				 <th>작성자</th>
				 <th>작성시간</th>
				 <th>조회</th>
			</tr>
				<c:forEach var="vo" items="${list }" >	
					<tr class="row">
						<td>${vo.r_no }</td>
						<td>${vo.c_name }</td>
						<td><a href="detailReview?r_no=${vo.r_no }">${vo.r_title }</a></td>
						<td><img src="rank/${vo.rank_icon }" height='20px'">${vo.nickName }</td>
						<td>${vo.r_regdate }</td>
						<td>${vo.r_hit }</td>
					</tr>
				</c:forEach>
		</table>
		<br>
		<br><br>
		<div class="pageStr">${pageStr }</div>
	</ul>
<jsp:include page="footer.jsp"/>
</body>
</html>