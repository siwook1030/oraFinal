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
	text-decoration: none;
}

#contents {
	width: 900px;
	height: 700px;
	margin: 20px auto;
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
	color: #0f0f0f;
	height: 25px;
}

td {
	padding: 6px;
	text-align: center;
}

#content {
	padding: 15px;
	height: 500px;
	width: 850px;
	border: none;
}

#btnList,#btnUpdate,#btnDelete {
	width:50px;
	height: 30px;
    background-color: #88bea6;
    border: none;
    border-radius:5px;
    color:#ffffff;
    padding: 5px 0;
    font: bold;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 13px;
    margin: 0 5px 0 0;
    cursor: pointer;
    float: right;
}

#btnDelete{
	background-color: #eccb6a;
}

#btnList{
	background-color: #d0a183;
	float: left;
}

   /*float 초기화 아이디*/
#clear{
	clear: both; 
}
</style> 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/js/loginCheck.js"></script>
<script type="text/javascript">
window.onload = function(){
	const checkM = checkLogin(); // 로그인이 되어있는 상태인지 체크한다
	console.log(checkM);
//
	const btnUD = document.getElementById("btnUD");
	const btnUpdate = document.getElementById("btnUpdate");
	
	if(checkM.item.code_value != null && checkM.item.code_value == "00101"){
		btnUD.style.display = "inline";
	}

	/*btnUpdate.addEventListener("click", function(e){
		const n_no = btnUpdate.value;
		console.log(n_no);
		window.location = "/admin/updateNotice?n_no="+n_no;
	}*/
}
	

	
</script>
</head>
<body>
	<jsp:include page="header.jsp"/>
   
	<a href="/listNotice"><h2>공지사항</h2></a>
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
			<div id="content" style="white-space:pre;"><c:out value="${n.n_content}" /></div><br>
		<a href="listNotice"><button type="button" id="btnList">목록</button></a>
		<div id="btnUD">
			<button type="button" id="btnDelete">삭제</button>
			<!-- <button type="button" id="btnUpdate" value="${n.n_no }">수정</button> -->
		 	<a href="/admin/updateNotice?n_no=${n.n_no}"><button type="button" id="btnUpdate" value="${n.n_no }">수정</button></a> 
		</div>
		</section>
	<br>
	<jsp:include page="footer.jsp"/>
</body>
</html>