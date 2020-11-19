<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <link rel="StyleSheet" type="text/css" href="resource/TeamCSS.css">
   <style type="text/css">
    #nick_css{
       text-shadow: 2px 2px 1px red;
     }

/* =============================== 현왕 모달창 내부 css =================================== */
     .modal_wrap .title{
     font-size:20px;
     padding: 20px; 
     background : gold;
   }
   .modal_wrap{
        display: none;
        width: 500px;
        height: 500px;
        position: absolute;
        top:50%;
        left: 50%;
        margin: -250px 0 0 -250px;
        background:#eee;
        
        z-index: 2;
    }
    .black_bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 150%;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }
    .modal_close{
        width: 26px;
        height: 26px;
        position: absolute;
        top: -30px;
        right: 0;
    }
    .modal_close> a{
        display: block;
        width: 100%;
        height: 100%;
        background:url(https://img.icons8.com/metro/26/000000/close-window.png);
        text-indent: -9999px;
    }
/* =============================== 현왕 모달창 내부 css 종료 =================================== */

     
/* ===== 현왕 파일 찾기 아이콘에 마우스 올리면 pointer 효과 넣기 ====== */
     #upload_click{
        cursor: pointer;
     }
/* ===== 현왕 파일 찾기 아이콘에 마우스 올리면 pointer 효과 넣기 종료 ====== */

   </style>
   <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
   <script type="text/javascript">
<!-- ===================================== 현왕 모달창 실행 자바스크립트 추가 =========================================== -->
   window.onload = function() {
       
       function onClick() {
           document.querySelector('.modal_wrap').style.display ='block';
           document.querySelector('.black_bg').style.display ='block';
       }   
       function offClick() {
           document.querySelector('.modal_wrap').style.display ='none';
           document.querySelector('.black_bg').style.display ='none';
       }
    
       document.getElementById('modal_btn').addEventListener('click', onClick);
       document.querySelector('.modal_close').addEventListener('click', offClick);
   };
<!-- ===================================== 현왕 모달창 실행 자바스크립트 추가 종료 =========================================== -->
   
<!-- ===================================== 현왕 모달창 내용 자바스크립트 추가 =========================================== -->
      $(function(){
         $("#btn_pw_ok").click(function(){
              var pwd1 = $("#password_1").val();
              var pwd2 = $("#password_2").val();
       
              if ( pwd1 != '' && pwd2 == '' ) {
                  null;
              } else if (pwd1 != "" || pwd2 != "") {
                  if (pwd1 == pwd2) {
                      $("#alert-success").css('display', 'inline-block');
                      $("#alert-danger").css('display', 'none');
                      $("#pw").val($("#password_1").val());
                     alert($("#pw").val());
                  } else {
                      alert("비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.");
                      $("#alert-success").css('display', 'none');
                      $("#alert-danger").css('display', 'inline-block');
                  }
              }
              return false;
         });
         $("#btn_close").click(function(){
            return true;
         });
       });
<!-- ===================================== 현왕 모달창 내용 자바스크립트 추가 종료 =========================================== -->
   

<%-- ============== 닉네임, 비밀번호 빈칸이면 alert띄우고 실행 x ========== --%>
$(function(){
   $(document).ready(function(){
      $("#submit").on('click', function(){
         if($("#nickname").val().length === 0){
            alert("닉네임 입력은 필수 입니다!!");
            return false;
         }
         if($("#pw").val().length === 0){
            alert("비밀번호를 확인해주세요.");
            return false;
         }
      });
   });
});
<%-- ============== 닉네임, 비밀번호 빈칸이면 alert띄우고 실행 x 종료 ========== --%>

<%-- ========= 이메일 옵션박스 에서 값 가져오기 ========================= --%>
   $(function(){   
      $(document).ready(function(){
         $('select[name=emailSelection]').change(function() {
            if($(this).val()=="1"){
               $('#email').val("");
               $("#email").attr("readonly", false);
            } else {
               $('#email').val($(this).val());
               $("#email").attr("readonly", true);
            }
         });
      });
   });
