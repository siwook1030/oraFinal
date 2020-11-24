<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보 수정</title>

<jsp:include page="my_header2.jsp"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/myPage.js"></script>`

<style>

    /* 개별 */
    #change {
      padding: 10px;
      text-align: center;
      color: black;
    }

    #modify {
      font-size: 20px;
      margin: 10px auto;
      text-align: left;
    }


    .send {
      < !--인증번호 받기버튼-->background: #24A148 !important;
      border: 1px solid #24A148 !important;
      color: #fff !important;
    }

    margin-bottom: 20px;

    text-align: left;
    width:440px;
    height:40px;
    }

    . new_input {
      display: block;
      width: 100%;
      height: calc(1.5em + 0.75rem + 2px);
      padding: 0.375rem 0.75rem;
      padding-top: 0.375rem;
      padding-right: 0.75rem;
      padding-bottom: 0.375rem;
      padding-left: 0.75rem;
    }

    .phone_input {
      < !--새전화번호입력-->padding-right: 50px;
      font-size: 14px;
    }

<!-- 탭조절 	-->
.my-wrap {
  width: 100%;
  height: 850px;
  position: relative;
  background-size: cover;
  background-repeat: no-repeat;
  background-position: top center;
  z-index: 0; }
  @media (max-width: 991.98px) {
    .my-wrap {
      background-position: top center !important; } }
  .my-wrap .overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    content: '';
    opacity: .5;
    background: #21243d;
    height: 100px; }
  .my-wrap.my-wrap-2 {
    height: 170px !important;
    position: relative; }
    .my-wrap.my-wrap-2 .overlay {
      width: 100%;
      opacity: .8;
      height: 190px; }
    .my-wrap.my-wrap-2 .slider-text {
      height: 190px !important; }
      
           /*회색부분 크기*/
    .colmd8 { 
    -webkit-box-flex: 0;
    -ms-flex: 0 0 66.66667%;
    flex: 0 0 66.66667%;
    max-width: 50%; }   /*여기*/
      
</style>
</head>
<body>
    
  
   
<section class="my-wrap my-wrap-2" style="background-color: #fff;"  id=top>

    <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          
            <span>
              <h1 class="mb-3 bread">마이페이지</h1>
            </span>
            <p class="breadcrumbs">
              <span class="mr-2">
                <a href="index.html">Home <i class="fa fa-chevron-right"></i></a>
              </span>
              <a href="/myPage">정보 수정 <i class="fa fa-chevron-right"></i></a>
              <span>
                <a href="/myPageSaveCourse">찜 목록 <i class="fa fa-chevron-right"></i></a>
                <a href="/myPageMyCourse">내 작성 코스<i class="fa fa-chevron-right"></i></a>
                <a href="/listReview?searchType=id&searchValue=${m.id }">내 작성 후기<i class="fa fa-chevron-right"></i></a>
                <a href="listMeeting?id=${m.id}">내 작성 번개<i class="fa fa-chevron-right"></i></a>
                <a href="/myPageMyRank">랭킹</a>
              </span>
            </p>
            
          </div>
        </div>
      </div>
    </section>
    <section class="ftco-section contact-section">
      <div class="container" >
        <div class="row block-9 justify-content-center mb-5">

          <div class="colmd8 mb-md-5 bg-light p-5 contact-form">
            <form action="#" id="update">
              <h2 class="text-center" >회원정보수정</h2>
              <div class="form-group">
                <div id="modify" class="hidden">이름</div>
                <input type="text"  class=" hidden form-control form-group " disabled="disabled" value="${m.name} " />
              </div>
              <div id=modify class="hidden">닉네임</div>
              <div class="form-group">
              </div>

              <input id="nickName" class="updateMember form-control hidden" style="visibility: hidden ;" placeholder="바꿀 닉네임을 입력하세요" name="nickName" />


              <div id=modify class="hidden">전화번호</div>
              <div class="form-group">
              <input type="tel" id="phone" name="phone" class="updateMember form-control form-group hidden" maxlength="11"
                placeholder="새 전화번호를 입력하세요 ex)01012345678">
              </div>

              <div id="clickForm">
                <input type="button" id="sendPhone" class="btn btn-primary  hidden form-control form-group " value="인증번호 받기">
              </div>
              <div id="inputNumForm">
                <input type="tel" id="inputNum" class="updateMember form-control form-group hiddenPhone" name="inputNum" maxlength="6"
                  placeholder="인증번호를 입력하세요">
                <input type="button" id="checkNum" class="hiddenPhone send form-control form-group btn btn-primary" value="인증">
              </div>

              <div id=modify class="hidden">비밀번호</div>
              <div></div>
              <input type="password" id="password1" class="modify updateMember form-control form-group hidden" style="visibility: hidden ;"
                placeholder="새 비밀번호를 입력하세요 영문+숫자+특수문자(8~12자리)조합" name="password" />
              <input type="password" id="password2" class="updateMember form-control form-group hidden" style="visibility: hidden ;"
                placeholder="새 비밀번호를 다시 입력하세요" name="password2" />
              <input type="password" id="pwd" class="updateMember form-control form-group " placeholder="회원정보 수정을 위해서는 비밀번호 입력하세요" name="pwd"
                style="border: 1px solid #ff0000; visibility: visible;" />
              <div>
            </div>

            </form>
              <div class="form-group" ><a href="#top">
                <button id=btnUpdate value="수정하기" class="btn form-control form-group btn-primary py-3 px-5 "> 수정하기</button>
              	<button id="btnUpdate2" style="visibility: hidden" class="btn form-group form-control btn-primary py-3 px-5">수정완료</button>
              </a></div>
          </div>
        </div>
      </div>

    </section>
    <jsp:include page="footer.jsp" />

    </body>

    </html>