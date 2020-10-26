<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>자유게시판 상세</h2>
	<hr>
	<c:choose>
		<c:when test="${m != null }">${m.nickName } 라이더님 || <a href="/logout">로그아웃</a> </c:when>
		<c:when test="${m == null }"><a href="/login">로그인</a> || <a href="/signUp">회원가입</a> </c:when>
	</c:choose>
	<hr>
	글번호 ${f.no } &nbsp;&nbsp;&nbsp;등록일 ${f.regdate }&nbsp;&nbsp;&nbsp;조회수 ${f.hit }<br>
	작성자 ${f.nickname }
	<br>
	글제목 ${f.title }<br>
	글내용<br>
	<textarea rows="10" cols="70">${f.content }</textarea><br>
	<c:forEach var="file" items="${f.file}">
		<a href="freeBoardFile/${file.ff_savename }"><img src="freeBoardFile/${file.ff_savename }" width="100px" height="100px"></a>
	</c:forEach>
	<a href="/user/insertFreeBoard">글쓰기</a>
	<c:if test="${ m.id == f.id }">
	<a href="/user/updateFreeBoard?no=${f.no }"><button>수정</button></a> 
	<a href="/user/deleteFreeBoard?no=${f.no }"><button>삭제</button></a>
	</c:if>
</body>
</html>