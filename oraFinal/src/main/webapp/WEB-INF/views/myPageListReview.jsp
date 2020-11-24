<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <jsp:include page="my_header.jsp"/>
  
    <title>내 작성 후기</title>
        <meta name="_csrf_parameter" content="${_csrf.parameterName}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf" content="${_csrf.token}" />
<script type="text/javascript">
window.onload = function(){
	const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function(e, xhr, options) {
        if(token && header) {
            xhr.setRequestHeader(header, token);
        }
    });
	
}

</script>
  </head>
  <body>
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('https://cdn.pixabay.com/photo/2017/08/07/00/02/people-2597767__340.jpg'; background-size:100% 800px;);" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container_my">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate pb-0 text-center">
          </div>
        </div>
      </div>
    </section>
    
    
 <section class="ftco-section ftco-no-pb ftco-no-pt">
    <div class="container">   
           <h1>내가 만든 코스 목록</h1>
           
	   <div class="row" id="saveCourseList"></div>

        <div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
                <li class="active" id="add"><span>+</span></li>
                <div id="lastPage"></div>
                
              </ul>
            </div>
          </div>
        </div>
    </div>
    </section>
      
      
    </section>   

  
  
   <jsp:include page="footer.jsp"/>
    
  </body>
</html>