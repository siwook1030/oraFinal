<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">


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

#contents {
	width: 900px;
	height: 700px;
	margin: 20px auto;
	font-family: 'NEXON Lv1 Gothic Low OTF';
	font-size: 15px;
}

table, th, td {
	border: solid 1px #fff2e4;
	border-collapse: collapse;
}

th {
	padding: 6px;
	text-align: center;
	background-color: #fff2e4;
}

td {
	padding: 6px;
	text-align: center;
}

p {
	padding: 15px;
	height: 500px;
}

button,#btn_update {
	width:50px;
	height: 30px;
    background-color: #eccb6a;
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
    margin: 0 5px 0 0;
    cursor: pointer;
    float: right;
}

#btn_update{
	background-color: #88bea6;
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
	<section id="contents">
			<table border="1" width="100%">
		      <tr>
		         <th>${n.code_name }</th>
		         <th>${n.n_title }</th>
		         <th>${n.n_regdate }</th>
		         <th>${n.n_hit }</th>
		      </tr>
		    </table> 

			<br>
			<p>${n.n_content }</p><br>
		<a href="listNotice"><button>목록</button></a>
		<a href="updateNotice"><button id="btn_update">수정</button></a>
		</section>
	<br>
	<jsp:include page="footer.jsp"/>
</body>
</html>