<%-- ========= 이메일 옵션박스 에서 값 가져오기 종료 ========================= --%>   

   
<%-- =============현왕 주소 넣기 자바스크립트 추가================================================= --%>
     function sample6_execDaumPostcode() {
           new daum.Postcode({
               oncomplete: function(data) {
                   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                   // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                   // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                   var addr = ''; // 주소 변수
                   var extraAddr = ''; // 참고항목 변수

                   //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                   if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                       addr = data.roadAddress;
                   } else { // 사용자가 지번 주소를 선택했을 경우(J)
                       addr = data.jibunAddress;
                   }

                   // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                   if(data.userSelectedType === 'R'){
                       // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                       // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                           extraAddr += data.bname;
                       }
                       // 건물명이 있고, 공동주택일 경우 추가한다.
                       if(data.buildingName !== '' && data.apartment === 'Y'){
                           extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                       }
                       // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                       if(extraAddr !== ''){
                           extraAddr = ' (' + extraAddr + ')';
                       }
                       // 조합된 참고항목을 해당 필드에 넣는다.
                       document.getElementById("sample6_extraAddress").value = extraAddr;
                   
                   } else {
                       document.getElementById("sample6_extraAddress").value = '';
                   }

                   // 우편번호와 주소 정보를 해당 필드에 넣는다.
                   document.getElementById('sample6_postcode').value = data.zonecode;
                   document.getElementById("sample6_address").value = addr;

                   // 상세주소 빈칸 만들기
                   document.getElementById("sample6_detailAddress").value = " ";
                   // 커서를 상세주소 필드로 이동한다.
                   document.getElementById("sample6_detailAddress").focus();
               }
           }).open();
       }
<%-- =============현왕 주소 넣기 자바스크립트 추가 종료 ================================================= --%>

   </script>
</head>
<body>
   <header id="main_header">
      <div id="title">
         <a href="Home.do">
         <img alt="홈페이지" src="img/Logo.png" width=500px; height=150px;>
         </a>
      </div>
      <nav id="main_gnb">
         <ul>
            <c:if test="${empty cust_no }">
               <li><a href="LoginPage.do">로그인</a></li>
               <li><a href="insertCustomer.do">회원가입</a></li>
            </c:if>
            <c:if test="${not empty cust_no }">
               <li><a href="MyPage_Info.do?cust_no=${cust_no }">마이페이지</a></li>
               <li><a href="logout.do?cust_no=${cust_no }">로그아웃</a></li>
            </c:if>
         </ul>
      </nav>
      <nav id="main_lnb">
         <div class="menu"><a>도서대여</a></div>
         <div class="menu"><a href="postList.do?group=10">커뮤니티</a></div>
            <div class="dropdown">
               <img src="resource/img/community icon.png" class="menu_icon">
               <div class="subWrapper">
                  <div class="sub"><a href="postList.do?group=10">공지사항</a></div><br>
                  <div class="sub"><a href="postList.do?group=20">창작물 게시판</a></div><br>
                  <div class="sub"><a href="postList.do?group=30">중고장터</a></div>
               </div>
            </div>
         <div class="menu"><a href="faqViewpage.do">고객지원</a></div>
            <div class="dropdown">
               <img src="resource/img/customer service icon.png" class="menu_icon">
               <div class="subWrapper">
                  <div class="sub"><a href="faqViewpage.do">FAQ</a></div><br>
                  <div class="sub"><a href="QnaList.do">Q&A</a></div><br>
                  <div class="sub"><a href="addrViewpageAPI.do">오시는길</a></div>
               </div>
            </div>
         <div class="menu"><a href="MyPage_Info.do?cust_no=${cust_no }">마이페이지</a></div>
            <div class="dropdown">
               <img src="resource/img/mypage icon.png" class="menu_icon">
               <div class="subWrapper">
                  <div class="sub"><a href="MyPage_Info.do?cust_no=${cust_no}">내정보</a></div><br>
                  <div class="sub"><a href="MyPage_Folder.do?cust_no=${cust_no}">나의서재</a></div><br>
                  <div class="sub"><a href="optOutCustomer.do">회원탈퇴</a></div>
               </div>
            </div>
         <div class="menu"><a href="siteMap.do">사이트맵</a></div>
      </nav>
   </header>
   
   <div id="content">
      <aside id="main_aside">
         <h2>마이페이지</h2>
         <ul>
            <li><a href="MyPage_Info.do?cust_no=${c.cust_no}">&nbsp;&nbsp;내정보</a></li>
            <li><a href="MyPage_Folder.do?cust_no=${c.cust_no}">&nbsp;&nbsp;나의서재</a></li>
            <li><a href="optOutCustomer.do">&nbsp;&nbsp;회원탈퇴</a></li>
         </ul>
      </aside>
      
      <section id="main_section">
         <form action="UpdateCustomer.do" method="post" enctype="multipart/form-data"><br>
              <input type="hidden" name="cust_no" value="${c.cust_no}"><br>
              <input type="hidden" name="birthday" value="${c.birthday }">
              <input type="hidden" name="name" value="${c.name }">
              <img src="img/${c.fname}" width="150" height="150">
           <input type="hidden" name="fname" value="${c.fname}">
           
