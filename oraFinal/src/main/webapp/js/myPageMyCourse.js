window.onload = function(){
    let addIndex = 0;
    let lastIndex = 0;

    const saveCourseList = document.getElementById("saveCourseList");
    
    function getCourseList(index){   
       $.ajax({
         url: "/myPageMyCourse",
         method:"POST",
         success: function(courseVo){
            $(courseVo).each(function(i, c) {
               lastIndex = i;
               addIndex = i;
                 
                 console.log("index"+index);
                 console.log("lastIndex"+lastIndex);
       
                 
               if(i >= index){                
                return;               
               };
                 
           const courseBox = document.createElement("div");
           courseBox.className="col-md-4";




           let courseContent = '<div class="property-wrap ftco-animate fadeInUp ftco-animated">\
               <a href="/detailCourse?c_no='+c.c_no+'" class="img" target="_blank" style="background-image: url('+c.c_photo[0].cp_path+'/'+c.c_photo[0].cp_name+');">\
                  <div class="rent-sale">\
                     <span class="rent">'+c.c_loc+'</span>\
                  </div>\
                  <p class="price"><span class="orig-price">'+"Level:"+c.c_difficulty+'</span></p>\
               </a>\
               <div class="text">\
                  <h3><a href="/detailCourse?c_no='+c.c_no+'" target="_blank">'+c.c_name+'</a></h3>\
                  <span class="location"></span>\
                  <ul class="property_list">\
                  </ul>\
                  <div class="list-team d-flex align-items-center mt-2 pt-2 border-top">\
                     <div class="d-flex align-items-center"></div>\
                      <span class="text-right">'+c.c_distance+'km </span>\
                  </div>\
               </div>\
            </div>'; 

           
           courseBox.innerHTML = courseContent;
           saveCourseList.append(courseBox);
            });//첫번째포문   
            }//에이작 석세스
         });//에이작끝

    };
       getCourseList(5);
    

       
       $(document).on("click",".deleteSaveCourse", function() {
          alert("관리자의 승인이필요한 서비스입니다");          
       });//삭제클릭이벤트
    
       $("#add").click(function() {
          $("body #saveCourseList").empty();
           getCourseList((addIndex+ 5));
          if(lastIndex < (addIndex+5)){                    
             $("#add").remove();
             $("#lastPage").html("다음 페이지가 없습니다");

            };
    
       });   
 };