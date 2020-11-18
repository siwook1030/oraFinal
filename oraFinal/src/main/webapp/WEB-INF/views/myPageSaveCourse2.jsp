<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
   <meta charset="UTF-8">
   <title>마이페이지-찜코스</title>
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/animate.css">
    
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
   window.onload = function(){
	   let addIndex = 0;
	   let lastIndex = 0;
	   
/* 		function getCourseList(index){	
    	  $.ajax({
  			url: "/myPageSaveCourse",
  			method:"POST",
  			success: function(courseVo){
  				$(courseVo).each(function(i, savecoursVo) {
  					lastIndex = i;
  	  				addIndex = i;
  	  						
  					if(i >= index){ 					
						return;					
  					};  					
  					
  					let div = $("<div></div>").prop("class", "zenbu");		
  					let button = $("<button></button>").attr({"class":"deleteSaveCourse bookmark","value": savecoursVo.c_no,"addIndex":addIndex}).text("삭제");
  					let div2 = $("<div></div>").prop("class", "name");
  					let div2_p =$("<p></p>");
  					let div2_h5 = $("<h5></h5>");
  					let div2_span = $("<span></span>").html(savecoursVo.c_name);
  					$(div2_h5).append(div2_span);
  					$(div2).append(div2_p,div2_h5);
  					
  					let div3 =$("<div></div>").prop("class", "time");
  					let div3_div1=$("<div></div>").text("레벨: "+savecoursVo.c_difficulty);
  					let div3_div2=$("<div></div>");
  					let div3_div2_strong=$("<strong></strong>").text(savecoursVo.c_distance+"km");
  					$(div3_div2).append(div3_div2_strong);
  					$(div3).append(div3_div1,div3_div2);
  					let img=$("<img/>");
  					
	  					$(savecoursVo.c_photo).each(function(i, c_photo) {
	  						img.attr({"class": "syasin" ,src :c_photo.cp_path+"/"+c_photo.cp_name});	  						
	  					});//두번째포문
	  					
  					$(div).append(img,button,div2,div3);
  					$("#aa").append(div);
  					
					
  				});//첫번째포문	
  				}//에이작 석세스
  			});//에이작끝

		};//펑션끝 */

		
		function getCourseList(index){	
    	  $.ajax({
  			url: "/myPageSaveCourse",
  			method:"POST",
  			success: function(courseVo){
  				$(courseVo).each(function(i, savecoursVo) {
  					lastIndex = i;
  	  				addIndex = i;
  	  						
  					if(i >= index){ 					
						return;					
  					};  					
  					
  					let divItem = $("<div></div>").prop("class", "item");
  							
  					let divProperty = $("<div></div>").prop({"class" : "property-wrap ftco-animate"});

  					let divRent =$("<p></p>").attr({"class": "rent-sale"});
  					let spanSale = $("<span></span>").attr({"class":"sale"}).html("삭제");
  					//let div2_span = $("<span></span>").html(savecoursVo.c_name);
					
  					
  					let divText=$("<div></div>").attr({"class": "text"});

					let ulProperty_list = $("<ul></ul>").attr({"class":"property_list"});
  					let li = $("<li></li>").html("3");
					let spanFlaticon = $("<span></span>").attr({"class":"flaticon-bed"});
					

					let h3 = $("<h3></h3>");
					let a = $("<a></a>").html("코스이름");
					

					let spanLocation = $("<span></span>").attr({"class":"location"}).html("키로미터");	


					let aDflex = $("<a></a>").attr({"class":"d-flex align-items-center justify-content-center btn-custom"});
					let spanFa = $("<span></span>").attr({"class":"fa fa-link"});
					


  					let divListteam = $("<div></div>").prop("class", "list-team d-flex align-items-center mt-2 pt-2 border-top");
  					let divDflex1 = $("<div></div>").attr({"class":"d-flex align-items-center"});

  					let aImg;
  					let divImg2;
	  					$(savecoursVo.c_photo).each(function(i, c_photo) {
	  						aImg = $("<a></a>").attr({"class" : "img"}).css({"background":""+c_photo.cp_path+"("+c_photo.cp_name+")"});
	  	  					divImg2 = $("<div></div>").attr({"class":"img"}).css({"background":""+c_photo.cp_path+"("+c_photo.cp_name+")"});
		  				});//두번째포문
	  					
	  				$(divRent).append(spanSale);
					$(aImg).append(divRent);
	  				$(divProperty).append(aImg);

	  				$(li).append(spanFlaticon);
					$(ulProperty_list).append(li);

					$(h3).append(a);

					$(aDflex).append(spanFa);
	  					
	  				
					$(divDflex1).append(divImg2);
					$(divListteam).append(divDflex1);
	  					
					$(divText).append(ulProperty_list,a,spanLocation,aDflex,divListteam);
		  			
	  				$(divProperty).append(divText);
  					$(divItem).append(divProperty);

  					$(".carousel-properties").append(divItem);
					
  				});//첫번째포문	
  				}//에이작 석세스
  			});//에이작끝

		};//펑션끝
	
      	getCourseList(5);		

			
	      $(document).on("click",".deleteSaveCourse", function() {
	    	  var data=$(this).val();
		         console.log(data);
		         $.ajax({
		            url:"/deleteSaveCourse",
		            method:"POST",
		            data:{cno:data},
		            success: function(re){
		               alert("찜코스가 삭제되었습니다"+re);
		               window.location.reload();
		         }});	      	
	      });//삭제클릭이벤트
		
    	  $("#add").click(function() {
			   $("body #aa").empty();
			    getCourseList((addIndex+ 5));
				alert(addIndex);
				if(lastIndex < (addIndex+5)){	  					
					$("#add").remove();
					$("#lastPage").html("다음 페이지가 없습니다");

	  			};
		
			});	
   };
</script>
</head>

<body>



<section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-12 heading-section text-center ftco-animate mb-5">
          	<span class="subheading">What we offer</span>
            <h2 class="mb-2">Featured Properties</h2>
          </div>
        </div>
        <div class="row ftco-animate">
          <div class="col-md-12">
            <div class="carousel-properties owl-carousel">

            </div>
          </div>
        </div>
      </div>
    </section> 
</body>

</html>