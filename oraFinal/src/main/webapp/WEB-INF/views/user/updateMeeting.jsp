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
		padding: 50px;
	}
	#selectLoc {
		text-align: center;
		padding: 40px 0 20px;
	}
	#contents {
			border: 1px solid #D5D5D5;
			padding: 60px;
			margin: 50px 0 100px;
	}
	input {
		border: none;
	}
	.btn {
		color: white;
		padding: 8px 12px;
		margin: 40px 0px;
		background-color: #88BEA6;
		align-content: center;
		font-size: 15px;
		border: none;
		cursor: pointer;
	}
	#btnDiv {
		text-align: center;
	}
	.mtIcon {
		width: 40px;
		margin: 10px;
	}
	.selectMtAll {
		display: flex;
		
	}
	.selectMtAll .selectMt {
		width: 40%;
		border: 1px #BDBDBD solid;
		border-radius: 10px;
		margin: 20px;
		padding: 10px; 
		text-align: center;
	}
	textarea {
		border: none;
	}
	#m_title {
		border-bottom: 1px solid gray;
		margin: 10px;
		width: 880px;
		height: 50px;
		margin: 20px 0;
		font-size: 30px;
	}
	#m_content {
		padding: 10px 0;
		border-top: 1px solid gray;
		border-bottom: 1px solid gray;
		margin-bottom: 30px;
	}

   /*카카오 맵css*/
   .map_wrap {position:relative;width:100%;height:450px;font-size: 80%;}
   .title {font-weight:bold;display:block;}
   .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
   #centerAddr {display:block;margin-top:2px;font-weight: normal;}
   .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
   
   /*파일업로드관련 css*/
    .drag-over { background-color: #CFF768; outline-style: dotted; outline-offset:-20px; }
	.thumb { width:100px; height:100px; padding:5px; float:left; }
	.thumb > img { width:100%; height: 100%; }
	.thumb > .close { position:absolute; background-color:red; cursor:pointer; }
   
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f57515ee2bdb3942d39aad2a2b73740&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/js/loginCheck.js"></script>
<script type="text/javascript">
	window.onload = function(){
		const checkM = checkLogin();
		const memberId = checkM.item.id;
		const m_title = document.getElementById('m_title');
		const m_time = document.getElementById('m_time');
		const m_numpeople= document.getElementById('m_numpeople');
		const m_locname = document.getElementById('m_locname');
		const m_content = document.getElementById('m_content');
		
		
		// 사진 여러장 등록 기능
		const photoReg = /(.*?)\/(jpg|jpeg|png|bmp|gif)$/;
			
		const uploadFiles = [];
		const drop = document.getElementById("drop");
		const photoInput = document.getElementById("photoInput");
		
		drop.addEventListener("dragenter", function(e) {
			this.className = "drag-over";
		})
		drop.addEventListener("dragleave", function(e) {
			this.className = "";
		})
		drop.addEventListener("dragover", function(e) {
			e.stopPropagation();
			e.preventDefault();
		})
		drop.addEventListener("drop", function(e) {
			e.preventDefault();
			this.className = "";
			const cpFiles = e.dataTransfer.files;
			addPhoto(cpFiles);
		})
		
		photoInput.addEventListener("change", function(e) {
			console.log(e.target.files); // e: 발생하는 이벤트를 모두 담아놓은 변수
			const cpFiles = e.target.files;
			addPhoto(cpFiles);
		});
			
		function addPhoto(cpFiles){
			const files = cpFiles; //드래그&드랍 항목
			for(let i = 0; i < files.length; i++) {
				const file = files[i];
				if (!file.type.match(photoReg)) {
					alert("확장자는 이미지 확장자만 가능합니다.");
					continue;
				}
				if(cPhotoNumCheck() >= 10){
					alert("사진은 최대 10장까지만 등록가능합니다");
					return;
				}
				const size = uploadFiles.push(file); //업로드 목록에 추가
				previewPhoto(file, size - 1); //미리보기 만들기
			}
		}
			
		function previewPhoto(file, idx) {
			const reader = new FileReader();
			reader.onload = (function(f, idx) {
				return function(e) {
					const div = '<div class="thumb"> \
					<div class="close" data-idx="' + idx + '">X</div> \
					<img src="' + e.target.result + '" title=""/> \
					</div>';
					$("#thumbnails").append(div);
				};
			})(file, idx);
			reader.readAsDataURL(file);
		}
			
		$("#thumbnails").on("click", ".close", function(e) {
			const $target = $(e.target);
			const idx = $target.attr('data-idx');
			uploadFiles[idx].upload = 'disable'; //삭제된 항목은 업로드하지 않기 위해 플래그 생성
			$target.parent().remove(); //프리뷰 삭제
		});
		
		function cPhotoNumCheck(){
			let cPhotoCnt = 0;  // 업로드할 사진수 체크
			uploadFiles.forEach(function(file, i) {
				if(file.upload != 'disable'){
					cPhotoCnt++;
				}
			})
			return cPhotoCnt;
		}

	//-----------------------------------------------
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
		
		const meetingSrc = '/searchCourseImg/mtLoc.png', // 미팅 마커이미지의 주소입니다    
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
		               
		               document.getElementById("m_latitude").value = lat; 
		               document.getElementById("m_longitude").value = lon;
		               
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
		         document.getElementById("m_latitude").value = latlng.getLat(); //위도경도 값 가져오는거당
		         document.getElementById("m_longitude").value = latlng.getLng();
		         document.getElementById("m_locname").value = result[0].address.address_name;
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
			setCourse(c_no,0);
			 
			});
			
			function setCourse(c_no,n){
				console.log("셀렉번호 : " + c_no);
			   if(c_no == '0'){
			      startMarker.setMap(null); 
			      arriveMarker.setMap(null); 
			      coursePolyline.setMap(null);
			      meetingMarker.setMap(null);
			      meetingInfowindow.setMap(null);
			      nowLocDisplay();
			      map.setLevel(7);
			      document.getElementById("m_locname").value = "";      
			   }
			   else{
			      nowLocInfowindow.setMap(null);
			      nowLocMarker.setMap(null);
			      meetingMarker.setMap(null);
			      meetingInfowindow.setMap(null);
			      document.getElementById("m_locname").value = ""; 
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
			    		if(n != 0){
			    			courseBounds.extend(n);
				    	}
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

			}
			   const mtJson = ${mtJson};
			   const mfJson = ${mfJson};
			   const meetingLatLng = new kakao.maps.LatLng(mtJson.m_latitude, mtJson.m_longitude);
			   setCourse(mtJson.c_no,meetingLatLng);
			   meetingMarker.setPosition(meetingLatLng);
			   meetingMarker.setMap(map);
			   document.getElementById("m_locname").value = mtJson.m_locname;
			   
			  // map.setCenter(new kakao.maps.LatLng(mtJson.m_latitude, mtJson.m_longitude));

				const optionArr = document.querySelectorAll("#selectCourse option");
				console.log(optionArr);
				for(let i=0; i<optionArr.length; i++) {
					const cNum = optionArr[i].getAttribute("cNum");
					if(mtJson.c_no==cNum) {
						optionArr[i].selected = true;
					}
				}
				mfJson.forEach(function(mfFile, i) {
					const imgUrl = "/"+mfFile.mf_path+"/"+mfFile.mf_savename;
					const req = new XMLHttpRequest();
					req.open('GET',imgUrl);
					req.responseType="blob";
					req.send(null);
					req.addEventListener("load", function(e) {
						const imgFile = this.response;
						console.log(imgFile);
						addPhoto([imgFile]);
						
					})
					req.addEventListener("error", function(e) {
						alert("에러발생");
					})	
				
				});
		// 등록 버튼 클릭
		// 추가완료하기
		$('#btnEdit').click(function(){
			console.log('시작');
			if(m_title.value.trim()==''){
				alert('제목을 입력해주세요.');
				m_title.focus();
				return;
			}
			if(m_time.value.trim()==''){
				alert('미팅날짜를 입력해주세요.');
				m_time.focus();
				return;
			}
			if(m_numpeople.value.trim()==''){
				alert('모임인원을 입력해주세요.');
				m_numpeople.focus();
				return;
			}
			if(m_locname.value.trim()==''){
				alert('미팅위치를 입력해주세요.');
				m_locname.focus();
				return;
			}
			if(m_content.value.trim()==''){
				alert('글 내용을 입력해주세요.');
				m_content.focus();
				return;
			}
			const insertMtForm = document.getElementById('updateMt');
			const mtFormData = new FormData(insertMtForm); // FormData : key, value값으로 mtFormData에 담아줌
			mtFormData.set("id",memberId);
			
			uploadFiles.forEach(function(file, idx) {
				if(file.upload != 'disable'){
					mtFormData.append('uploadMtFiles',file);
				}
			});
			
			$.ajax({
				url: '/user/updateMeeting',
				type: 'post',
				contentType: false,
				processData: false,
				data: mtFormData,
				success: function(m_no){
					window.location = "/detailMeeting?m_no="+m_no;
				}
			});
		});		
	}
