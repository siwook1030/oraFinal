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
		#pageStr {
			text-align: center;
			margin: 30px 0 70px;
		}
		td, th {
			border-bottom: 1px #7a7a7a solid;
			padding: 4px 0 4px;
		}
	</style>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	window.onload = function(){
		listMeeting();


		// 나우페이지를 주면 리스트를 띄울 함수 하나
		// 페이징바를 만들 함수하나
		
		function listMeeting(){
			$.ajax({
				url: "/listMeetingJson",
				type: "GET",
				async: false,
				/* data : {
					pageNo: pageNo
				}, */
				success: function(r){
					$('tbody').empty();
					var arr = r.list;
					/* var start = r.start;
					var end = r.end;
					console.log(start);
					console.log(end); */

					let pageNo = 1;
					const recordSize = 5; // 한 번에 보이는 게시글 수
					const pageSize = 3; // 한 번에 보이는 페이지 수

					let totRecord = r.totRecord;
					console.log(totRecord);

					// 총 페이지 수
					let totPage = Math.ceil(totRecord/recordSize);
					console.log(totPage);

					// 페이지 버튼 숫자
					let startPage = (pageNo-1)/pageSize*pageSize+1;
					let endPage = startPage+pageSize-1;
					if(endPage>totPage) {
						endPage = totPage;
					}
					console.log('*** startPage : '+startPage);
					console.log('*** endPage : '+endPage);

					
					for(let i=startPage; i<=endPage; i++){
						const a = $('<a></a>').attr('href','').html(i+' ');
						$('#page').append(a);				
					}
					if(totPage>endPage){
						const next = $('<a></a>').attr('href','').html('>');
						$('#page').append(next);
					}

//					String pageStr="";
//					if(startPage>1) {
//						pageStr += "<a href='listMeeting?pageNo="+(startPage-1)+"'> < </a>"+"  ";
//					}
//					for(int i=startPage;i<=endPage;i++) {
//						pageStr += "<a href='listMeeting?pageNo="+i+"'>"+i+"</a>"+"  ";
//					}
//					if(totPage>endPage) {
//						pageStr += "<a href='listMeeting?pageNo="+(endPage+1)+"'> > </a>";
//					}
					
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
					});
				}
			})						
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

	

	
	/* $(document).ready(function(){
		$(".tdTitle").hover(function(){
			$(this).css("text-decoration","underline");
		},function(){
			$(this).css("text-decoration","none");
		});
	}); */
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
		<div id="page"></div>
		<a href="/insertMeeting"><img src="meetingImg/insert.png" height="30px" align="right"></a><br><br>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
</html>