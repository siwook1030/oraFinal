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
		 .repPageNum{
			margin: 0 5px 0 5px;
			cursor: pointer;
		}
		.btnRepSpan {
			cursor: pointer;
			margin-left: 3px;
			text-decoration: underline;
		}
		
		.map_wrap {position:relative;width:100%;height:300px;font-size: 80%;}
	</style>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
window.onload = function(){

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
	const checkM = checkLogin(); // 로그인이 되어있는 상태인지 체크한다
	console.log(checkM);
	
	const m_no = ${m_no}; //현재글번호
	let totalRecordR = ${totalRecordR};  // 전체 레코드수
	let totalPageNum = ${totalPageNum}; // 전체 페이지번호수
	const pageSizeR = ${pageSizeR}; // 댓글페이징번호 보여주는수
	let nowPageNum = 1; // 현재페이지번호르 담을변수

	const repCnt = document.getElementById("repCnt");
	const reply = document.getElementById("reply");
	const replyPgaeNum = document.getElementById("replyPgaeNum");
	
	function setPageNum(){  // 댓글 페이지번호를 나타내는 함수
		replyPgaeNum.innerHTML = "";
		let startPageNum = (parseInt((nowPageNum-1)/pageSizeR))*pageSizeR+1;
		let endPageNum = startPageNum+pageSizeR-1;
		if(endPageNum > totalPageNum){
			endPageNum = totalPageNum;
		}
		if(startPageNum > 1){
			const preSpan = document.createElement("span");
			preSpan.setAttribute("val", startPageNum-1);
			preSpan.className="repPageNum";
			preSpan.innerHTML="<";
			replyPgaeNum.append(preSpan);
			preSpan.addEventListener("click", function(e) {
				getMrListByPageNum(e.target.getAttribute("val"));
			})
		}
		for(let i=startPageNum; i<= endPageNum; i++){ // 페이지번호추가 for문
			const pageSpan = document.createElement("span");
				pageSpan.className = "repPageNum";
				pageSpan.setAttribute("val", i); // 페이지번호를 눌렀을때 페이지번호를 가져오기위해 val이라는 임의프로퍼티로 정의함
				pageSpan.innerHTML = i;
			if(i == nowPageNum){ // 현재몇페이지인지 나타내기 위해 처리하는곳 현재페이지는 글꼴을 굵고 크게처리
				pageSpan.style.fontWeight="bold";
				pageSpan.style.fontSize="130%";	
			}

			replyPgaeNum.append(pageSpan);
			pageSpan.addEventListener("click", function(e) { // 페이지번호 클릭이벤트
				const n = e.target.getAttribute("val");
				if(n == nowPageNum){
					return;
				}
				const repPageList = document.getElementsByClassName("repPageNum");
				for(let i=0; i<repPageList.length; i++){
						repPageList[i].style.fontWeight="normal";
						repPageList[i].style.fontSize="100%";
					}
				e.target.style.fontWeight="bold";
				e.target.style.fontSize="130%";
				getMrListByPageNum(n);
			});
		}

		if(totalPageNum > endPageNum){
			const nextSpan = document.createElement("span");
			nextSpan.setAttribute("val", endPageNum+1);
			nextSpan.className="repPageNum";
			nextSpan.innerHTML=">";
			replyPgaeNum.append(nextSpan);
			nextSpan.addEventListener("click", function(e) {
				getMrListByPageNum(e.target.getAttribute("val"));
			})
		}
	}
	
 function setReply(mrList){
	    const userId = checkM.item;
	    repCnt.innerHTML=totalRecordR;
	    reply.innerHTML="";

		mrList.forEach(function(mr, i) {
			const mrDiv = document.createElement("div");
			const ul = document.createElement("ul");
			const li1 = document.createElement("li");
			const li2 = document.createElement("li");
			li2.setAttribute("id", "rep_input"+mr.mr_no);
			const li3 = document.createElement("li");
			li2.style.display = "none";
			li3.style.display = "none";

			const hr = document.createElement("hr");

			let startNum = mr.mr_content.indexOf(" ");
			let toName = mr.mr_content.substring(0, startNum);
			let content = mr.mr_content.substring(startNum+1);
			
			let nodeContent="";
			if(mr.mr_step > 0){
				mrDiv.style.paddingLeft="30px";
				mrDiv.style.backgroundColor="#EFEFEF";
			}
			nodeContent += '<img src="rank/'+mr.rank_icon+'" height="25">'+mr.nickName+'<br>';
			nodeContent += '<p style="margin-left: 25px;"><span style="font-weight: bold;">'+toName+'&nbsp;</span>'+content+'</p>';
			if(mr.mr_file1 != "0"){  // 사진이없으면 0으로 db에 0으로 저장할예정
				nodeContent += '<p style="margin-left: 25px;"><img src="meetingFile/'+mr.mr_file1+'" height="100"></p>';
			}
			nodeContent += '<p class="repInfo" style="float: left;">'+mr.mr_regdate+'<p>';
			const repSpan = document.createElement("span");
			repSpan.innerHTML="답글달기";
			repSpan.className="btnRepSpan";
			const updateSpan = document.createElement("span");
			updateSpan.innerHTML="수정";
			updateSpan.className="btnRepSpan";
			const deleteSpan = document.createElement("span");
			deleteSpan.innerHTML="삭제";
			deleteSpan.className="btnRepSpan";

			li1.innerHTML=nodeContent;
			li1.append(repSpan);
			if(userId == mr.id){ // 로그인이되어있고 로그인되어있는 아이디랑 댓글의 아이디랑 동일하면 수정삭제버튼을 어펜드해준다
				li1.append(updateSpan,deleteSpan);
			}
			const repDiv = document.createElement("div");
			const rep_input = document.createElement("textarea");
			rep_input.setAttribute("rows", "5");
			rep_input.setAttribute("cols", "50");
			rep_input.setAttribute("maxlength", "100");
			rep_input.className="repTa";
			const txtCntStrong = document.createElement("strong");
			txtCntStrong.innerHTML=0;
			const txtMaxCntSpan = document.createElement("span");
			txtMaxCntSpan.innerHTML=" / 100자";
			const txtDiv = document.createElement("div");
			const btn_insert = document.createElement("button");
			btn_insert.innerHTML="등록";
			txtDiv.append(txtCntStrong, txtMaxCntSpan);
			repDiv.append(rep_input,txtDiv,btn_insert);
			li2.append(repDiv);

			const updateDiv = document.createElement("div");
			const updateContent = '<img src="rank/'+mr.rank_icon+'" height="25">'+mr.nickName+'<br>';
			const update_input = document.createElement("textarea");
			update_input.setAttribute("rows", "5");
			update_input.setAttribute("cols", "50");
			update_input.setAttribute("maxlength", "100");
			update_input.className="updateTa";
			update_input.innerHTML=content;
			const uptxtCntStrong = document.createElement("strong");
			uptxtCntStrong.innerHTML=0;
			const uptxtMaxCntSpan = document.createElement("span");
			uptxtMaxCntSpan.innerHTML=" / 100자";
			const uptxtDiv = document.createElement("div");
			
			uptxtDiv.append(uptxtCntStrong, uptxtMaxCntSpan);
			
			const btn_cancle = document.createElement("button");
			btn_cancle.setAttribute("oldContent", content);
			btn_cancle.className="btnCancle";
			btn_cancle.innerHTML="취소";
			const btn_update = document.createElement("button");
			btn_update.innerHTML="수정";
			updateDiv.innerHTML = updateContent;
			updateDiv.append(update_input,uptxtDiv,btn_cancle,btn_update);
			li3.append(updateDiv);

			// li1 댓글보여주는거 , li2 답글달기보여주는거, li3 수정하는거 보여주는거
			ul.append(li1,li2,li3);
			mrDiv.append(ul,hr);
			reply.append(mrDiv);

			rep_input.addEventListener("keyup", function(e) {// 답글달기에 글자수 세는 이벤트
				textCount(e.target,txtCntStrong);
			});
			rep_input.addEventListener("keydown", function(e) {
				textCount(e.target,txtCntStrong);
			});
			update_input.addEventListener("keyup", function(e) {// 수정하기에 글자수 세는 이벤트
				textCount(e.target,uptxtCntStrong);
			});
			update_input.addEventListener("keydown", function(e) {
				textCount(e.target,uptxtCntStrong);
			});

			repSpan.addEventListener("click", function(e) {
				repReply(li2); //답글달기 보여줘
			});
			updateSpan.addEventListener("click", function(e) {
				showUpdate(li1,li2,li3); // 수정하기 보여줘
			});
			deleteSpan.addEventListener("click", function(e) {
				deleteRep(mr.mr_no); // 삭제해줘
			});
			btn_insert.addEventListener("click", function(e) {
				repSub(rep_input,mr.mr_ref,mr.nickName); // 대댓글 달아줘
			});
			btn_cancle.addEventListener("click", function(e) {
				updateRepCancel(li1,li3); // 수정취소해줘
			});
			btn_update.addEventListener("click", function(e) {
				updateRep(li3,mr.mr_no,toName); // 수정해줘
			});
		});
		
 };	
 	const mr_content = document.getElementById("mr_content");
 	const mr_contentStrong = document.getElementById("mr_contentStrong");
 	const btnInsertReply = document.getElementById("btnInsertReply");
 	
	mr_content.addEventListener("keyup", function(e) {
		textCount(e.target,mr_contentStrong);
	});
	mr_content.addEventListener("keydown", function(e) {
		textCount(e.target,mr_contentStrong);
	});
	mr_content.addEventListener("click", function(e) {
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
			}
			return;
		}
	});
	btnInsertReply.addEventListener("click", function(e) {
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
			}
			return;
		}
		const content = mr_content.value;
		insertRep(content, 0,"");  // 그냥댓글등록일경우는 ref 0, 닉네임은 ""으로 준다
	});
	
	function getMrListByPageNum(num){  // 이놈만 호출하면 댓글구성됨
		$.ajax({
			url:"/detailMRep",
			type:"GET",
			data: {
				"m_no":m_no,
				"num":num
				},
			success: function(map){
				nowPageNum = num;   //나우페이지넘은 현재페이지가 몇인지 알기위해 선언한거
				totalRecordR = map.totalRecordR;
				totalPageNum = map.totalPageNum;
				console.log(nowPageNum);
				console.log(totalRecordR);
				console.log(totalPageNum);
				setPageNum();     // 리스트를 받아오면 댓글페이징,댓글리스트 처리를 이곳에서 호출한다
				setReply(map.mrList);
			},
			error: function(){
				alert("에러발생");
			}
		});
	}

	function textCount(textArea, countStrong){  // 글자수세는 함수
		const txtCnt = textArea.value.length;
		if(txtCnt > 100){
			txtCnt = 100;
		}
		countStrong.innerHTML = txtCnt;
	}

	function repReply(li2){   // 답글달기 눌렀을때 작동
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
			}
			return;
		}
		li2.querySelector("strong").innerHTML=0; // 답글달기가 열리면 텍스트카운트를 0으로 초기화시킴
		li2.querySelector("textarea").focus();
		li2.style.display="inline";
	}

	function showUpdate(li1,li2,li3){   // 수정하기 눌렀을때 작동
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
			}
			return;
		}
		const oldContentCnt = li3.querySelector(".btnCancle").getAttribute("oldContent").length;
		li1.style.display="none";
		li2.style.display="none";
		li2.querySelector(".repTa").value="";
		li3.querySelector("strong").innerHTML=oldContentCnt;
		li3.style.display="inline";
		li3.querySelector("textarea").focus();
	}

	function updateRepCancel(li1,li3){   // 수정화면에서 취소 눌렀을때 작동
		li3.style.display="none";
		li1.style.display="inline";
		const oldContent = li3.querySelector(".btnCancle").getAttribute("oldContent");
		li3.querySelector(".updateTa").value=oldContent;
	}

	
	function repSub(rep_input, mr_ref,nickName){  // 답글달기의 등록버튼을 눌렀을때 작동
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
			}
			return;
		}
		const content =rep_input.value;
		insertRep(content,mr_ref,nickName);  // 댓글의 댓글등록함수
	}

	function insertRep(content,mr_ref,nickName){ //댓글등록하는 함수
		if(content.trim() == ""){
			alert("입력된 내용이 없습니다.");
			return;
		}
		
		$.ajax({
			url:"/user/insertMeetingRep",
			type:"post",
			data: {
				"m_no":m_no,
				"pmr_ref":mr_ref,
				"content":content,
				"nickName":nickName
			},
			success: function(response){
				if(response.code == "200"){
					alert("등록에 성공하였습니다");
					mr_content.value = "";
					mr_contentStrong.innerHTML=0;
					getMrListByPageNum(nowPageNum);
				}
				else{
					alert("등록에 실패하였습니다.");
				}
			},
			error: function(){
				alert("에러발생");
				}
		})
	}

	function updateRep(li3,mr_no,toName){
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
			}
			return;
		}
		const content = $(li3).find(".updateTa").val();
		if(content.trim() == ""){
			alert("입력된 내용이 없습니다");
			return;
		}
		console.log("콘텐트"+content);
		console.log(""+toName);
		$.ajax({
			url:"/user/updateMeetingRep",
			type:"post",
			data: {
				"mr_no":mr_no,
				"content":content,
				"toName":toName
			},
			success: function(response){
				if(response.code == "200"){
					alert("수정에 성공하였습니다");
					getMrListByPageNum(nowPageNum);
				}
				else{
					alert("수정에 실패하였습니다.");
				}
			},
			error: function(){
				alert("에러발생");
				}
		})
		
	}

	function deleteRep(mr_no){
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
			}
			return;
		}
		const delCheck = confirm("정말로 삭제하시겠습니까?");
			if(!delCheck){
				return;
			}

		$.ajax({
			url:"/user/deleteMeetingRep",
			type:"post",
			data: {
				"m_no":m_no,
				"mr_no":mr_no
			},
			success: function(response){
				if(response.code == "200"){
					location.reload(true);
				}
				else{
					alert("삭제에 실패하였습니다.");
				}
			},
			error: function(){
				alert("에러발생");
				}
		})
	}
	
	getMrListByPageNum(nowPageNum); // 댓글이닛로드
