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
   header {
      width: 1000px;
      height: 100px;
      margin-top: 10px;
      font-family: 'NEXON Lv1 Gothic Low OTF';
      border: solid 1px red;
      margin: 10px auto;
   }
   #logo {
       float: left; 
   }
   #top {
      margin: 30px 20px 0 0;
      font-size: 12px;
      float: right;
      text-align: right;   
   }
   #login {
      font-size: 11px;
      text-align: right;
   }
      
      
      
   <!-- mypage tab 메뉴 --!>
           * {padding: 0; margin: 0;}
           a {text-decoration: none; color: #666;}
           li {list-style: none;}
           #tab-menu {
             width: 1000px;
             background : ffffff;
           }
           #tab-btn ul {
             overflow: hidden;

           }
           #tab-btn li {
             padding-left: 80px;
             float: left; width: 100px; text-align: center;
           }
           #tab-btn li a {
             display: block; color: #pink;
             padding: 15px 10px;
             font-weight: bold;
           }
           #tab-btn li.active a {
             border-bottom: 3px solid #2b210e;
             color: #2b210e;
           }

           #tab-cont {
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

   
   
   
   footer {
   margin: 30px auto;
       width: 1000px;
       height: 150px;

       font-family: 'NEXON Lv1 Gothic Low OTF';
       border: solid 1px green;
      }
    #footer_box {
       width: 1000px;
       height: 150px;
       margin: 0 auto;
       text-align: center;
      
    }
    #footer_icon{
       margin: 0 auto;
    }
    #address {
       margin: 10px 0 0 0;
       font-size: 11px;
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


<header>
  <div id="logo">
         <a href="/mainPage"><img src='/headerImg/logo.png' height="100"></a>
      </div>
      <div id="login">
      <c:choose>
      	<c:when test="${m == null }">
      		<a href="/login">로그인</a>&nbsp;&nbsp;&nbsp;<a href="/signUp">회원가입</a>
      	</c:when>
      	<c:when test="${m != null }">
      		${m.nickName } 라이더! &nbsp;&nbsp;<a href="/logout">로그아웃</a>&nbsp;&nbsp;<a href="/myPage2">마이페이지</a>
      	</c:when>
      </c:choose>
         <img src="/headerImg/myIcon.png" height="40">
         &nbsp;&nbsp;
      </div>
      <div id="top">
         오늘의 라이딩&nbsp;&nbsp;&nbsp;&nbsp;자전거길&nbsp;&nbsp;&nbsp;&nbsp;<a href="listReview">후기게시판</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="listMeeting">번개게시판</a>&nbsp;&nbsp;&nbsp;&nbsp;정보게시판
      </div>
 </header>
   
   
  <div id="tab-menu">
  <div id="tab-btn">

    <ul>
      <li class="active"><a href="#">정보 수정</a></li>
      <li><a href="#">찜 목록</a></li>
      <li><a href="#">내코스</a></li>
      <li><a href="#">작성글</a></li>
      <li><a href="#">랭킹</a></li>
    </ul>
  </div>
  <!--찜목록-->
  <div id="tab-cont">
      <div>
  		<form id="update">
        <!--회원정보-->
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

		</form>
      <button id="btnUpdate">수정</button>
      <button id="btnUpdate2" style="visibility: hidden">수정</button>
            </div>
      </div>
      
      
      
      <div id="container">
      <figure>
         <!-- <img src="img/${vo.cp_path }"> -->
         <c:forEach var="vo" items="${list }">
               <option value="${vo.cp_name }">${vo.c_name }</option>
            </c:forEach>

         <figcaption>블라블라${vo.cp_path } </figcaption>
         <c:forEach var="vo" items="${list }">
               <option value="${vo.c_no }">${vo.c_name }</option>
            </c:forEach>

         <!-- <img src=img/"> -->
         <!-- <figcaption>    </figcaption> -->
      </figure>
    </div>

      <div>
        작성글 불러오기

      </div>
      <div>
        랭킹
      </div>
    </div>


  </div>
</div>

 <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script>

     <script id="rendered-js" >
      var tabBtn = $("#tab-btn > ul > li"); //각각의 버튼을 변수에 저장
      var tabCont = $("#tab-cont > div"); //각각의 콘텐츠를 변수에 저장
      
      //컨텐츠 내용을 숨겨주세요!
      tabCont.hide().eq(0).show();
      
      tabBtn.click(function () {
       var target = $(this); //버튼의 타겟(순서)을 변수에 저장
       var index = target.index(); //버튼의 순서를 변수에 저장
       tabBtn.removeClass("active"); //버튼의 클래스를 삭제
       target.addClass("active"); //타겟의 클래스를 추가
       tabCont.css("display", "none");
       tabCont.eq(index).css("display", "block");
      });
      //# sourceURL=pen.js
      </script>

     
     
     
     
     
     
     
     
     
     
   <footer>
       <div id='footer_box'>
            <div id="footer_icon" >
               <img src='/footerImg/instagram.png' height="50px">
               <img src='/footerImg/facebook.png' height="50px">
               <img src='/footerImg/twitter.png' height="50px">
               <ul id="address">
                  <li>04108 | 서울시 마포구 백범로 23 구프라자 3층</li>
                  <li>TEL: 02-707-1480 | Email: ora@bit.com</li>
                  <li>COPYRIGHT (C)2020 오늘의 라이딩 ALL RIGHTS RESERVED</li>
               </ul>
            </div>
            
         </div>
   </footer>
</body>
</html>