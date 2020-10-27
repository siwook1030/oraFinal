<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		/* 공통 */
	
		section {
			margin: 0 auto;
			padding: 10px;
			width: 1000px;
			text-align: left;
		}
	
	
		/* 개별 */
		.btnImg {
			height: 30px;
			float: right;
		}
		#reply {
			padding-bottom: 3px;
		}
		#comment {
			display:inline-block;
			position:relative;
		}
		#btnImg {
			position:absolute;
			bottom:30px;
			right:10px;
			border-style: none;
			background-color: transparent;
			width: 50px;
		}
		textarea {
			display:block;
		}
		#contents {
			border: 1px solid #D5D5D5;
			padding: 60px;
			margin: 50px 0 100px;
		}
		.repInfo {
			margin-left: 25px;
			font-size: 13px;
		}
		
		.repInput-noshow{
			display: none;
		}
		.repInput-show{
			display: inline;
		}
		
		.map_wrap {position:relative;width:100%;height:300px;font-size: 80%;}
	</style>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
$(function(){

	/*$("#loadComment").empty();
	$.ajax("/detailMRep",{function(arr){
		$.each(arr,function(idx, mr){
			var rank_icon = $("<img/>").attr("src","../meetingFile/"+mr.rank_icon);
			var nickName = $("<p></p>").html(mr.nickName);
			var mr_content = $("<p></p>").html(mr.mr_content);
			var mr_file1 = $("<img/>").attr("src","../meetingFile/"+mr.mr_file1);
			var regdate = $("<p></p>").html(mr.regdate);
			$("#loadComment").append(rank_icon, nickName, mr_content, mr_file1, regdate);
		});
	}});*/
///////////////////////////////////////////////////
	function checkLogin(){
		var check="0";
		$.ajax({
			url: "/checkLogin",
			type: "POST",
			async: false,
			success: function(data){
				check = data;
			},
			error: function(){
				alert("에러발생");
			}
		})

		return check;
	}
	
	var mrList = ${mrList};
	var m_no = ${m_no};
	var totalPageNum = ${totalPageNum};
	var nowPageNum = 1;

	function setPageNum(totalPageNum){
		var content="";
		for(var i=1; i<= totalPageNum; i++){
			content += '<span class="pageNum" val="'+i+'">'+i+'</span>';
		}
		$("#replyPgaeNum").html(content);
		console.log(content);
	}
	
 function setReply(mrList){
		$("#reply").empty();
		$(mrList).each(function(i, mr) {
			var mrDiv = $("<div></div>");
			var ul = $("<ul></ul>");
			var li1 = $("<li></li>");
			var li2 = $("<li></li>").attr("id","rep_input"+mr.mr_no).css({display: "none"});
			var hr = $("<hr>");
			
			var content="";
			if(mr.mr_step > 0){
				$(mrDiv).css({paddingLeft: "30px"});
			}
			content += '<img src="rank/'+mr.rank_icon+'" height="25">'+mr.nickName+'<br>';
			content += '<p style="margin-left: 25px;">'+mr.mr_content+'</p>';
			if(mr.mr_file1 != null){
				content += '<p style="margin-left: 25px;"><img src="meetingFile/'+mr.mr_file1+'" height="100"></p>';
			}
			content += '<p class="repInfo" style="float: left;">'+mr.mr_regdate+'<p>';
			var repSpan = $("<span></span>").html("답글달기");
			$(li1).html(content).append(repSpan);

			var repDiv = $("<div></div>");
			var rep_input = $("<textarea></textarea>").attr({rows:"5",cols:"50"});
			var btn = $("<button></button>").html("등록");
			$(repDiv).append(rep_input,btn);
			$(li2).append(repDiv);
			$(ul).append(li1,li2);
			$(mrDiv).append(ul,hr);
			$("#reply").append(mrDiv);

			$(repSpan).click(function() {
				repReply(li2);
			});
			$(btn).click(function() {
				repSub(rep_input);
			})
			
		})
		
 };

	$(document).on("click", ".pageNum" ,function() {
		var num = $(this).attr("val");
		$.ajax({
			url:"/detailMRep",
			type:"GET",
			data: {
				"m_no":m_no,
				"num":num
				},
			success: function(mrList){
				nowPageNum = num;   //나우페이지넘은 현재페이지가 몇인지 알기위해 선언한거
				console.log(nowPageNum);
				setReply(mrList);
			},
			error: function(){
				alert("에러발생");
			}
		});

	})
	
	setPageNum(totalPageNum);
	setReply(mrList);

	function repReply(li2){
		var check = checkLogin();
		if(check == "0"){
			var cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
			}
			return;
		}
		$(li2).css({display: "inline"});

	}

	function repSub(rep_input){
		var content = $.trim($(rep_input).val());
		if(content == ""){
			alert("내용을 입력하세요");
			return;
		}
		insertRep(content);
	}

	function insertRep(content){
		//$.ajax({url:"",data: })
	}
/////////////////////////////////////////////////////////////////////////////////// 맵표시
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.53814589110931, 126.98135334065803), // 지도의 중심좌표
        level: 7 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var mapTypeControl = new kakao.maps.MapTypeControl();
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	var startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
    startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
    startOption = { 
    offset: new kakao.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
    };
    //출발 마커 이미지를 생성합니다
    var startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);

    var arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
    arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
    arriveOption = { 
    offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
    };
    //도착 마커 이미지를 생성합니다
    var arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);

    var startMarker = new kakao.maps.Marker({image:startImage}); //출발마커담을 변수
    var arriveMarker = new kakao.maps.Marker({image:arriveImage});//도칙마커담을 변수
    var coursePolyline = new kakao.maps.Polyline({
       strokeWeight: 5,
        strokeColor: '#FF2400',
        strokeOpacity: 0.9,
        strokeStyle: 'solid'
       });//경로라인담을 변수
