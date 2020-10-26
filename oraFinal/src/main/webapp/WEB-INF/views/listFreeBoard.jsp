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
	<h2>자유게시판</h2>
	<hr>
	<c:choose>
		<c:when test="${m != null }">${m.nickName } 라이더님 || <a href="/logout">로그아웃</a> </c:when>
		<c:when test="${m == null }"><a href="/login">로그인</a> || <a href="/signUp">회원가입</a> </c:when>
	</c:choose>
	<hr>
	<table border="1">
		<tr>
			<td>글번호</td>
			<td>글제목</td>
			<td>작성자</td>
			<td>등록일</td>
			<td>조회수</td>
		</tr>
		<c:forEach var="f" items="${list }">
			<tr>
				<td>${f.no }</td>
				<td>
				<a href="detailFreeBoard?no=${f.no }">
				<c:if test="${f.file != null }">
				<img src="/freeBoardFile/${f.file.get(0).ff_savename }" width="50px" height="50px">
				</c:if>
				${f.title }
				</a>
				</td>
				<td>${f.nickname }</td>
				<td>${f.regdate }</td>
				<td>${f.hit }</td>
			</tr>
		</c:forEach>
	</table>
	<a href="/user/insertFreeBoard">글쓰기</a>

</body>
</html>