</script>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<section>
		<p style="font-size: 20px"><a href="listMeeting">번개 게시판</a>&nbsp;&gt;&nbsp;<font color="#c85725">게시글 수정</font></p>
		<p style="font-size: 15px">번개 게시판 수정 중입니다.</p>

		<div id="contents">
			<!-- 글등록 -->
			<form id="updateMt">
				<div>
					<div>
						<input type="hidden" name="m_no" value="${mt.m_no }">
						<input type="text" placeholder="제목" name="m_title" id="m_title" value="${mt.m_title }">
					</div>
					<div class="selectMtAll">
						<!-- 코스 지도 & 만날 위치 -->
						<div class="selectMt">
							<img src="../meetingImg/ridingRoute.png" class="mtIcon"><br>
							<select id="selectCourse" name="c_no">
								<c:forEach var="c" items="${cList }">
									<c:if test="${c.c_no == 0 }">
										<option cNum="${c.c_no }" value="${c.c_no }">${c.c_name }</option>
									</c:if>
									<c:if test="${c.c_no != 0}">
										<option cNum="${c.c_no }" value="${c.c_no }">${c.c_no }.${c.c_name }/${c.c_loc }/${c.c_view }</option>
									</c:if>   
								</c:forEach>
							</select>
						</div>
						<div class="selectMt">
							<img src="../meetingImg/meetingDate.png" class="mtIcon"><br>
							<input type="date" name="m_time" id="m_time" value="${mt.m_time }">
						</div>
						<div class="selectMt">
							<img src="../meetingImg/meetingMember.png" class="mtIcon"><br>
							<input type="number" name="m_numpeople" id="m_numpeople" value="${mt.m_numpeople }" min="1" style="width: 12em">
						</div>
					</div>
				</div>
				
				<div id="selectLoc">
					<strong style="font-size: 20px;">지도를 클릭하여 미팅장소를 정하세요!</strong><br><br>
					<!-- 위도 --> <input type="hidden" name="m_latitude" id="m_latitude" value="${mt.m_latitude }">
					<!-- 경도 --> <input type="hidden" name="m_longitude" id="m_longitude" value="${mt.m_longitude }">
					<input type="text" name="m_locname" id="m_locname" value="${mt.m_locname }" size="60" style="text-align: center">
		        </div>
				<div class="map_wrap">
					<div id="map" style="width:100%; height:100%; position:relative; overflow:hidden;"></div>
					<div class="hAddr">
						<span class="title">지도중심기준 주소</span>
						<span id="centerAddr"></span>
					</div>
				</div>
				<br><br>
		       
				<textarea rows="30" cols="123" name="m_content" id="m_content">${mt.m_content }</textarea><br>		
				<div id="drop" style="border: 1px solid gray; width: 870px; height: 300px; padding: 3px;">
					<div id="thumbnails"></div>
				</div>
				<input type="file" name="uploadFile" id="photoInput" multiple="multiple"><br>
				<div id="btnDiv">
					<button type="button" class="btn" id="btnEdit" style="background-color: #eccb6a">수정</button>
					<button type="reset" class="btn" id="btnCancel" style="background-color: #d0a183">취소</button>
				</div>
			</form>
		</div>
	</section>
	<jsp:include page="../footer.jsp"/>
</body>
</html>