/////////////////출발도착마커이미지 생성 끝
	var meetingSrc = '/insertMeetingImg/meetingSpot.png', // 미팅 마커이미지의 주소입니다    
	meetingSize = new kakao.maps.Size(40, 40); // 미팅 마커이미지의 크기입니다 
	
	//미팅 마커 이미지를 생성합니다
	var meetingImage = new kakao.maps.MarkerImage(meetingSrc, meetingSize);
	var meetingMarker = new kakao.maps.Marker({image:meetingImage}); 

	if(${c.c_no} != 0){
		startMarker.setPosition(new kakao.maps.LatLng(${c.c_s_latitude}, ${c.c_s_longitude}));
		arriveMarker.setPosition(new kakao.maps.LatLng(${c.c_e_latitude}, ${c.c_e_longitude}));
		coursePolyline.setPath(${c.c_line});
		startMarker.setMap(map);
		arriveMarker.setMap(map);
		coursePolyline.setMap(map);
		map.setLevel(${c.c_mapLevel});
		
	}	
	meetingMarker.setPosition(new kakao.maps.LatLng(${mt.m_latitude}, ${mt.m_longitude}));
	meetingMarker.setMap(map);
	map.setCenter(new kakao.maps.LatLng(${mt.m_latitude}, ${mt.m_longitude}));
	/////////////////////////////////////////////////////////////////////////////////// 맵표시 끝

	
});
	</script>
</head>
<body>
<jsp:include page="header.jsp"/>
	<section>
		<br><br>
		<p style="font-size: 20px;"><a href="/listMeeting">번개 게시판</a>&nbsp;&gt;&nbsp;<font color="#c85725">번개 상세</font></p>
		<p style="font-size: 15px; padding-top: 2px;">만나서 같이 라이딩 해요.</p>
		<br><br>
	
		<div id="contents">
			<p style="font-size: 30px; padding: 30px 0 20px;">${mt.m_title }</p><br>	
			<img src="rank/${mt.rank_icon }" height="25" style="float: left; margin-right: 5px;">
			<div style="padding-top: 5px;">
				<p style="margin-right: 15px; float: left;">${mt.nickName }</p>
				<p style="float: left; font-size: 13px;">${mt.m_regdate }</p>
				<p style="float: right; font-size: 13px;">조회수 ${mt.m_hit }</p>
			</div>
			<br>
			<hr style="margin: 10px 0 10px;">
			<div style="padding: 3px; font-size: 20px;">코스 : ${mt.c_name }</div>
			<hr style="margin: 10px 0 10px;">
			<div class="map_wrap">
				<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			</div>
			<table border="1">
				<tr>
					<td>미팅장소</td><td>${mt.m_locname }</td>
					<td>미팅시간</td><td>${mt.m_time }</td>
					<td>미팅인원</td><td>${mt.m_numpeople }</td>
				</tr>
			</table>
			<!-- 
			위도 : ${mt.m_latitude }<br>
			경도 : ${mt.m_longitude }<br>
			모임장소 : ${mt.m_locname }<br>
			모임시간 : ${mt.m_time }<br>
			모임인원 : ${mt.m_numpeople }
			 -->
			<br>
		
			<c:if test="${mf!=null }">
				<c:forEach var="mf" items="${mf}">
					<img src="${mf.mf_path }/${mf.mf_savename }" width="400">
				</c:forEach> 
			</c:if>
			<br><br><br>
			${mt.m_content }
			<br><br><br><br>
			
			<!-- 수정,삭제 버튼 -->
			<a href="deleteMeeting?m_no=${mt.m_no }"><img src="meetingImg/delete.png" class="btnImg"></a>
			<a href="updateMeeting?m_no=${mt.m_no }"><img src="meetingImg/edit.png" class="btnImg"></a>
			<br><br>
			<img src="meetingImg/speech.png" style="size: 20px; float: left; padding-right: 10px;">
			<h3>댓글&nbsp;${cntRep }</h3>
			<hr style="margin: 10px 0 10px;">
			<!-- 댓글출력 -->
			<div id="reply">
			</div>
			<div id="replyPgaeNum">
			</div>
			
			<!-- jQuery -->
			<!-- 여기에 댓글출력 -->
			<!-- <div id="loadComment">
			</div>
			<button>[답글달기]</button>
			
			<img>rank_icon
			<p>nickName</p>
			<p>mr_content</p><br>
			<img>mr_file1
			<p>regdate</p> -->
			
			<br>
			댓글등록<br>
			<form id="comment">
				<input type="hidden" name="rank_icon" id="rank_icon">
				<input type="hidden" name="nickname" id="nickname">
				<input type="hidden" name="regdate" id="regdate">
				<textarea rows="10" cols="80" name="mr_content" id="mr_content"></textarea>
				<input type="file" name="mr_file1" id="mr_file1">
				<button id="btnAdd"><img src="meetingImg/add.png" id="btnImg"></button>
			</form>
			

		</div>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
</html>