<!-- ============================= 현왕 파일 찾기 아이콘으로 변경해서 찾을수있도록 설정 ========================================================================== -->
            <input type="file" name="uploadFile" style="display: none;">
            <input type="text" name="file2" id="file2" style="display: none;">
            <img src="img/upload.png" border="0" onclick="document.all.uploadFile.click(); document.all.file2.value=document.all.uploadFile.value"
                     width="30px" height="30px" id="upload_click">
<!-- ============================= 현왕 파일 찾기 아이콘으로 변경해서 찾을수있도록 설정 종료 ========================================================================== -->
            
              <h2 id="id_css">${c.name }</h2>
              <br>
              <hr style="border: #e6e6e6 1px dotted">
              <p style="color: black; font-size: small; font-weight: bold;" id="nick_css">* 닉네임 필수</p>
              
<!-- ===================================================================== 현왕 id="nickname" 추가 ======== -->
              <input type="text" name="nickname" value="${c.nickname}" size="60px;" id="nickname">
<!-- ===================================================================== 현왕 id="nickname" 추가 종료 ======== -->

              <br>
              <p style="color: gray; font-size: small;">욕설 비속어 사용 시 서비스 이용이 제한될 수 있습니다.</p>
              <br>
              <p style="font-weight: bold; font-size: large;">* 비밀번호</p>
<!-- ===================================================================== 현왕 id="pw" 추가 =========== -->
              <input type="password" name="pw" value="${c.pw }" size="60px;" id="pw">
<!-- ===================================================================== 현왕 id="pw" 추가 종료 =========== -->


<!-- ===================================== 현왕 모달창 띄우기 추가 =========================================== -->
           <button type='button' id="modal_btn">변경하기</button>
<!-- ===================================== 현왕 모달창 띄우기 추가 종료=========================================== -->

          
<!-- ===================================== 현왕 모달창 내용 추가 =========================================== -->
           <div class="black_bg"></div>
           <div class="modal_wrap">
               <div class="modal_close"><a href="#">close</a></div>
                 <div class="title">비밀번호 변경하기</div>
              <br><br><br>
               <div class="content_title">비밀번호</div>
               <div class="content_content">
                   <input type="password" id="password_1" class="pw" placeholder="비밀번호">
               </div>
                <span style="color: gray;">8~15자리의 영문, 숫자, 특수문자의 입력이 가능합니다.</span>
                <br><br>
               <div class="content_title">비밀번호 확인</div>
               <div class="content_content">
                   <input type="password" id="password_2" class="pw" placeholder="비밀번호 확인">
                   <br>
                   <span id="alert-success" style="display: none;">비밀번호가 일치합니다.</span>
                   <span id="alert-danger" style="display: none; color: #d92742; font-weight: bold; ">비밀번호가 일치하지 않습니다.</span>
               </div>
               <div id="div_result"></div>
               <br>
               <button id="btn_pw_ok">암호 확인</button>
               <button id="btn_close">창 닫기</button>
           </div>
