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
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<section>
	<br>
	<p style="font-size: 20px">후기 게시판&nbsp;&gt;&nbsp;<font color="#c85725">게시글 등록</font></p>
	<p style="font-size: 15px">라이딩 경험을 공유해요.</p>

  	<!-- 글등록 -->
	<br><br>
	<form action="insertReview" method="post" enctype="multipart/form-data">
	제목 <input type="text" name="r_title" size="50"><br><br>
		
		<div>
			코스 
			<select name="c_no">
				<c:forEach var="vo" items="${list }">
					<option value="${vo.c_no }">${vo.c_name }</option>
				</c:forEach>
			</select>
		</div>
		<br><br>
		<hr><br>
		<!-- 글내용 -->
		<textarea rows="30" cols="65" name="r_content"></textarea><br>
		
		<!-- 사진등록 -->
		<input type="file" name="mf"><br><br>
		<!-- 
		<div style="text-align: center;">
			<button type="submit" style="border: none; background-color: transparent;"><img src="meetingImg/add.png"></button>
			<button type="reset" style="border: none; background-color: transparent;"><img src="meetingImg/cancel.png"></button><br>
		</div>
		-->
		<input type="submit" value="등록">
		<input type="reset" value="취소">
	</form>
</section>
<jsp:include page="footer.jsp"/>
</body>
</html>