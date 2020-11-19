<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <jsp:include page="my_header.jsp"/>
  
    <title>내 작성 후기</title>
        
  </head>
  <body>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_1.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          
          	<span><h1 class="mb-3 bread">마이페이지</h1></span>
          
          	<p class="breadcrumbs">

          		<span>
          			<a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a>
          		 <a href="/myPage">정보 수정 <i class="fa fa-chevron-right"></i></a>
          		<a href="/myPageSaveCourse">찜 목록 <i class="fa fa-chevron-right"></i></a>
          		<a href="/myPageMyCourse">내 작성 코스<i class="fa fa-chevron-right"></i></a>
          		</span>
         	    <a href="/myPageListReview">내 작성 후기<i class="fa fa-chevron-right"></i></a>
				<span>
            	<a href="myPageListMeeting">내 작성 번개<i class="fa fa-chevron-right"></i></a>
            	<a href="/myPageMyRank">랭킹</a>
          		</span>
          		</p>
     </ul>
            
          </div>
        </div>
      </div>
    </section>
    
    
    <section class="ftco-section contact-section">
      <div class="container">
        <div class="row block-9 justify-content-center mb-5">
          <div class="col-md-8 mb-md-5">
          	<h2 class="text-center">회원정보수정</h2>
            <form action="#" class="bg-light p-5 contact-form">
              <div class="form-group">
			    <div id=modify>이름</div>
	            <input type="text" class="form-control text-muted " disabled="disabled" value="${m.name} "  />
            
              </div>
              <div id=modify>닉네임</div>
              <div class="form-group">
                <input type="text" class="form-control" disabled="disabled" value="${m.nickName}" style="background-color: #e2e2e2;">
              </div>
                <input class="updateMember form-control hidden" style="visibility: hidden ;" placeholder="바꿀 닉네임을 입력하세요" name="nickName"/>
              

              <div id=modify>전화번호</div>
              <div class="form-group">
                <input type="text" class="form-control" disabled="disabled" value="${m.phone }">
              </div>
                <input   type="tel" id="phone" name="phone" class="updateMember form-control hidden" maxlength="11"  placeholder="새 전화번호를 입력하세요 ex)01012345678" > 
		 
		         <div id="clickForm">
		         <input type="button" id="sendPhone" class="btn btn-primary  hidden form-control " value="인증번호 받기">
		         </div>
		         <div id="inputNumForm">
		            <input type="tel" id="inputNum" class="updateMember form-control hiddenPhone" name="inputNum" maxlength="6" placeholder="인증번호를 입력하세요">
		            <input type="button" id="checkNum" class="hiddenPhone send form-control btn btn-primary" value="인증">
		         </div>    
		
		                
		            <div id=modify class="hidden">비밀번호</div>
		            <div ></div>
		               <input type="password" id="password1" class="updateMember form-control hidden" style="visibility: hidden ;" placeholder="새 비밀번호를 입력하세요" name="password"/>
		          
		               <input type="password" id="password2" class="updateMember form-control hidden" style="visibility: hidden ;" placeholder="새 비밀번호를 다시 입력하세요" name="password2"/>
		            
		           
		      	   <input type="password" id="pwd" class="updateMember form-control " placeholder="회원정보 수정을 위해서는 비밀번호 입력하세요" name="pwd" style="border: 1px solid #ff0000;"/>
		        	 <div ></div>

            </form>
             </div>
            </div>
         
           <div style="text-align: center">
             <button id = btnUpdate value="수정하기" class="btn btn-primary py-3 px-5 "> 수정하기</button>
		      <button id="btnUpdate2" style="visibility: hidden" class="btn btn-primary py-3 px-5" >수정완료</button>
            </div>
          
        </div>
       
       
      </div>
      
      
    </section>	

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
       
    </footer>
    
  
	<jsp:include page="my_footer.jsp"/>
    
  </body>
</html>