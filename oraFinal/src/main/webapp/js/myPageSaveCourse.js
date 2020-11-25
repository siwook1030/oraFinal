window.onload = function(){
			const token = $("meta[name='_csrf']").attr("content");
		    const header = $("meta[name='_csrf_header']").attr("content");
		     const parameter = $("meta[name='_csrf_parameter']").attr("content");
		    $(document).ajaxSend(function(e, xhr, options) {
		        if(token && header) {
		            xhr.setRequestHeader(header, token);
		        }
		    });

    let addIndex = 0;
    let lastIndex = 0;

    const saveCourseList = document.getElementById("saveCourseList");
    
    function getCourseList(index){   
       $.ajax({
         url: "/myPageSaveCourse?"+parameter+"="+token,
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
                 <span style="cursor: hand; cursor:pointer;" title="삭제" class="deleteSaveCourse d-flex align-items-center justify-content-center btn-custom" value="'+c.c_no+'">\
                    <span class="fa fa-link" value="'+c.c_no+'"></span>\
                 </span>\
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
          //var data=$(this).val();
          var data=$(this).attr("value");
             console.log(data);
             $.ajax({
                url:"/deleteSaveCourse?"+parameter+"="+token,
                method:"POST",
                data:{"cno":data},
                success: function(re){
                   alert("찜코스가 삭제되었습니다"+re);
                   window.location.reload();
             }});            
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