<!-- ===================================== 현왕 모달창 내용 추가 종료 =========================================== -->

           <br><br>
              <hr style="border: #e6e6e6 1px dotted">
           <p style="font-weight: bold; font-size: large;">휴대폰 번호</p>
              <input type="text" name="m_phone" value="${c.m_phone }" size="60px;">
              <br><br>
              <hr style="border: #e6e6e6 1px dotted">
              
  <%-- --------------------------------------------------- 현왕 주소 넣기 우편번호 ---------------------------------------------------------- --%>
             <p style="font-weight: bold; font-size: large;">주소</p>
             <input type="text" id="sample6_postcode" name="addr_num" value="${addr_num }" placeholder="우편번호" size="8px;">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
          <input type="text" id="sample6_address" name="addr_1" value="${addr_1 }" placeholder="주소" size="50px;"><br>
          <input type="text" id="sample6_detailAddress" name="addr_2" value="${addr_2 }" placeholder="상세주소" size="50px;">
          <input type="text" id="sample6_extraAddress" name="addr_ref" value="${addr_ref }" placeholder="참고항목" hidden="hidden">
          <br><br>
  <%-- --------------------------------------------------- 주소 넣기 우편번호 종료---------------------------------------------------------- --%>
              
              <hr style="border: #e6e6e6 1px dotted">
              
  <%-- =======================================  현왕 email select로 option 클릭시 자동 써지기 추가  ================================================= --%>
              <p style="font-weight: bold; font-size: large;">이메일</p>
              <input type="text" value="${id }" size="25px;" name="id"> @ <input type="text" id="email" value="${email }" size="25px" name="email">
              
              <select id="emailSelection" name="emailSelection">
             <option value="1" selected="selected">직접입력</option>
                 <option value="naver.com">naver</option>
                 <option value="gmail.com">gmail</option>
                 <option value="daum.net">daum</option>
                 <option value="nate.com">nate</option>
              </select>
  <%-- =======================================  현왕 email select로 option 클릭시 자동 써지기 추가 종료 ================================================= --%>
              
              <br><br>
              <hr style="border: #e6e6e6 1px dotted">
              <p style="font-weight: bold; font-size: large;">관심장르</p>
              <c:set var="interest" value="${c.interest }"/>
            <c:if test="${fn:contains(interest, '인문')}">
                  <input type="checkbox" name="genre" value="인문" CHECKED="checked">인문
            </c:if>   
               &nbsp;
            <c:if test="${!fn:contains(interest, '인문')}">
                  <input type="checkbox" name="genre" value="인문">인문
            </c:if>   
               &nbsp;
            <c:if test="${fn:contains(interest, '경영')}">
               <input type="checkbox" name="genre" value="경영" CHECKED="checked">경영       
            </c:if>   
               &nbsp;
            <c:if test="${!fn:contains(interest, '경영')}">
               <input type="checkbox" name="genre" value="경영">경영       
            </c:if>   
               &nbsp;
            <c:if test="${fn:contains(interest, '소설')}">
               <input type="checkbox" name="genre" value="소설" CHECKED="checked">소설  
            </c:if>   
            <c:if test="${!fn:contains(interest, '소설')}">
               <input type="checkbox" name="genre" value="소설">소설       
            </c:if>   
               <br>
            <c:if test="${fn:contains(interest, '역사')}">
               <input type="checkbox" name="genre" value="역사" CHECKED="checked">역사 
            </c:if>   
               &nbsp;
            <c:if test="${fn:contains(interest, '순수과학')}">
               <input type="checkbox" name="genre" value="순수과학" CHECKED="checked">순수과학
            </c:if>   
               &nbsp;
            <c:if test="${fn:contains(interest, '응용과학')}">
               <input type="checkbox" name="genre" value="응용과학" CHECKED="checked">응용과학
            </c:if>   
            <c:if test="${!fn:contains(interest, '역사')}">
               <input type="checkbox" name="genre" value="역사">역사 
            </c:if>   
               &nbsp;
            <c:if test="${!fn:contains(interest, '순수과학')}">
               <input type="checkbox" name="genre" value="순수과학">순수과학
            </c:if>   
               &nbsp;
            <c:if test="${!fn:contains(interest, '응용과학')}">
               <input type="checkbox" name="genre" value="응용과학">응용과학
            </c:if>   
            <br><br>
            <div class="hr"></div>
              <br>
              
              <!-- ====================== 동의문구 삭제 ================================== -->
              
             <input type="submit" value="변경하기" style="background: white; font-weight: bold;" id="submit"><br><br>
         </form>
      </section>
   </div>
   <footer id="main_footer">
      <p>&copy; 탈주금지조. All rights reserved. | Design by members of 탈주금지조</a>.</p>
      <img alt="" src="img/twitter_icon.png">
      <img alt="" src="img/facebook_icon.png">
      <img alt="" src="img/insta_icon.png">
      <img alt="" src="img/youtube_icon.png">
   </footer>
</body>
</html>