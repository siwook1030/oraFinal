<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

#box{
  margin: 30px 10px 0 0;
  width: 400px;
  height: 30px;
}

h2 {
	padding: 20px;
	width: 120px;
	margin: 40px auto;
	color: #c8572d;
	text-align: center;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	text-decoration: none;
}

a{
	text-decoration: none;
	color: black;
}
   
section {
	width: 900px;
	height: 700px;
	margin: 50px auto;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	float: center;
}

#btn_search,#btn_write{
	width:50px;
	height: 30px;
    border: none;
    border-radius:5px;
    color:#ffffff;
    padding: 5px 0;
    font-family: 'NEXON Lv1 Gothic Low OTF';
    font: bold;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 13px;
    margin: 0px;
    cursor: pointer;
}

#btn_search{
	background-color: #eccb6a;
}

#btn_write{
	float: right;
	background-color: #88bea6;
}

button:hover {
	border: none;
    background-color: #ffffff;
    color: #c8572d;
}

select {
	font-size: 12px;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	height: 30px;
	width: 70px;
}

#container input#search{
	height: 30px;
	border: solid 1px;
	font-size: 11pt;
	color: #63717f;
	padding-left: 15px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

#tb{
	height: 600px;
}

table, th, td {
	margin-top: 30PX;
	border: solid 1px #fff2e4;
	border-collapse: collapse;
	font-size: 15px;
	color: black;
	text-decoration: none;
}

th {
	padding: 6px;
	text-align: center;
	background-color: #fff2e4;
	height: 20px;
}

td {
	padding: 6px;
	text-align: center;
	height: 20px;
}

   /*float 초기화 아이디*/
#clear{
	clear: both; 
}
</style> 
</head>
<body>
	<jsp:include page="header.jsp"/>
   
	<a href="listNotice"><h2>공지사항</h2></a>
	<section>
		<div id="box">
			<div id="container">

		     	<select name="code_value" size="1">
		     		<option value="0">전체</option>
		     		<c:forEach var="c" items="${category }">
		     			<option value="${c.code_value }">${c.code_name }</option>
		     		</c:forEach>
		        </select>
					<input type="search" id="search" placeholder="Search..." />
					<button id="btn_search">검색</button>

			</div>

		</div>
		
		<div id="tb">
			<table border="1" width="100%">
				<tr>
					<th>카테고리</th>
					<th>제목</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="n" items="${list }">
				<tr>
					<td>${n.code_name }</td>
					<td>
						<a href="detailNotice?n_no=${n.n_no }">${n.n_title }</a>
					</td>
					<td>${n.n_regdate }</td>
					<td>${n.n_hit }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<a href="/insertNotice"><button id="btn_write" type="button">글쓰기</button></a><br>
	</section>
	<br>
	<jsp:include page="footer.jsp"/>
</body>
</html>