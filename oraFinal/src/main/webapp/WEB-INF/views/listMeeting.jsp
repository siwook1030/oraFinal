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
		td, th {
			border-bottom: 1px #7a7a7a solid;
			padding: 4px 0 4px;
		}
		#page {
			text-align: center;
			margin-top: 50px;
		}
		span {
			margin: 3px;
			padding: 4px 8px;
		}
		.btn {
			color: white;
			padding: 8px 12px;
			background-color: #88BEA6;
			float: right;
			font-size: 15px;
			border: none;
			cursor: pointer;
		}
	</style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	window.onload = function(){
		let pageNo = 1;
		const recordSize = ${recordSize};
		const pageSize = ${pageSize};
		listMeeting();

		// 나우페이지를 주면 리스트를 띄울 함수 하나
		// 페이징바를 만들 함수하나
		
		function listMeeting(){
			$.ajax({
				url: "/listMeetingJson",
				type: "GET",
				data : {
					"pageNo": pageNo
				},
				success: function(map){
					$('tbody').empty();
					setList(map.list);
					setPage(map.totRecord);
				}
			})						
		}

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
					listMeeting();
				});
			}
			
			for(let i=startPage; i<=endPage; i++){
				const a = $('<span></span>').attr('idx',i).html(i);
				if(i==pageNo){
					$(a).css({
						color: 'white',
						backgroundColor: '#ECCB6A',
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
					listMeeting();
				});			
			}
 			if(totPage>endPage){
				const next = $('<span></span>').attr('idx',(endPage+1)).html('>');
				$('#page').append(next);
				$(next).click(function(){
					const idx = $(this).attr('idx');
					pageNo = idx;
					listMeeting();
				});
			}			
		}

		function setList(arr){
			$.each(arr, function(idx, data){
				//console.log('*** arr length : '+arr.length);
				const tr = $('<tr></tr>');
				const m_no = $('<td></td>').html(data.m_no);
				const c_name = $('<td></td>').html(data.c_name);
				const m_time = $('<td></td>').html(data.m_time);
				const m_titleLink = $('<a></a>').attr('href','detailMeeting?m_no='+data.m_no).html(data.m_title);
				const m_title = $('<td></td>').html(m_titleLink).addClass('tdTitle');
				const nickName_icon = $('<img/>').attr({src : 'rank/'+data.rank_icon, height : '20px'});
				const nickName = $('<td></td>').append(nickName_icon, data.nickName);
				const m_regdate = $('<td></td>').html(data.m_regdate);
				const m_hit = $('<td></td>').html(data.m_hit);
				tr.append(m_no, c_name, m_time, m_title, nickName, m_regdate, m_hit);
				$('tbody').append(tr);

				$(document).ready(function(){
					$(".tdTitle").hover(function(){
						$(this).css("text-decoration","underline");
					},function(){
						$(this).css("text-decoration","none");
					});
				});
			});
		}
		
	}

	function checkLogin(){
		let check;
			$.ajax({
				url: "/checkLogin",
				type: "POST",
				async: false,
				success: function(response){
					check =  response;
				},
				error: function(){
					alert("에러발생");
				}
			})
		return check;
		}
	
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
			<thead>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					 <th>코스</th>
					 <th>모임날짜</th>
					 <th>제목</th>
					 <th>작성자</th>
					 <th>작성시간</th>
					 <th>조회</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<br>
		<a href="/user/insertMeeting" class="btn">등록</a>
		<div id="page"></div>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
</html>