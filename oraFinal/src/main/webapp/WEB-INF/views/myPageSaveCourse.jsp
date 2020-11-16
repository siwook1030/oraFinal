<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
   <meta charset="UTF-8">
   <title>마이페이지-찜코스</title>
   <style>
   되나
   ul { //메뉴 스타일
        box-pack:center;
        justify-content: center; // 창에따라 사이즈 달라짐
        background-color: #ffffff;
        list-style-type: none;
        margin: 50px; //메뉴 위치
        padding: 50px;
      padding-left:200px;
        overflow: hidden;
     }
     .mytab li {
         float: center;

       }
      li a {
         display: block;
         background-color: #ffffff;
         color: gray;
         padding: 15px;
         float: left;
         width: 100px;
         text-align: center;
         text-decoration: none;
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

        <!-- 사진 프레임-->
           .all{
             position:relative;
             min-height:1px;
             padding-top: 50px;
           }

           .photo{
              background-color:pink;
           }
           .name{
              background-color:#AFF1FB;
           }
           .level{
              background-color: #9FF8BB;
           }
           .time{
              background-color: #FBCA93;
           }

         .img {
           border: 1px solid #ddd;
           border-radius: 4px;
           padding: 5px;
          }

          .zenbu{
          border: 1px solid gold;
          padding: 10px;
          height: auto;
          min-height: 130px;
          max-width: 200px;
          overflow: auto;
          display: inline-block;
          background-color: #FBB8CF;
          }

        .bookmark{
             background: yellow;
             width:50px;
             height:30px;
             border:none;
          }

         .syasin{
           width: 100%;
           max-width: 760px;
           border-radius: 7px;
         }

   </style>

</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
   window.onload = function(){
                
      $.ajax({
         url: "/myPageSaveCourse",
         method:"POST",
         success: function(courseVo){
            $(courseVo).each(function(i, savecoursVo) {
               
               let div = $("<div></div>").prop("class", "zenbu"); //클래스 이름이 zenbu인 div 생성
				 
               let div2 = $("<div></div>").prop("class", "name"); // 클래스 이름이 name 인 div2 생성
               let div2_p =$("<p></p>");
               let div2_h5 = $("<h5></h5>");
               let div2_span = $("<span></span>").html(savecoursVo.c_name); //div2(name) 안에있는 span안에 c_name 불러오기
				               $(div2_h5).append(div2_span);
				               $(div2).append(div2_p,div2_h5);
               
               let div3 =$("<div></div>").prop("class", "level"); //div3(level)인 div생성 
               let div3_div1=$("<div></div>").text("Level "+savecoursVo.c_difficulty+"・"+savecoursVo.c_time+"분");//난이도.시간
               let div3_div2=$("<div></div>").text();
               let div3_div2_strong=$("<strong></strong>").text(savecoursVo.c_distance+"km"); //거리
					               	$(div3_div2).append(div3_div2_strong);
					               	$(div3).append(div3_div1,div3_div2);

               let img=$("<img/>"); //사진
               let button = $("<button></button>").attr({"class":"deleteSaveCourse bookmark","value": savecoursVo.c_no}).text("삭제"); //삭제버튼

               $(savecoursVo.c_photo).each(function(i, c_photo) {
                  img.attr({"class": "syasin" ,src :c_photo.cp_path+"/"+c_photo.cp_name});

               });//두번째포문
               
                  $(div).append(img,button,div2,div3);
                  //$("body").append(div);
                  $("#aa").append(div);
                  
            });//첫번째포문
            }//에이작 석세스
         });//에이작끝

         
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
               
         }); 
   }
</script>
<body>
    <ul>
     <h1>마이페이지</h1>
            <li class="mytab"><a href="/myPage">정보 수정</a></li>
            <li class="mytab"><a class="current" href="/myPageSaveCourse">찜 목록</a></li>
            <li class="mytab"><a href="/myPageMyCourse">작성 코스(준비중)</a></li>
            <li class="mytab"><a href="/myPageListReview">작성 후기</a></li>
            <li class="mytab"><a href="myPageListMeeting">작성 번개</a></li>
            <li class="mytab"><a href="/myPageMyRank">랭킹</a></li>
      </ul>

<ul id="aa">
     <h1>찜코스목록</h1>
       
          <div class="zenbu">
           class= div1 zenbu 

           <img class="syasin" src="https://www.durunubi.kr/editImgUp.do?filePath=/data/koreamobility/file/2020/09/8fbc53acde254d3caf9e8fd48254fb1c.jpg" >
               <button class="bookmark"  type="button" onclick="alert('선택한 코스를 지우시겠습니까?');" > 클릭</button>
                     <div class="name">
                          <p class="name"> div2 class=name  </p>
                          <h5><span>제주 자전거길 (우도일주)</span></h5>
                      </div>

                                            <div class="time"> div3 class=time 90분 </div>
                          <div class="level">div 4 class= level 12km</div>
                     

          </div>

</ul> 
<button id="add">더보기</button>


</body>

</html>