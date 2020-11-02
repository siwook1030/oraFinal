<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
<title>회원 정보 수정</title>
<style type="text/css">
     * {
      margin: 0px;
      padding: 0px;
   }
      
      
      
   <!-- mypage tab 메뉴 --!>
           * {padding: 0; margin: 0;}
           a {text-decoration: none; color: #666;}
           li {list-style: none;}
           #tab-menu {
             width: 1000px;
             background : ffffff;
           }
           #tab-btn a {
             overflow: hidden;

           }
           #tab-btn a {
             padding-left: 80px;
             float: left; width: 130px; text-align: center;
           }
           #tab-btn a {
             display: block; color: #pink;
             padding: 15px 10px;
             font-weight: bold;
           }
           #tab-btn li.active a {
             border-bottom: 3px solid #2b210e;
             color: #2b210e;
           }

           #tab-cont {
           clear:both;
             width: 100%;
             background: #fff;
             padding-top: 30px;
             padding-left: 30%;
             box-sizing: border-box;
             border-radius: 0 0 4px 4px;
           }

  <!-- 회원정보-->
          #myinfo {
          
            padding-left: 800px;
            display: table;
            padding-top: 100px;
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





  <!-- 찜 코스 컨테이너--!>

          #container{
             columns-width:1000px;
             columns-gap: 15px;
             background-color: #ffffff;
             color: inherit;
           }
         #tab{
            float:center;
            border:1px solid black;
            width:1000px;
            height:50px;
         }
         #container figure{
              display: inline-block;
              border:1px solid rgba(0,0,0,0.2);
              margin-top:20px;
              margin-left:40px;
              margin-bottom: 15px;
              padding:10px;
              box-shadow: 2px 2px 5px rgba(0,0,0,0.5);
            }
            #container figure img{
              width:300px;
              text-align: center;
            }
            #container figure figcaption{
              border-top:1px solid rgba(0,0,0,0.2);
              padding:10px;
              margin-top:11px;
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
			var data =$("#update").serialize();
			$.ajax("/update", {data:data,type: "POST",success:function(re){			
				alert("회원 정보가 수정되었습니다"+re);			
				window.location.reload();
			}});
			
		});
	});
</script>
</head>
<body>
 <jsp:include page="header.jsp"/>
   
  <div id="tab-menu">
  <div id="tab-btn">

    <ul>
      <a href="/myPage" class="active">정보 수정</a>
      <a href="/myPageSaveCourse">찜 목록</a>
      <a href="/myPageMyCourse">내코스</a>
      <a href="/myPageListReview">내 후기게시판</a>
      <a href="myPageListMeeting">내 게시판</a>
      <a href="/myPageMyRank">랭킹</a>
    </ul>
  </div>
  <!--찜목록-->
  <div id="tab-cont">
      <div>
      
      
        <!--회원정보-->
  		<form id="update">
            <div id="myinfo">
              <div class="row">
                <span class="cell col1">아이디</span>
                <span id="id" class="cell col2">${m.id}</span>
              </div>
              
              <!-- 비밀번호 가져오기.. 안되면 재설정 -->
              <%-- <div class="row">
                <span class="cell col1">비밀번호</span>
                <span id="password" class="cell col2">${m.password }</span>
              </div> --%>
              
              <div class="row">
                <span class="cell col1">이름</span>
                <span id="name" class="cell col2">${m.name }</span>
              </div>
              <div class="row inputNickName">
                <span class="cell col1">닉네임</span>
                <span id="nickName" class="cell col2">${m.nickName}
                	<span class="updateMember" style="visibility: hidden">
                		<input type="text" name="nickName">
                	</span>
                </span>
              </div>
              <div class="row inputPhone">
                <span class="cell col1">전화번호</span>
                <span id="phone" class="cell col2">${m.phone }
                	<span class="updateMember" style="visibility: hidden">
                		<input type="text" name="phone">
                	</span>
                </span>
              </div>
              <div class="row">
                <span class="cell col1">성별</span>
                <span id="getder" class="cell col2">${m.gender }</span>
              </div>
              <div class="row">
                <span class="cell col1">회원등급</span>
                <span id="rank_name" class="cell col2">${m.rank_name }</span>
              </div>
              <div class="row">
                <span class="cell col1">가입일</span>
                <span id="regdate"class="cell col2">${m.regdate }</span>
              </div>

            </div>
		</form>
      <button id="btnUpdate">수정</button>
      <button id="btnUpdate2" style="visibility: hidden">수정</button>
      </div>

	<jsp:include page="footer.jsp"/>


     
     

</body>
</html>