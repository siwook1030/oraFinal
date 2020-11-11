<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
   <title>미진-마이페이지-정보수정</title>
   <style>
    ul { //메뉴 스타일
         box-pack:center;
                        justify-content: center; // 창에따라 사이즈 달라짐
         background-color: #ffffff;
         list-style-type: none;
         margin: 50px; //메뉴 위치
         padding: 50px;
         overflow: hidden;
      }
      li { float: center; }
      li a {
         display: block;
         background-color: #ffffff;
         color: gray;
         padding: 15px;
         float: left;
         width: 100px;
         text-align: center;
         text-decoration: none;
         text-align: center;
         font-weight: bold;
      }
      li a.current {
         color: black;
         background-color: #FF6347; //주황색 클릭
      }
      li a:hover:not(.current) {
         background-color: #CD853F; //갈색 마우스위로
         color: white;
      }
      <!-- 회원정보-->
      
              #myinfo {
                padding-left: 800px;
                display: table;
                padding: 100px;
                width: 300px;
              .row {
              }
              .display: table-row;
              }
              .cell {
                display: table-cell;
                padding: 20px;
                border-bottom: 1px solid #DDD;
              }
              .col1 {
                background-color:#F2F2F2;
                text-align: center;
                width: 100px;
              }
              .col2 {
                padding-left: 20px;
                width: 300px;
              }
              
   </style>
   
   <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script type="text/javascript">
	$(function(){
		
		$("#btnUpdate").click(function() {
			$(".updateMember").css({visibility: "visible"});
			$("#btnUpdate").css({visibility: "hidden"});
			$("#btnUpdate2").css({visibility: "visible"});
		});

		 $("#btnUpdate2").click(function() {
			var pw1 = document.getElementById("password1").value;
			var pw2 = document.getElementById("password2").value;
			var pass = false;
			if(pw1 == pw2){
				alert("비밀번호가 일치합니다");
				pass = true;
			}
			
			if( pw1 != pw2){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
				
			if(pass){
				const pwd = document.getElementById("password1");
		         console.log(pwd+"---------------------");
		          const pwAvail = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,12}$/;
		          const pwAvailCheck = pwAvail.test(pwd.value.trim());
		          if(!pwAvailCheck){
		              alert("비밀번호는 문자,숫자,특수기호 1가지이상 포함하여야합니다");
		              return;
		          }
				var data =$("#update").serialize();
				$.ajax("/update", {data:data,type: "POST",success:function(re){			
					alert("회원 정보가 수정되었습니다"+re);			
					window.location.reload();
				}});		
			}
		 });
	});
	</script>

   <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script type="text/javascript">

	function pwd_check(){


		};
   </script>
   
 <!-- 컨테이너 시작-->
   <style type="text/css">

		/* 개별 */
		#change {
			padding: 10px;
			text-align: center;
			color: black;
		}
		#modify{
		font-size: 20px;
		margin: 10px auto;		
		text-align: left;
		width:500px; 
		height:40px;

		}

		#modify2{
		margin: 10px auto;		
		text-align: left;
		width:500px; 
		height:40px;

		}
		
		#modify_input{
		margin-bottom: 20px;
		
		text-align: left;
		width:500px; 
		height:40px;
		}

		.modify_input{
		margin-bottom: 20px;
		
		text-align: left;
		width:500px; 
		height:40px;
		}

	</style>
 <!-- 컨테이너 끝-->
    <style>
      input, button { font-family: inherit; font-size: inherit; }
    </style>
    
    <style>


</style>

 


</head>
<body>
   
   
     <ul id="mytab">
   		<h1>마이페이지</h1>
            <li><a class="current" href="/myPage">정보 수정</a></li>
            <li><a href="/myPageSaveCourse">찜 목록</a></li>
            <li><a href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li><a href="/myPageListReview">작성 후기</a></li>
            <li><a href="myPageListMeeting">작성 번개</a></li>
 	        <li><a href="/myPageMyRank">랭킹</a></li>
     </ul>
<ul>
     <!--회원정보-->
    
	<div id="change"> 
             	<div id=modify>이름</div>
				<input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.name} "  />
					
				<form id="update">
				<div id=modify>닉네임</div>
				<input type="text" class="form-control text-muted modify_input " disabled="disabled" value="${m.nickName}" />
				<div ></div>
					<input class="updateMember modify_input" style="visibility: hidden ;" placeholder="바꿀 닉네임을 입력하세요" name="nickName"/>

				
				<div id=modify>전화번호</div>
				<input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.phone }"  />
				<div ></div>
					<input  class="updateMember modify_input" style="visibility: hidden ;" placeholder="바꿀 전화번호를 입력하세요" name="phone"/>
                
				<div id=modify>비밀번호</div>
			
				<div ></div>
					<input type="password" id="password1" class="updateMember modify_input" style="visibility: hidden ;" placeholder="새 비밀번호를 입력하세요" name="password"/>
				<div ></div>
					<input type="password" id="password2" class="updateMember modify_input" style="visibility: hidden ;" placeholder="새 비밀번호를 다시 입력하세요" name="password2"/>
				</form>
		   
	            <div id=modify>성별</div>
				<input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.gender }"  />

             	<div id=modify>회원등급</div>
				<input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.rank_name }"  />

             	<div id=modify>가입일</div>
				<input type="text" class="form-control text-muted modify_input" disabled="disabled" value="${m.regdate }"  />

			<div ></div>
	      <button id="btnUpdate">수정창열기</button>
	      <button id="btnUpdate2" style="visibility: hidden">수정하기</button>
	</div>
</ul>

     
     
<jsp:include page="footer.jsp"/>

</body>
</html>