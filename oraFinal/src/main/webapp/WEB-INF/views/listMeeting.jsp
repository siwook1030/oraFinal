<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section {
			margin: 0 auto;
			width: 1000px;
			text-align: left;
		}
		table {
			border-collapse: collapse;
			text-align: center;
		}
		#pageStr {
			text-align: center;
			margin: 30px 0 70px;
		}
		td, th {
			border-bottom: 1px #7a7a7a solid;
			padding: 4px 0 4px;
		}
	</style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$(".tdTitle").hover(function(){
			$(this).css("text-decoration","underline");
		},function(){
			$(this).css("text-decoration","none");
		});
	});
	</script>
</head>
<body>
	<jsp:include page="header.jsp"/>
   <section>
   		<br>
		<a href="/listMeeting?pageNo=1"><p style="font-size: 20px">번개 게시판</p></a>
		<p style="font-size: 15px">만나서 같이 라이딩 해요.</p>
		<br><br><br>
		<hr style="height: 10%; color: black;">
		<br>
		<table width="100%">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
				 <th>코스</th>
				 <th>모임날짜</th>
				 <th>제목</th>
				 <th>작성자</th>
				 <th>작성시간</th>
				 <th>조회</th>
			</tr>
				<c:forEach var="mt" items="${list }">	
					<tr>
						<td>${mt.m_no }</td>
						<td>${mt.c_name }</td>
						<td>${mt.m_time }</td>
						<td class="tdTitle"><a href="detailMeeting?m_no=${mt.m_no }">${mt.m_title }</a></td>
						<td><img src="rank/${mt.rank_icon }" height='20px'">${mt.nickName }</td>
						<td>${mt.m_regdate }</td>
						<td>${mt.m_hit }</td>
					</tr>
				</c:forEach>
			
		</table>
		<br>
		<a href="/insertMeeting"><img src="meetingImg/insert.png" height="30px" align="right"></a><br><br>
		<div id="pageStr">${pageStr }</div>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
</html>