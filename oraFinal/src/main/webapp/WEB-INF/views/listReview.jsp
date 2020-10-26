<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
section {
	margin: 0 auto;
	width: 1000px;
	text-align: left;
}
table {
	border-collapse: collapse;
	text-align: center;
}
.pageStr {
	text-align: center;
}
td, th {
	border-bottom: 1px #7a7a7a solid;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".row").hover(function(){
		$(this).css("background-color","#88bea6");
	},function(){
		$(this).css("background-color","white");
	});
});
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
<section>
   		<br>
		<p style="font-size: 20px">후기 게시판</p>
		<p style="font-size: 15px">라이딩 경험을 공유해요.</p>
		<br><br><br>
		<hr style="height: 10%; color: black;">
		<br>
		<table width="100%">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
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
		<c:if test="${m != null }">
			<a href="/insertReview"><img src="buttons/insert.png" height="30px" align="right"></a>
		</c:if>
		<br><br>
		<div class="pageStr">${pageStr }</div>
	</section>
<jsp:include page="footer.jsp"/>
</body>
</html>