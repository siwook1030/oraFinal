<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	section {
		margin: 0 auto;
		width: 1000px;
		text-align: left;
   }
   #selectLoc {
		text-align: center;
   }
   input {
   		border: none;
   }
   /*카카오 맵css*/
   .map_wrap {position:relative;width:100%;height:450px;font-size: 80%;}
   .title {font-weight:bold;display:block;}
   .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
   #centerAddr {display:block;margin-top:2px;font-weight: normal;}
   .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
   const mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.53814589110931, 126.98135334065803), // 지도의 중심좌표
        level: 7 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
const map = new kakao.maps.Map(mapContainer, mapOption); 
const mapTypeControl = new kakao.maps.MapTypeControl();
const zoomControl = new kakao.maps.ZoomControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
// 주소-좌표 변환 객체를 생성합니다
const geocoder = new kakao.maps.services.Geocoder();

//현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
searchAddrFromCoords(map.getCenter(), displayCenterInfo);

//////////////////출발도착마커이미지 생성
const startSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
      startSize = new kakao.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
      startOption = { 
      offset: new kakao.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
      };
      //출발 마커 이미지를 생성합니다
      const startImage = new kakao.maps.MarkerImage(startSrc, startSize, startOption);

      const arriveSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
      arriveSize = new kakao.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
      arriveOption = { 
      offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
      };
      //도착 마커 이미지를 생성합니다
      const arriveImage = new kakao.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);

      const startMarker = new kakao.maps.Marker({image:startImage}); //출발마커담을 변수
      const arriveMarker = new kakao.maps.Marker({image:arriveImage});//도칙마커담을 변수
      const coursePolyline = new kakao.maps.Polyline({
         strokeWeight: 5,
          strokeColor: '#FF2400',
          strokeOpacity: 0.9,
          strokeStyle: 'solid'
         });//경로라인담을 변수
/////////////////출발도착마커이미지 생성 끝

const meetingSrc = '/insertMeetingImg/meetingSpot.png', // 미팅 마커이미지의 주소입니다    
meetingSize = new kakao.maps.Size(40, 40); // 미팅 마커이미지의 크기입니다 
/*meetingOption = { 
    offset: new kakao.maps.Point(27, 69) // 미팅 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
};*/
//미팅 마커 이미지를 생성합니다
const meetingImage = new kakao.maps.MarkerImage(meetingSrc, meetingSize);

const meetingMarker = new kakao.maps.Marker({image:meetingImage}), // 클릭한 위치를 표시할 미팅마커입니다
    meetingInfowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 미팅 인포윈도우입니다


////////////////////////////////////////////////////////////////////////////
const nowLocSrc = '/mainPageImg/myLoc.png', // 현위치 마커이미지의 주소입니다    
nowLocSize = new kakao.maps.Size(40, 40), // 현위치 마커이미지의 크기입니다
nowLocOption = {offset: new kakao.maps.Point(27, 69)}; // 현위치 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
//현위치 마커의 이미지정보를 가지고 있는 현위치 마커이미지를 생성합니다
const nowLocImage = new kakao.maps.MarkerImage(nowLocSrc, nowLocSize, nowLocOption);
const nowLocMarker = new kakao.maps.Marker({image:nowLocImage}),
   nowLocInfowindow = new kakao.maps.InfoWindow({zindex:1,removable:true});

function nowLocDisplay(){
   if (navigator.geolocation) {
       
       // GeoLocation을 이용해서 접속 위치를 얻어옵니다
       navigator.geolocation.getCurrentPosition(function(position) {
           
         const lat = position.coords.latitude, // 위도
               lon = position.coords.longitude; // 경도
               
               document.getElementById("latitude").value = lat; 
               document.getElementById("longitude").value = lon;
               
           const locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
               message = '<div style="padding:2px 0 0 25px;">라이더 현위치</div>'; // 인포윈도우에 표시될 내용입니다
           
           // 마커와 인포윈도우를 표시합니다
           displayMarker(locPosition, message);
               
         });
       
   } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
       
     const locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
           message = '현위치를 찾을 수 없습니다'
           
       displayMarker(locPosition, message);
   }
   
}
nowLocDisplay();  // 추가적으로 현위치표시를 사용해야하므로 함수로 만들어놓고 첫실행때 시작되게끔 만듬
//지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
        nowLocMarker.setPosition(locPosition);
        nowLocMarker.setMap(map);
    
    const iwContent = message; // 인포윈도우에 표시할 내용

    // 인포윈도우를 생성합니다
       nowLocInfowindow.setContent(iwContent);
   
    // 인포윈도우를 마커위에 표시합니다 
    nowLocInfowindow.open(map, nowLocMarker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}        


