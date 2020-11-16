<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
section {
	margin: 0 auto;
	width: 1000px;
	height: auto;
	text-align: left;
}
.button {
	height: 30px;
	float: right;
}
.btnContainer {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
}
.replyNicknameContainer {
	display: flex;
	flex-direction: row;
	background-color: #93BFAE;
	border-radius: 5px;
}
.regdate {
	flex-grow: 1;
	flex-basis: 90%;
	text-align: right;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
var querystring = location.search;		// querystring 가져오기 ex) r_no=1
var n = querystring.indexOf("=");		// value를 가져오기위한 =의 index알아오기 ex) 4
var r_no = querystring.substring(n+1);	// 게시판번호 저장 변수 ex) 1
let login_id = "${m.id}";				// 로그인 안했을 때는 'empty string'
var $replyTextArea = $("<textarea></textarea>").attr({rows: 3, cols: 55}).css("width", "100%");	// 대댓글을 위한 textarea 전역변수
$(document).ready(function(){
	detailReviewReply();	// 댓글 목록 ajax으로 가져오는 함수	
	// 본문 댓글을 위한 입력창 만들기
	let $div1 = $("<div></div>").addClass("textareaContainer");		// 자식인 textarea 찾기위해 클래스 지정
	let $textarea = $("<textarea></textarea>").attr({rows: 3, cols: 65});
	$div1.append($textarea);
	let $div2 = $("<div></div>").addClass("btnContainer");			// css적용을 위한 클래스
	let $button = $("<button></button>").addClass("sendReply").text("등록");
	$div2.append($button);
	$("#replyToBoardArea").append($div1, $div2).attr("rr_ref", 0);	// rr_ref가 0이면 본문 댓글
	
	$(document).on("click", ".btnReply", function(event){	// 댓글 아이콘 입력시 댓글 입력창 동적생성 이벤트
		$(".div_c3_c2").empty();		// 모든 대댓글 입력창,등록버튼 비우기
		let $div1 = $("<div></div>").css("margin-left", "25px").addClass("textareaContainer").append($replyTextArea);	// 자식인 textarea 찾기위해 클래스 지정
		let $div2 = $("<div></div>").addClass("btnContainer");		// css적용을 위한 클래스
		let $btn = $("<button></button>").addClass("sendReply").text("등록");		// 클릭 이벤트 적용을 위한 클래스

		$div2.append($btn);
		$(this).parent().siblings(".div_c3_c2").append($div1, $div2);
	});
	
	$(document).on("click", ".sendReply", function(event){		// 댓글 내용을 추출하여 insert ajax함수 호출
		// 본문 댓글과 대댓글을 하나의 이벤트로 처리하기 위해 클래스명과 노드구조 동일하게 맞춤
		let rr_ref = $(this).closest(".replyToReplyArea").attr("rr_ref");	// closest함수로 조상노드까지 검색가능
		let rr_content = $(this).parent().siblings(".textareaContainer").children("textarea").val();	// siblings은 형제노드를 찾는다
		//$(this).parent().siblings(".textareaContainer").children("textarea").val("");	// 댓글 내용 추출후에 비워주기
		if(rr_content === "") {		
			alert("댓글내용을 입력하세요!");	// 댓글내용없는데 등록버튼 누를 경우
		}else {
			insertReviewReply(rr_ref, rr_content);	// insert ajax호출
		}
	});
});
function detailReviewReply(){	// 댓글 목록 ajax으로 가져오는 함수
	$.ajax({
		url: "/detailReviewReply",
		data: {r_no: r_no},		// 현재 게시글 번호 전달
		success: function(data){
			$("#replyArea").empty();	// 동적 댓글 생성 div비우기
			$("#total_reply").html("댓글&nbsp;"+data.total_reply);	// 댓글 수
			$(data.rrlist).each(function(idx,item){		// 댓글 수 만큼 반복
				let $div = $("<div></div>");
				if(item.rr_step > 0) {	// 대댓글일경우 들여쓰기
					$div.css("margin-left", "25px");
				}
				let $div_c1 = $("<div></div>").addClass("replyNicknameContainer");	// css적용을 위한 클래스
				let $img = $("<img>").attr({
					"src": "rank/" + item.rank_icon,
					"height": 25
				});
				let $div_c1_c1 = $("<div></div>").append($img);
				let $div_c1_c2 = $("<div></div>").append(item.nickName).css("margin-top", "5px");
				let $div_c1_c3 = $("<div></div>").text(item.date_diff_str).css("margin-top", "5px").addClass("regdate"); // css적용을 위한 클래스
				$div_c1.append($div_c1_c1, $div_c1_c2, $div_c1_c3);

				let $div_c2 = $("<div></div>").html(item.rr_content).css({	// 댓글내용
					"margin-top": "10px",
					"margin-bottom": "10px"
				});

				let $div_c3 = $("<div></div>");
				let $div_c3_c1 = $("<div></div>").addClass("btnContainer");	// css적용을 위한 클래스
				let rr_id = item.id;	// 댓글을 작성한 id를 변수에 저장
				if(login_id === rr_id) {	// 로그인id와 댓글작성id가 일치할 경우 수정,삭제 아이콘 보이기
					let $img_mod = $("<img>").attr("src", "icons/refresh.png");
					let $btn_mod = $("<button></button>").attr("title", "수정").append($img_mod);
					//let $a_mod = $("<a></a>").attr("href", "").append($btn_mod);
					
					let $img_del = $("<img>").attr("src", "icons/bin.png");
					let $btn_del = $("<button></button>").attr("title", "삭제").append($img_del);
					//let $a_del = $("<a></a>").attr("href", "").append($btn_del);
					
					$div_c3_c1.append($btn_mod, $btn_del);
				}
				if(login_id !== "") {		// 현재 로그인한 사용자일 경우 댓글아이콘 보이기
					let $img_rep = $("<img>").attr("src", "icons/reply.png");
					let $btn_rep = $("<button></button>").attr("title", "댓글").append($img_rep).addClass("btnReply");

					$div_c3_c1.append($btn_rep);
				}
				let $div_c3_c2 = $("<div></div>").addClass("div_c3_c2").addClass("replyToReplyArea").attr("rr_ref", item.rr_ref);
				// $div_c3_c2 노드에 이벤트로 동적으로 댓글입력창,등록버튼 생성됨. 이를 위한 클래스 'div_c3_c2' 
				// 'replyToReplyArea'클래스는 본문댓글,대댓글 공통클래스이며 댓글내용을 추출하여 ajax통신하기 위한 클래스
				$div_c3.append($div_c3_c1, $div_c3_c2);
				
				$div.append($div_c1, $div_c2, $div_c3,);
				$("#replyArea").append($div);
			})
		}
	})
}
function insertReviewReply(rr_ref, rr_content){		// 댓글 내용을 입력 ajax함수
	$.ajax({
		url: "/insertReviewReply",
		data: {
			r_no: r_no,
			rr_ref: rr_ref,
			rr_content: rr_content
		},
		success: function(data){
			$("#replyToBoardArea").children(".textareaContainer").children("textarea").val("");	// 본문댓글 입력창 비우기
			$replyTextArea.val("");	// 대댓글 입력창 비우기
			detailReviewReply();	// 입력한 댓글을 보이기 위해 select ajax함수 재호출
		}
	})
}
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
<section>
		<br><br>
		<p style="font-size: 20px">후기 게시판&nbsp;&gt;&nbsp;<font color="#c85725">후기 상세</font></p>
		<p style="font-size: 15px">라이딩 경험을 공유해요.</p>
		
		<br><br>
		<!-- 게시글 시작 -->
		<!-- 제목 -->
		<p style="font-size: 30px">${rvo.r_title }</p><br>	
		<!-- 닉네임, 등록일자, 조회수 -->
			<img src="rank/${rvo.rank_icon }" height="25">
			${rvo.nickName }&nbsp;&nbsp;
			${rvo.date_diff_str }&nbsp;&nbsp;
			조회수 ${rvo.r_hit }
		<br>
		<hr>
		<!-- 코스명 -->
		<div style="padding: 3px;">코스 : ${rvo.c_name }</div>
		<hr>
		
		<br>
		<!-- 등록사진 -->
		<c:forEach var="rfvo" items="${rflist }">
			<img src="${rfvo.rf_path }/${rfvo.rf_savename}" width="400" height="400">
		</c:forEach>
		
		<br><br><br>
		<!-- 게시글내용 -->
		${rvo.r_content }
		<br><br><br><br>
		
		<div id="replyTextArea"></div>
		<!-- 수정,삭제 버튼 -->
		<c:if test="${rvo.id == m.id }">
			<a href="deleteReview?r_no=${rvo.r_no }"><img src="buttons/delete.png" class="button"></a>
			<a href="updateReview?r_no=${rvo.r_no }"><img src="buttons/edit.png" class="button"></a>
		</c:if>
		<br><br>
	
		<!-- 댓글 수량 -->
		<h3 id="total_reply"></h3>
		<hr>
		<!-- 댓글 목록 영역 -->
		<div id="replyArea"></div>
		<hr><br>
		<!-- 본문 댓글 영역 -->
		<c:if test="${m != null }">
			<div id="replyToBoardArea" class="replyToReplyArea"></div>
		</c:if>
</section>

<jsp:include page="footer.jsp"/>
</body>
</html>