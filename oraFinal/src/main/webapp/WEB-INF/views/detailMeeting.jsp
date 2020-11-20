<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/style.css">
 	<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
	<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>

	<style>
		/* 개별 */
		#reply { /* 댓글출력 */
			padding-bottom: 3px;
		}
		#comment { /* 댓글입력 */
			display: block;
			position:relative;
		}
		#btnInsertReply { /* 댓글등록버튼 */
			position:absolute;
			color: white;
			padding: 6px 9px;
			background-color: #c8572d;
			float: right;
			font-size: 13px;
			border: none;
			bottom: 30px;
			right: 10px;
			cursor: pointer;
		}
		textarea { /* 글내용입력 */
		     display: block;
		}
		#contents { /* 게시판 인덱스 제외 전체 */
			border: 1px solid #D5D5D5;
			padding: 60px;
			margin: 50px 0 100px;
		}
		.repInfo { /* 댓글등록날짜 */
			margin-left: 25px;
			font-size: 13px;
		}
		/* 삭제해도 되는지 물어보기 */
		/* .repInput-noshow{
			display: none;
		}
		.repInput-show{
			display: inline;
		} */
		.repPageNum{ /* 댓글창 페이지번호 */
			margin: 0 5px 0 5px;
			cursor: pointer;
		}
		.btnRepSpan { /* 대댓글 등록수정삭제 버튼 */
			cursor: pointer;
			margin-left: 3px;
			text-decoration: underline;
		}
		.btn { /* 게시글 수정삭제 버튼 */
			color: white;
			padding: 8px 12px;
			margin: 20px 2px;
			background-color: #88BEA6;
			display: inline-block;
			font-size: 15px;
			border: none;
			cursor: pointer;
		}
		.btnDiv {
			text-align: center;
		}
		#mtInfoAll { /* 미팅 장소,날짜,인원 모은 div */
			display: flex;
		}
		#mtInfoAll img { /* 미팅 장소,날짜,인원 아이콘 */
			width: 40px;
			margin: 10px;
		}
		#mtInfoAll .mtInfo { /* 미팅 장소,날짜,인원 각각의 div */
			width: 40%;
			border: 1px #D5D5D5 solid;
			border-radius: 10px;
			margin: 20px;
			padding: 10px;
			text-align: center;
		}
		.mfPhoto { /* 게시글 개별 사진 */
			height: 300px;
		}
		.pointerDiv { /* 게시글 사진 버튼 div */
			position: absolute;
			top: 100px;
			width: 880px;
		}
		/* 사진 왼쪽 클릭버튼 */
		/* #btnLeft { 
			width: 100px;
			position: relative;
			cursor: pointer;
			z-index: 1;
		} */
		/* 사진 오른쪽 클릭버튼 */ 
		/* #btnRight { 
			width: 100px;
			position: relative;
			cursor: pointer;
			left: 680px;
			z-index: 1;
		} */
		#m_content { /* 글출력창 */
			width: 100%; height: 400px; border: none; margin: 30px 0 0; padding: 10px;
		}
		#repImg, #repStr, #repCnt { /* 댓글이미지, 댓글수 */
			vertical-align: middle;
		}
		#repImg {
			margin-bottom: 2px; 
			width: 20px;
		}
		.map_wrap { 
			position: relative; 
			width: 100%; 
			height: 450px; 
			font-size: 80%;
		}
		li {
			list-style: none;
		}
		.attendPerson {
			width: 30px;
		}
		.nav-item .nav-link { /* nava 로그인 */
			font-size: 15px;
		}
		textarea:focus { outline: none; }
	</style>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="slick/slick.min.js"></script>
	<script src="/js/loginCheck.js"></script>
	<script type="text/javascript">