//지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {         
          const detailAddr = '<div>주소 : ' + result[0].address.address_name + '</div>';
            
            let content = '<div class="bAddr">' +
                            '<span class="title">미팅장소</span>' + 
                            detailAddr + 
                        '</div>';
         const latlng = mouseEvent.latLng;
         document.getElementById("latitude").value = latlng.getLat(); //위도경도 값 가져오는거당
         document.getElementById("longitude").value = latlng.getLng();
         document.getElementById("addr").value = result[0].address.address_name;
            // 마커를 클릭한 위치에 표시합니다 
            meetingMarker.setPosition(mouseEvent.latLng);
            meetingMarker.setMap(map);

            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
            meetingInfowindow.setContent(content);
            meetingInfowindow.open(map, meetingMarker);
        }   
    });
});


//중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', function() {
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        const infoDiv = document.getElementById('centerAddr');

        for(let i = 0; i < result.length; i++) {
            // 행정동의 region_type 값은 'H' 이므로
            if (result[i].region_type === 'H') {
                infoDiv.innerHTML = result[i].address_name;
                break;
            }
        }
    }    
}

document.getElementById("selectCourse").addEventListener("change", function(e) {
	const c_no = e.target.value;
	 console.log("셀렉번호 : " + c_no);
	   if(c_no == '0'){
	      startMarker.setMap(null); 
	      arriveMarker.setMap(null); 
	      coursePolyline.setMap(null);
	      meetingMarker.setMap(null);
	      meetingInfowindow.setMap(null);
	      nowLocDisplay();
	      map.setLevel(7);
	      document.getElementById("addr").value = "";      
	   }
	   else{
	      nowLocInfowindow.setMap(null);
	      nowLocMarker.setMap(null);
	      meetingMarker.setMap(null);
	      meetingInfowindow.setMap(null);
	      document.getElementById("addr").value = ""; 
	      $.ajax({
	         url: "/getCourseByMeeting",
	         type: "GET",
	         data:{
	            "c_no":c_no
	         },
	         success: function(data){
	            const c = data;
	            startMarker.setPosition(new kakao.maps.LatLng(c.c_s_latitude, c.c_s_longitude));
	            arriveMarker.setPosition(new kakao.maps.LatLng(c.c_e_latitude, c.c_e_longitude));
				const cLineOnj = JSON.parse(c.c_line);
	            const courseLine = eval(cLineOnj.courseLine);
	            const courseBounds = new kakao.maps.LatLngBounds();
	            coursePolyline.setPath(courseLine); 
	            courseLine.forEach(function(c, i) {
	    			courseBounds.extend(c);
	    		})
	    		map.setBounds(courseBounds);
	            startMarker.setMap(map);
	            arriveMarker.setMap(map);
	            coursePolyline.setMap(map);
	         },
	         error: function(){
	            alert("에러발생")
	         }
	      })
	   }
})

}
</script>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<div id="clear"></div>
	<section><br>
		<p style="font-size: 20px"><a href="listMeeting">번개 게시판</a>&nbsp;&gt;&nbsp;<a href="insertMeeting"><font color="#c85725">게시글 등록</font></a></p>
		<p style="font-size: 15px">만나서 같이 라이딩 해요.</p>

		<!-- 글등록 -->
		<br><br>
		<form action="/insertMeeting" method="post" enctype="multipart/form-data">
			<input type="text" placeholder="제목을 입력해주세요." name="m_title" size="50"><br><br>
			미팅날짜 <input type="date" name="m_time">&nbsp;
			미팅인원 <input type="number" name="m_numpeople" min="1" placeholder="1"><br>
			<!-- 코스 지도 & 만날 위치 -->
			<div>
			코스 <select id="selectCourse" name="c_no">
		            <c:forEach var="c" items="${cList }">
						<c:if test="${c.c_no == 0 }">
							<option value="${c.c_no }">${c.c_name }</option>
						</c:if>
						<c:if test="${c.c_no != 0}">
							<option value="${c.c_no }">${c.c_no }.${c.c_name }/${c.c_loc }/${c.c_view }</option>
						</c:if>   
					</c:forEach>
				</select>
			</div>
			<br><hr><br>
			<div class="map_wrap">
				<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				<div class="hAddr">
					<span class="title">지도중심기준 주소</span>
					<span id="centerAddr"></span>
				</div>
			</div>
			<br><br>
	       
			<div id="selectLoc">
			<strong>원하는 위치를 클릭하여 미팅장소를 정하세요!</strong><br><br>
			<!-- 위도 --> <input type="hidden" name="m_latitude" id="latitude" value="37.53814589110931">
			<!-- 경도 --> <input type="hidden" name="m_longitude" id="longitude" value="126.98135334065803">
			<input type="text" name="m_locname" id="addr" value="" size="60" readonly="readonly" placeholder="미팅장소의 주소가 출력됩니다." style="text-align: center">

	        </div>
			<br><br>
			<hr><br>
			<textarea rows="30" cols="140" name="m_content"></textarea><br>		
			<input type="file" name="uploadFile"><br><br>
	      
			<button type="submit" style="border: none; background-color: transparent;"><img src="meetingImg/add.png"></button>
			<button type="reset" style="border: none; background-color: transparent;"><img src="meetingImg/cancel.png"></button><br>
		</form>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
</html>