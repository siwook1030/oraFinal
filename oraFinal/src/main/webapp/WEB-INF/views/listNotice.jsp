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
	text-decoration: none;
}
   
section {
	width: 900px;
	height: 700px;
	margin: 50px auto;
	float: center;
}

#btn_search,#btn_write{
	width:50px;
	height: 30px;
    border: none;
    border-radius:5px;
    color:#ffffff;
    padding: 5px 0;
    font: bold;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 13px;
    margin: 0px;
    cursor: pointer;
}

#btn_search{
	background-color: #ECCB6A;
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
	height: 30px;
	width: 100px;
	font-size: 15px;
}

input#search{
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
	color: #0f0f0f;
	text-decoration: none;
}

th {
	padding: 6px;
	text-align: center;
	background-color: #fff2e4;
	height: 25px;
}

td {
	padding: 6px;
	text-align: center;
	height: 30px;
}

#insertNotice{
	display: none;
}

#page {
	text-align: center;
	margin-top: 50px;
}

span {
	margin: 3px;
	padding: 4px 8px;
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
	
	const tbody = document.getElementById("tbody");
	const btn_search = document.getElementById("btn_search");
	const code_value = document.getElementById("code_value");
	const search = document.getElementById("search");
	
	let pageNo = 1;
	const recordSize = ${recordSize};
	const pageSize = ${pageSize};
	listNotice();
//
   
	
	const insertNotice = document.getElementById("insertNotice");
	if(checkM.item.code_value != null && checkM.item.code_value == "00101"){
		insertNotice.style.display = "inline";
	}

	function listNotice(){
		const cvalue = code_value.value;
		const searchText = search.value.trim();
		
			$.ajax({
				url:"/listNoticeJson",
				type:"GET",
				data : {
					"pageNo": pageNo,
					"code_value":cvalue,
					"searchText":searchText
				},
				success:function(map){
					$('tbody').empty();
					setList(map.list);
					setPage(map.totRecord);
					console.log(map.totRecord);
				}
			});
		}
		
	
	btn_search.addEventListener("click", function(e){
		pageNo=1;
		listNotice();
	});
	search.addEventListener("keyup", function(e) {
		if(e.keyCode == '13'){
			pageNo=1;
			listNotice();
		}
	})

	function setList(list){
		tbody.innerHTML="";
		list.forEach(function(n, i){
		const tr = document.createElement("tr");
		tr.className="row";
		let nc = '<td>'+n.code_name+'</td>';
			  nc+=    '<td><a href="detailNotice?n_no='+n.n_no+' ">'+n.n_title+'</a></td>';
			  nc+= '<td>'+n.n_regdate+'</td>';
			  nc+= '<td>'+n.n_hit+'</td>';
		   tr.innerHTML=nc;
		   tbody.append(tr);	
		});
		
	};

	function setPage(totRecord){
		$('#page').empty();
		$('#page').css('cursor','pointer');
		//$('#page').css('cursor','pointer');
		// 총 페이지 수
		let totPage = Math.ceil(totRecord/recordSize);
		console.log('*** totPage : '+totPage);

		// 페이지 버튼 숫자
		let startPage = parseInt((pageNo-1)/pageSize)*pageSize+1;
		let endPage = startPage+pageSize-1;
		if(endPage>totPage) {
			endPage = totPage;
		}
		console.log('*** startPage : '+startPage);
		console.log('*** endPage : '+endPage);


		if(startPage>1) {
			const prev = $('<span></span>').attr('idx',(startPage-1)).html('<');
			$('#page').append(prev);
			$(prev).click(function(){
				const idx = $(this).attr('idx');
				pageNo = idx;
				listNotice();
			});
		}
		
		for(let i=startPage; i<=endPage; i++){
			const a = $('<span></span>').attr('idx',i).html(i);
			if(i==pageNo){
				$(a).css({
					color: 'white',
					backgroundColor: '#bae4f0',
					borderRadius: '15px'
				});
			}
			$('#page').append(a);
			$(a).click(function() {
				const idx = $(this).attr('idx');
				if(pageNo==idx){
					return;
				} 
				console.log(idx);
				pageNo = idx;
				listNotice();
			});			
		}
			if(totPage>endPage){
			const next = $('<span></span>').attr('idx',(endPage+1)).html('>');
			$('#page').append(next);
			$(next).click(function(){
				const idx = $(this).attr('idx');
				pageNo = idx;
				listNotice();
			});
		}			
	}

	$(document).on("mouseover", ".row", function(){
		$(this).css("background-color","#f0f0f0");
	});
	$(document).on("mouseleave", ".row", function(){
		$(this).css("background-color","white");
	});
}
	

	
</script>
</head>
<body>
	<jsp:include page="header.jsp"/>
   
	<a href="listNotice"><h2>공지사항</h2></a>
	<section>
		<div id="box">
			<div id="container">

		     	<select id="code_value" name="code_value" size="1">
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
				<thead>
					<tr>
						<th>카테고리</th>
						<th>제목</th>
						<th>등록일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody id="tbody">
				<!--<c:forEach var="n" items="${list }">
				<tr>
					<td>${n.code_name }</td>
					<td>
						<a href="detailNotice?n_no=${n.n_no }">${n.n_title }</a>
					</td>
					<td>${n.n_regdate }</td>
					<td>${n.n_hit }</td>
					</tr>
				</c:forEach>-->
				</tbody>
			</table>
		</div>

		<div id="insertNotice">
			<a href="/admin/insertNotice"><button id="btn_write">글쓰기</button></a><br>
		</div>
		<div id="page"></div>
		
	</section>
	<br>
	<jsp:include page="footer.jsp"/>
</body>
</html>