/////////////////////////////////////////////////////////////////////////////////// 맵표시
	const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.53814589110931, 126.98135334065803), // 지도의 중심좌표
        level: 7 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	const map = new kakao.maps.Map(mapContainer, mapOption); 
	const mapTypeControl = new kakao.maps.MapTypeControl();
	const zoomControl = new kakao.maps.ZoomControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	const startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
    startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
    startOption = { 
    offset: new kakao.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
    };
    //출발 마커 이미지를 생성합니다
    const startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);

    const arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
    arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
    arriveOption = { 
    offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
    };
    //도착 마커 이미지를 생성합니다
    const arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);

    const startMarker = new kakao.maps.Marker({image:startImage}); //출발마커담을 변수
    const arriveMarker = new kakao.maps.Marker({image:arriveImage});//도칙마커담을 변수
    const coursePolyline = new kakao.maps.Polyline({
       strokeWeight: 5,
        strokeColor: '#FF2400',
        strokeOpacity: 0.9,
        strokeStyle: 'solid'
       });//경로라인담을 변수
/////////////////출발도착마커이미지 생성 끝
	const meetingSrc = '/insertMeetingImg/meetingSpot.png', // 미팅 마커이미지의 주소입니다    
	meetingSize = new kakao.maps.Size(40, 40); // 미팅 마커이미지의 크기입니다 
	
	//미팅 마커 이미지를 생성합니다
	const meetingImage = new kakao.maps.MarkerImage(meetingSrc, meetingSize);
	const meetingMarker = new kakao.maps.Marker({image:meetingImage}); 
	const meetingInfowindow = new kakao.maps.InfoWindow({removable:true,zindex:1});
	
	if(${c.c_no} != 0){
		startMarker.setPosition(new kakao.maps.LatLng(${c.c_s_latitude}, ${c.c_s_longitude}));
		arriveMarker.setPosition(new kakao.maps.LatLng(${c.c_e_latitude}, ${c.c_e_longitude}));
		coursePolyline.setPath(${c.c_line});
		startMarker.setMap(map);
		arriveMarker.setMap(map);
		coursePolyline.setMap(map);
		map.setLevel(${c.c_mapLevel});
		
	}	
	map.setCenter(new kakao.maps.LatLng(${mt.m_latitude}, ${mt.m_longitude}));
	meetingMarker.setPosition(new kakao.maps.LatLng(${mt.m_latitude}, ${mt.m_longitude}));
	meetingMarker.setMap(map);
	meetingInfowindow.setContent("<div>미팅장소</div>"); // 나중에 html꾸며서 넣기
    meetingInfowindow.open(map, meetingMarker);
	
	/////////////////////////////////////////////////////////////////////////////////// 맵표시 끝

	
};
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
			<h3>댓글&nbsp;<span id="repCnt"></span></h3>
			<hr style="margin: 10px 0 10px;">
			<!-- 댓글출력 -->
			<div id="reply">
			</div>
			<div id="replyPgaeNum" style="text-align: center;">
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
			<div>
			댓글등록<br>
			<form id="comment">
				<!--  <input type="hidden" name="rank_icon" id="rank_icon">
				<input type="hidden" name="nickname" id="nickname">
				<input type="hidden" name="regdate" id="regdate">-->
				<textarea rows="10" cols="80" name="mr_content" id="mr_content" maxlength="100"></textarea>
				<button id="btnInsertReply" type="button"><img src="/meetingImg/add.png" id="btnImg"></button>
				<div><strong id="mr_contentStrong">0</strong> / 100자</div>
				<input type="file" name="mr_file1" id="mr_file1">
				
			</form>
			
			
		 </div>
		</div>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
</html>