window.onload = function(){
	$('#btnDel').click(function(){
		alert('게시글이 삭제되었습니다.');
	});

	$(document).ready(function(){
		$('.mfPhotoDiv').slick({
			dots: true,
			infinite: true,
			speed: 300,
			slidesToShow: 1,
			centerMode: true,
			variableWidth: true
		});
	});

///////////////////////////////////////////////////
	const checkM = checkLogin(); // 로그인이 되어있는 상태인지 체크한다
	console.log(checkM);
	
	const m_no = ${m_no}; //현재글번호
	let totalRecordR = ${totalRecordR};  // 전체 레코드수
	let totalPageNum = ${totalPageNum}; // 전체 페이지번호수
	const pageSizeR = ${pageSizeR}; // 댓글페이징번호 보여주는수
	let nowPageNum = 1; // 현재페이지번호를 담을변수

	const repCnt = document.getElementById("repCnt");
	const reply = document.getElementById("reply");
	const replyPgaeNum = document.getElementById("replyPgaeNum");

	const repMaxCnt = 300; // 댓글 최대글자수 이것만 변경하면 댓글글자수제한 변경됨
	const repMaxCntStr = " / "+repMaxCnt; // 댓글최대글자수 스트링
	
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
	
 function setReply(mrList){  // 댓글동적노드 생성하는 함수
	    const userId = checkM.item.id;
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
			let toName = mr.mr_content.substring(0, startNum);  // @닉네임 분리
			let content = mr.mr_content.substring(startNum+1);  // @닉네임에서 글내용만 분리
			
			let li1Content="";
			if(mr.mr_step > 0){
				mrDiv.style.paddingLeft="30px";
				mrDiv.style.backgroundColor="#EFEFEF";
			}
			li1Content += '<img src="rank/'+mr.rank_icon+'" height="25">'+mr.nickName;
	//		if(userId == mr.id){ // 내가쓴 댓글이면 내댓글이라 표현  // 이건 추후에 디자인다시할때 if문 하나로 밑에있는 if문이랑 합쳐서 처리할거임
	//			li1Content +=' (내 댓글)';
	//		}
			li1Content += '<br><p style="margin-left: 25px;"><span style="font-weight: bold;">'+toName+'&nbsp;</span>'+content+'</p>';
			if(mr.mr_file1 != "0"){  // 사진이없으면 0으로 db에 0으로 저장할예정
				li1Content += '<p style="margin-left: 25px;"><img src="meetingFile/'+mr.mr_file1+'" height="100"></p>';
			}
			li1Content += '<p class="repInfo" style="float: left;">'+mr.mr_regdate+'<p>';
			const repSpan = document.createElement("span");
			repSpan.innerHTML="답글달기";
			repSpan.className="btnRepSpan";
			const updateSpan = document.createElement("span");
			updateSpan.innerHTML="수정";
			updateSpan.className="btnRepSpan";
			const deleteSpan = document.createElement("span");
			deleteSpan.innerHTML="삭제";
			deleteSpan.className="btnRepSpan";

			li1.innerHTML=li1Content;
			li1.append(repSpan);
			if(userId == mr.id){ // 로그인이되어있고 로그인되어있는 아이디랑 댓글의 아이디랑 동일하면 수정삭제버튼을 어펜드해준다
				li1.append(updateSpan,deleteSpan);
			}
			const repDiv = document.createElement("div");
			const rep_input = document.createElement("textarea");
			rep_input.setAttribute("rows", "10");
			rep_input.setAttribute("cols", "80");
			rep_input.setAttribute("maxlength", repMaxCnt);
			rep_input.className="repTa";
			
			const txtMaxCntSpan = document.createElement("span");
			const txtDiv = document.createElement("div");
			const btn_insert = document.createElement("button");
			btn_insert.innerHTML="등록";
			const btn_insertCancel = document.createElement("button");
			btn_insertCancel.className="btnCancel";
			btn_insertCancel.innerHTML="취소";
			txtDiv.append(txtMaxCntSpan);
			repDiv.append(rep_input,txtDiv,btn_insertCancel,btn_insert);
			li2.append(repDiv);

			const updateDiv = document.createElement("div");
			const updateContent = '<img src="rank/'+mr.rank_icon+'" height="25">'+mr.nickName+'<br>';
			const update_input = document.createElement("textarea");
			update_input.setAttribute("rows", "10");
			update_input.setAttribute("cols", "80");
			update_input.setAttribute("maxlength", repMaxCnt);
			update_input.className="updateTa";
			update_input.innerHTML=content;  // 글내용만 넣는다
			
			const uptxtMaxCntSpan = document.createElement("span");
			const uptxtDiv = document.createElement("div");
			
			uptxtDiv.append(uptxtMaxCntSpan);
			
			const btn_updateCancel = document.createElement("button");
			btn_updateCancel.setAttribute("oldContent", content);
			btn_updateCancel.className="btnCancel";
			btn_updateCancel.innerHTML="취소";
			const btn_update = document.createElement("button");
			btn_update.innerHTML="수정";
			updateDiv.innerHTML = updateContent;
			updateDiv.append(update_input,uptxtDiv,btn_updateCancel,btn_update);
			li3.append(updateDiv);

			// li1 댓글보여주는거 , li2 답글달기보여주는거, li3 수정하는거 보여주는거
			ul.append(li1,li2,li3);
			mrDiv.append(ul,hr);
			reply.append(mrDiv);

			rep_input.addEventListener("keyup", function(e) {// 답글달기에 글자수 세는 이벤트
				textCount(e.target,txtMaxCntSpan);
			});
			rep_input.addEventListener("keydown", function(e) {
				textCount(e.target,txtMaxCntSpan);
			});
			update_input.addEventListener("keyup", function(e) {// 수정하기에 글자수 세는 이벤트
				textCount(e.target,uptxtMaxCntSpan);
			});
			update_input.addEventListener("keydown", function(e) {
				textCount(e.target,uptxtMaxCntSpan);
			});

			repSpan.addEventListener("click", function(e) {
				repReply(li1,li2,li3); //답글달기 보여줘
			});
			updateSpan.addEventListener("click", function(e) {
				showUpdate(li1,li2,li3); // 수정하기 보여줘
			});
			deleteSpan.addEventListener("click", function(e) {
				deleteRep(mr.mr_no); // 삭제해줘
			});
			btn_insert.addEventListener("click", function(e) {
				insertRepSub(rep_input,mr.mr_ref,mr.nickName); // 대댓글 달아줘
			});
			btn_insertCancel.addEventListener("click", function(e) {
				insertRepSubCancel(li2);   //대댓글다는거 취소해줘
			});
			btn_updateCancel.addEventListener("click", function(e) {
				updateRepCancel(li1,li3); // 수정취소해줘
			});
			btn_update.addEventListener("click", function(e) {
				updateRep(li3,mr.mr_no,toName); // 수정해줘
			});
		});
		
 };	
 	const mr_content = document.getElementById("mr_content");
 	const mr_contentSpan = document.getElementById("mr_contentSpan");
 	const btnInsertReply = document.getElementById("btnInsertReply");
 	
	mr_content.addEventListener("keyup", function(e) {
		textCount(e.target,mr_contentSpan);
	});
	mr_content.addEventListener("keydown", function(e) {
		textCount(e.target,mr_contentSpan);
	});
	mr_content.addEventListener("click", function(e) {
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
				return;
			}
			return;
		}
	});
	btnInsertReply.addEventListener("click", function(e) {
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
				return;
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

	function textCount(textArea, txtMaxCntSpan){  // 글자수세는 함수
		const txtCnt = textArea.value.length;
		if(txtCnt > repMaxCnt){
			txtCnt = repMaxCnt;
		}
		txtMaxCntSpan.innerHTML = txtCnt+repMaxCntStr;
	}

	let li1Obj = null; // 댓글객체  담을 변수
	let li2Obj = null; // 댓글의 등록객체 담을 변수
	let li3Obj = null; // 댓글의 수정객체 담을 변수

	function repReply(li1,li2,li3){   // 답글달기 눌렀을때 작동
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
				return;
			}
			return;
		}

		if(li2Obj){
			if(li2 == li2Obj){  // 열려있는 답글등록이랑 같으면 리턴
				return;
			}
			else{
				if(insertRepSubCancel(li2Obj)){  // 열려있는 답글이랑 다른답글하기를 눌렀을때 
					return;
				}
			}
		}
		if(li3Obj){
			if(updateRepCancel(li1Obj,li3Obj)){  // 수정하기가 열려있는 상태에서 답글하기를 눌렀을때
				return;
			}
		}
		
		li2.querySelector("span").innerHTML=0+repMaxCntStr; // 답글달기가 열리면 텍스트카운트를 0으로 초기화시킴
		li2.querySelector("textarea").focus();
		li2.style.display="inline";

		li1Obj = li1;
		li2Obj = li2;
		li3Obj = null;
	}

	function insertRepSubCancel(li2){ // 답글달기 취소눌렀을때 작동
		const repSubTa = li2.querySelector("textarea");
		if(repSubTa.value.length > 0){
			const cfm = confirm("답글달기를 취소하시겠습니까?");
			if(!cfm){
				return true;
			}
		}
		repSubTa.value = "";
		li2.style.display="none";
		
		li1Obj = null;
		li2Obj = null;
		li3Obj = null;
		return false;
	}

	function showUpdate(li1,li2,li3){   // 수정하기 눌렀을때 작동
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
				return;
			}
			return;
		}

		if(li2Obj){
			if(insertRepSubCancel(li2Obj)){  // 답글하기가 열려있는 상태에서 수정하기를 눌렀을떄
				return;
			}
		}
		if(li3Obj){
			if(updateRepCancel(li1Obj,li3Obj)){  // 수정하기가 열려있을때 다른 수정하기를 눌렀을때
				return;
			}
		}
		const updateTa = li3.querySelector(".updateTa");
		const oldContent = li3.querySelector(".btnCancel").getAttribute("oldContent");
		
		li1.style.display="none";
		
		li2.style.display="none";
		li2.querySelector(".repTa").value="";
		
		li3.querySelector("span").innerHTML=oldContent.length+repMaxCntStr;
		li3.style.display="inline";
		updateTa.focus();

		li1Obj = li1;
		li2Obj = null;
		li3Obj = li3;
	}

	function updateRepCancel(li1,li3){   // 수정화면에서 취소 눌렀을때 작동
		const updateTa = li3.querySelector(".updateTa");
		const oldContent = li3.querySelector(".btnCancel").getAttribute("oldContent");
		if(updateTa.value != oldContent){
			const cfm = confirm("수정하기를 취소하시겠습니까?");
			if(!cfm){
				return true;
			}
		}
		updateTa.value = oldContent;
		li3.style.display="none";
		li1.style.display="inline";
		li1Obj = null;
		li2Obj = null;
		li3Obj = null;
		return false;

	}

	
	function insertRepSub(rep_input, mr_ref,nickName){  // 답글달기의 등록버튼을 눌렀을때 작동
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
				return;
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
					li1Obj = null;
					li2Obj = null;
					li3Obj = null;
					mr_content.value = "";
					mr_contentSpan.innerHTML="";
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
				return;
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
					li1Obj = null;
					li2Obj = null;
					li3Obj = null;
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
				return;
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

///////////////-------------------------------------- 미팅피플 구현
	const mPeopleNum = document.getElementById("mPeopleNum");  // 참가인원숫자를 표시할 스판노드
	const allPeopleNum = mPeopleNum.getAttribute("allPeopleNum");  // 모집인원수를 가져오기위한것
	let nowMpeopleNum = 0;   // 참가인원을 담기위한 변수
	let mPeopleId = []; // 참가인원 id를 담기위한 변수  한번 참가신청하면 두번이상 신청 못하게 하기위함임
	
	const attendRiding = document.getElementById("attendRiding"); // 참가버튼
	const mPeople = document.getElementById("mPeople");  // 참가인원을 만들어서 추가할 ul노드
	
	attendRiding.addEventListener("click", function(e) {
		if(checkM.code != "200"){
			const cfm = confirm("로그인이 필요합니다 이동하시겠습니까?");
			if(cfm){
				window.location = "/login";
				return;
			}
			return;
		}
		const mId = checkM.item.id;
		const attendCfm = confirm("라이딩에 참가하시겠습니까?");
		if(!attendCfm){
			return;
		}

		for(let i=0; i<mPeopleId.length; i++){
			if(mPeopleId[i] == mId){
				alert("이미 참가하셨습니다.");
				return;
			}
		}

		if(nowMpeopleNum >= allPeopleNum){
			alert("참가인원이 꽉찼어요.. 댓글에 요청해보세요!");
			return;
		}
		
		$.ajax({
			url: "/user/attendMpeople",
			type: "POST",
			data: {"m_no":m_no,"id":mId},
			success: function(re){
				if(re == "1"){
					alert("참가완료! 즐거운 라이딩되세요!");
					setMpeople();
				}
				else{
					alert("참가실패.. 다시한번 시도해보세요");
				}

			},
			error:function(){
				alert("에러발생");
			}
		})
	});

	function deleteMpeople(id){
		const cfm = confirm("정말 탈주하시겠습니까?");
		if(!cfm){
			return;
		}
		
		$.ajax({
			url:"/user/deleteMpeople",
			type: "POST",
			data: {"m_no":m_no,"id":id},
			success: function(re){
				if(re == "1"){
					alert("탈주완료.. 다음에 같이가요!");
					setMpeople();
				}
				else{
					alert("탈주실패! 다시한번 시도해보세요");
				}
			},
			error: function(){
				alert("에러발생");
			}
		})
	}

	function setMpeople(){
		const mId = checkM.item.id;
		$.ajax({
			url: "/mPeopleList",
			type: "GET",
			data:{"m_no":m_no} ,
			success: function(list){
				mPeople.innerHTML = "";
				nowMpeopleNum = list.length; // 현재 참가인원을 담음
				mPeopleId = [];  // 아이디담을 변수 초기화
				
				list.forEach(function(p, i) {
					mPeopleId.push(p.id);
					const li = document.createElement("li");
					const content = '<img class="attendPerson" src="/rank/'+p.rank_icon+'">'+' '+p.nickName;
					/* +"("+p.mp_regdate+")" */
					li.innerHTML = content;
					if(mId == p.id){
						const delBtn = document.createElement("button");
						delBtn.className = "btn";
						delBtn.innerHTML = "탈주";
						li.append(delBtn);
						delBtn.addEventListener("click", function(e) {
							deleteMpeople(p.id);
						});
					}
					mPeople.append(li);
				})

				mPeopleNum.innerHTML = nowMpeopleNum+"/"+allPeopleNum;
				
			},
			error: function(){
				alert("에러발생");
			}
		})
	}

	setMpeople(); // 최초 한번실행
//----------------------------------------------미팅피플 끝

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
    const arriveMarker = new kakao.maps.Marker({image:arriveImage});//도착마커담을 변수
    const coursePolyline = new kakao.maps.Polyline({
       strokeWeight: 5,
        strokeColor: '#FF2400',
        strokeOpacity: 0.9,
        strokeStyle: 'solid'
       });//경로라인담을 변수
/////////////////출발도착마커이미지 생성 끝
	const meetingSrc = '/searchCourseImg/mtLoc.png', // 미팅 마커이미지의 주소입니다    
	meetingSize = new kakao.maps.Size(40, 40); // 미팅 마커이미지의 크기입니다 
	
	//미팅 마커 이미지를 생성합니다
	const meetingImage = new kakao.maps.MarkerImage(meetingSrc, meetingSize);
	const meetingMarker = new kakao.maps.Marker({image:meetingImage}); 
	const meetingInfowindow = new kakao.maps.InfoWindow({removable:true,zindex:1});

	const c = ${cJson};
	
	const courseBounds = new kakao.maps.LatLngBounds();  // 맵바운드 설정객체

	if(c.c_no != 0){
		startMarker.setPosition(new kakao.maps.LatLng(c.c_s_latitude, c.c_s_longitude));
		arriveMarker.setPosition(new kakao.maps.LatLng(c.c_e_latitude, c.c_e_longitude));
		const cLineObj = JSON.parse(c.c_line);
		const courseLine = eval(cLineObj.courseLine);
		coursePolyline.setPath(courseLine);
		courseLine.forEach(function(c, i) {
			courseBounds.extend(c);
		})
		startMarker.setMap(map);
		arriveMarker.setMap(map);
		coursePolyline.setMap(map);
		
	}	
	const meetingLatLon = new kakao.maps.LatLng(${mt.m_latitude}, ${mt.m_longitude});
	meetingMarker.setPosition(meetingLatLon);
	meetingMarker.setMap(map);
	// detail window 표시 x
	//meetingInfowindow.setContent("<div>미팅장소</div>"); // 나중에 html꾸며서 넣기
    //meetingInfowindow.open(map, meetingMarker);

    courseBounds.extend(meetingLatLon);
    map.setBounds(courseBounds);
	/////////////////////////////////////////////////////////////////////////////////// 맵표시 끝
	const mf = ${mfJson};
	console.log(mf);
	let imgStr = '';
	mf.forEach(function(mtPhoto, idx) {
		imgStr += '<img class="mfPhoto" src="/'+mtPhoto.mf_path+'/'+mtPhoto.mf_savename+'" attr='+idx+'>';
	})
	console.log(imgStr);
	document.getElementById('mfPhotoDiv').innerHTML = imgStr;

};
	</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a style="font-family: 나눔스퀘어라운드;font-size: 30px;" class="navbar-brand" href="/mainPage">
				<span style="font-weight: bold;">
					<font color="#45A3F5">오</font>
					<font color="#bae4f0">늘</font>
					<font color="#88bea6">의</font>
					<font color="#eccb6a">라</font>
					<font color="#d0a183">이</font>
					<font color="#c8572d">딩
				</span>
			</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
               <span class="oi oi-menu"></span> Menu
            </button>
         
			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<c:choose>
						<c:when test="${m == null }">
							<li class="nav-item"><a style="font-size: 15px;" href="/login" class="nav-link">로그인</a></li>
							<li class="nav-item"><a style="font-size: 15px;" href="/signUp" class="nav-link">회원가입</a></li>
						</c:when>
						<c:when test="${m != null }">
							<li class="nav-item"><a style="font-size: 15px;" class="nav-link">${m.nickName } 라이더님</a></li>
							<li class="nav-item"><a style="font-size: 15px;" href="/logout" class="nav-link">로그아웃</a></li>&nbsp;&nbsp;
							<li class="nav-item"><a style="font-size: 15px;" href="/myPage?id=${m.id}" class="nav-link">마이페이지</a></li>
						</c:when>
					</c:choose>
				</ul>
			</div> 

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
					<li class="nav-item"><a href="/listNotice" class="nav-link">오늘의 라이딩</a></li>
					<li class="nav-item"><a href="/searchCourse" class="nav-link">라이딩 코스</a></li>
					<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
					<li class="nav-item active"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
					<li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
				</ul>
			</div>
		</div>
    </nav>
    <!-- END nav -->	
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/resources/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-0 text-center">
					<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a></span><span class="mr-2"><a href="/listMeeting">번개 라이딩 <i class="fa fa-chevron-right"></i></a></span> <span>번개 라이딩 상세 <i class="fa fa-chevron-right"></i></span></p>
					<h1 class="mb-3 bread">번개 라이딩 상세</h1>
				</div>
			</div>
		</div>
    </section>
    
    <!-- 글번호, 제목 -->
    <section class="ftco-section ftco-agent" style="padding-bottom: 30px;">
    	<div class="container">
    		<div class="row justify-content-center pb-5">
          		<div class="col-md-12 heading-section text-center ftco-animate">
		          	<span class="subheading">${mt.m_no }</span>
					<a href="detailMeeting?m_no=${mt.m_no }"><h2 class="mb-4">${mt.m_title }</h2></a>
          		</div>
        	</div>
