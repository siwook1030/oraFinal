<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/js/insertBoard.js"></script>
</head>
<body>
	<h2>자유게시판 글쓰기</h2>
	<hr>
	<a href="/main">메인</a>
	<c:choose>
		<c:when test="${m != null }">${m.nickName } 라이더님 || <a href="/logout">로그아웃</a> </c:when>
		<c:when test="${m == null }"><a href="/login">로그인</a> || <a href="/signUp">회원가입</a> </c:when>
	</c:choose>
	<hr>
	<form action="/user/insertFreeBoard" method="post" id="freeForm" name="freeForm" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${m.id }">
		작성자 : ${m.nickName }<br>
		제목 <input type="text" name="title" id="title" placeholder="제목을 입력하세요"><br>
		내용 <textarea rows="10" cols="50" name="content" id="content" placeholder="내용을 입력하세요"></textarea><br>
		첨부 <input type="file" name="uploadFile"><br>
	 <input type="button" id="insert" value="등록">
	</form>
</body>
</html>