<!--     	</div>
    </section>  -->
    
    <!-- 전체 섹션 (글제목 제외) -->
<!--     <section class="ftco-section" >
      <div class="container"> -->
       
  	 <!-- 닉네임 코스네임 조회수 작성자 -->
				<img src="rank/${mt.rank_icon }" height="25" style="float: left;">
				
				<div>
					<p>${mt.nickName }</p>
					<p>${mt.m_regdate }</p>
					<p>조회수 ${mt.m_hit }</p>
				</div>

				<hr style="margin: 10px 0 10px;">
				<div style="padding: 3px; font-size: 20px;">코스 : ${mt.c_name }</div>
				<hr style="margin: 10px 0 10px;">
			
			
			
			<div class="map_wrap">
				<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
			</div>
			
			<div id="mtInfoAll">
				<div class="mtInfo"><img src="meetingImg/meetingLoc.png"><br>${mt.m_locname }</div>
				<div class="mtInfo"><img src="meetingImg/meetingTime.png"><br>${mt.m_time }</div>
				<div class="mtInfo"><img src="meetingImg/meetingNum.png"><br>
					<button class="btn" id="attendRiding">참가</button>
					<span id="mPeopleNum" allPeopleNum="${mt.m_numpeople }" >${mt.m_numpeople }</span> 명
				</div>
			</div>
			
			<div><ul id="mPeople"></ul></div>
			<br>
			
			<textarea class="about-author d-flex p-4 bg-light" id="m_content" readonly="readonly">${mt.m_content }</textarea>
			
			<c:if test="${mf.size()>0 }">
				<div class="photo_canvas">
					<div class="mfPhotoDiv" id="mfPhotoDiv"></div>
				</div>
			</c:if>
			
			<!-- 수정,삭제 버튼 -->
			<c:if test="${m.id==mt.id }">
			<div id="btnDiv">
				<a href="/user/updateMeeting?m_no=${mt.m_no }&c_no=${mt.c_no}" class="btn" id="btnEdit">수정</a>
				<a href="deleteMeeting?m_no=${mt.m_no }" class="btn" id="btnDel" style="background-color: #ECCB6A">삭제</a>
			</div>
			</c:if>
			
			<!-- 댓글 -->
			<img id="repImg" src="meetingImg/speech.png" style="display: inline; size: 20px; padding-right: 5px;">
			<h3 id="repStr" style="display: inline;">댓글<span id="repCnt" style="display: inline; padding-left: 10px;"></span></h3>
			<hr style="margin: 10px 0 10px;">
			
			<!-- 댓글출력 -->
			<div id="reply"></div>
			<div id="replyPgaeNum" style="text-align: center;"></div>
			
			<br>
				<div>
					댓글등록<br>
					<form id="comment">
						<textarea rows="10" cols="80" name="mr_content" id="mr_content" maxlength="300"></textarea>
						<button id="btnInsertReply" type="button">등록</button>
						<div><span id="mr_contentSpan"></span></div>
						<div style="display: none;"><input type="file" name="mr_file1" id="mr_file1"></div>
						
					</form>
				</div>

       </div> <!-- container -->
    </section>


	
	<!-- footer시작 -->
    <footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Ecoverde</h2>
              <p>Far far away, behind the word mountains, far from the countries.</p>
              <ul class="ftco-footer-social list-unstyled mt-5">
                <li class="ftco-animate"><a href="#"><span class="fa fa-twitter"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="fa fa-facebook"></span></a></li>
                <li class="ftco-animate"><a href="#"><span class="fa fa-instagram"></span></a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">Community</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Search Properties</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>For Agents</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Reviews</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>FAQs</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">About Us</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Our Story</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Meet the team</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Careers</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
             <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Company</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>About Us</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Press</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Contact</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>Careers</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Have a Questions?</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon fa fa-map"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
	                <li><a href="#"><span class="icon fa fa-phone"></span><span class="text">+2 392 3929 210</span></a></li>
	                <li><a href="#"><span class="icon fa fa-envelope pr-4"></span><span class="text">info@yourdomain.com</span></a></li>
	              </ul>
	            </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">
	
            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>
    
	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


	<script src="/resources/js/jquery.min.js"></script>
	<script src="/resources/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="/resources/js/popper.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/jquery.easing.1.3.js"></script>
	<script src="/resources/js/jquery.waypoints.min.js"></script>
	<script src="/resources/js/jquery.stellar.min.js"></script>
	<script src="/resources/js/owl.carousel.min.js"></script>
	<script src="/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="/resources/js/jquery.animateNumber.min.js"></script>
	<script src="/resources/js/scrollax.min.js"></script>
	<script src="/resources/js/main.js"></script>
    
</body>
</html>