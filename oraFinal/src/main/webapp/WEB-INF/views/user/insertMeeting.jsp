<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" type="image⁄x-icon" href='/headerImg/logo.png'>
    <title>번게게시판 글쓰기</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="_csrf_parameter" content="${_csrf.parameterName}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	<meta name="_csrf" content="${_csrf.token}" />
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/animate.css">
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/style.css">
<style type="text/css">
	.nav-item .nav-link { /* nava 로그인 */
		font-size: 15px;
	}
	/* input, select, textarea 태그설정 */
	input, select { border: none; background-color: transparent; width: 62%; text-align: center; }
	textarea:focus, input:focus { outline: none; }
	
	/* 등록, 취소 버튼 */
	.btn { color: white; padding: 7px 17px; margin-left: 3px; align-content: center; font-size: 19px; border: none; cursor: pointer; }
	#submitWrap { text-align: center; padding-top: 50px; }
	/* 미팅장소 */
	#selectLoc { text-align: center; padding: 40px 0 20px; }
	/* 코스, 시간, 인원 선택박스 */
	.selectMtAll { display: flex; }
	.selectMtAll .selectMt { width: 40%; border: 1px #D5D5D5 solid; border-radius: 10px; margin: 20px; padding: 10px; text-align: center; }
	.mtIcon { width: 40px; margin: 10px; }
/* 	.selectMt input, #selectCourse {
		width: 70%;
	} */
	
	/* 제목 입력 */
	#m_title { text-align: center; }
	/* 내용 입력 */
	#m_content { width: 100%; height: 400px; border: none; margin: 30px 0 0; padding: 10px; }
	/* 임시저장상태 */
	#snippet-autosave-status_spinner-label { padding: 3px 5px; width: 75px; }
	#snippet-autosave-status_spinner-loader { width: 400px; margin-left: 50px; }
	/* 카카오 맵 css */
	.map_wrap { position: relative; width: 100%; height: 450px; font-size: 80%; }
	.map_title { font-weight: bold; display: block; }
	.hAddr { position: absolute; left: 10px; top: 10px; border-radius: 2px; background: #fff; background: rgba(255,255,255,0.8); z-index: 1; padding: 5px;}
	#centerAddr { display: block; margin-top: 2px; font-weight: normal; }
	.bAddr { padding:5px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; }
	/* header dropdown */
	.ftco-navbar-light .navbar-nav > .nav-item .dropdown-menu {
		/* background: #fff;
		background-color: #fff;
		opacity: 0.7; */
		background: rgba(255,255,255,0.7);
		/* border: 2px solid white; */
		/* width: 100px; */
		min-width: 9rem;
		color: white;
	}
	.dropdown-item {
		font-weight: bold;
		color: #5D5D5D;
	} 
	.navbar .nav-item:hover .dropdown-menu .dropdown-item {
		color: #5D5D5D;
	}
</style>
<link rel="stylesheet" type="text/css" href="/ckeditor5/editor-styles.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7bf02997fccc8f4d0d956482ddd50a0b&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/js/loginCheck.js"></script>
<script type="text/javascript" src="/ckeditor5/build/ckeditor.js"></script>
<script type="text/javascript">
	window.onload = function(){
		const token = $("meta[name='_csrf']").attr("content");
	    const header = $("meta[name='_csrf_header']").attr("content");
	    const parameter = $("meta[name='_csrf_parameter']").attr("content");
	    $(document).ajaxSend(function(e, xhr, options) {
	        if(token && header) {
	            xhr.setRequestHeader(header, token);
	        }
	    });
		
		let current_urls = [];		// 현재 editor에 있는 img src들의 배열을 담은 변수. url저장형식 => /meeting/46076431.jpg

		const checkM = checkLogin();
		const memberId = checkM.item.id;
		const m_title = document.getElementById('m_title');
		const m_time = document.getElementById('m_time');
		const m_numpeople= document.getElementById('m_numpeople');
		const m_locname = document.getElementById('m_locname');
		const m_content = document.getElementById('editor');
		
		const uploadFiles = [];
		
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
		const nowLocSrc = '/mainPageImg/nowLoc.gif', // 현위치 마커이미지의 주소입니다    
		nowLocSize = new kakao.maps.Size(15, 15); // 현위치 마커이미지의 크기입니다
		//현위치 마커의 이미지정보를 가지고 있는 현위치 마커이미지를 생성합니다
		const nowLocImage = new kakao.maps.MarkerImage(nowLocSrc, nowLocSize);
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
		               
		           const locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		              // message = '<div style="padding:2px 0 0 25px;">라이더 현위치</div>'; // 인포윈도우에 표시될 내용입니다
		           
		           // 마커와 인포윈도우를 표시합니다
		           displayMarker(locPosition);
		               
		         });
		       
		   } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		       
		     const locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
		           message = '현위치를 찾을 수 없습니다'
		           
		       displayMarker(locPosition);
		   }
		   
		}
		nowLocDisplay();  // 추가적으로 현위치표시를 사용해야하므로 함수로 만들어놓고 첫실행때 시작되게끔 만듬
		//지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition) {
		
		    // 마커를 생성합니다
		        nowLocMarker.setPosition(locPosition);
		        nowLocMarker.setMap(map);
		    
		  //  const iwContent = message; // 인포윈도우에 표시할 내용
		
		    // 인포윈도우를 생성합니다
		     //  nowLocInfowindow.setContent(iwContent);
		   
		    // 인포윈도우를 마커위에 표시합니다 
		  //  nowLocInfowindow.open(map, nowLocMarker);
		    
		    // 지도 중심좌표를 접속위치로 변경합니다
		    map.setCenter(locPosition);      
		}        
		
		//지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {         
		          const detailAddr = '<div>주소 : ' + result[0].address.address_name + '</div>';
		            
		            let content = '<div class="bAddr">' +
		                            '<span class="map_title">미팅장소</span>' + 
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

			            const courseLine = c.c_line;

			        	const trkptArr = $(courseLine).find("trkseg trkpt");
			        	const mnBound = $(courseLine).find("bounds")[0];

			        	const latlonArr = new Array();

			        	for(let i=0; i<trkptArr.length; i++){
			        		const lat = trkptArr[i].getAttribute("lat");
			        		const lon = trkptArr[i].getAttribute("lon");
			        		
			        		latlonArr.push(new kakao.maps.LatLng(lat,lon));	 		
			        	}

			            const courseBounds = new kakao.maps.LatLngBounds();
			            
			            const maxLat = mnBound.getAttribute("maxlat");
			        	const maxLon = mnBound.getAttribute("maxlon");	
			        	const minLat = mnBound.getAttribute("minlat");
			        	const minLon = mnBound.getAttribute("minlon");

			        	courseBounds.extend(new kakao.maps.LatLng(maxLat,maxLon));
			        	courseBounds.extend(new kakao.maps.LatLng(minLat,minLon));;
			        	
			            coursePolyline.setPath(latlonArr); 
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
		// 등록 버튼 클릭
		// 추가완료하기
		

		$("#btnCancel").click(function(event){
			// input type submit이 아닌 그냥 button이어도 누르면 submit해버린다. 그래서 기본이벤트 삭제처리함.
			
			event.preventDefault();
			location.href = "/listMeeting";
		});

		function checkImageUrls(editor) {
			return Array.from( new DOMParser().parseFromString( editor.getData(), 'text/html' )
			.querySelectorAll( 'img' ) )
			.map( img => img.getAttribute( 'src' ) );	// 현재 editor에 있는 img src들의 배열 저장
		}

		function setCourse(c_no,n){		// 지도에 선택한 코스그리기 함수
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

		// 사용자가 insert한 이미지 삭제 시 비동기 삭제처리를 위한 함수
		function imageDelete(urls){
			$.ajax({
				url: "/meetingImageDelete?"+parameter+"="+token,
				beforeSend : function(xhr){
		            xhr.setRequestHeader("uploadFolder", "meetingFile");		// 삭제할 파일위치 정보전달
		        },
		        method: "post",
		        traditional: true,
				data: {urls: urls},
				success: function(data){

				}
			});
		}

		// autosave 함수
		function saveData( data ) {
			let c_no = $("#selectCourse").val();
			let m_title = $("#m_title").val();
			let m_latitude = $("#m_latitude").val();
			let m_longitude = $("#m_longitude").val();
			let m_locname = $("#m_locname").val();
			let temp_time = $("#m_time").val();
			let m_numpeople = $("#m_numpeople").val();
			if(m_numpeople === '') {
				m_numpeople = 0;
			}
		    $.ajax({
				url: "/meetingAutoSave?"+parameter+"="+token,
				method: "post",
				data: {
					c_no: c_no,
					m_title: m_title,
					m_content: data,
					m_latitude: m_latitude,
					m_longitude: m_longitude,
					m_locname: m_locname,
					temp_time: temp_time,
					m_numpeople: m_numpeople
				},
				success: function(res){

				}
		    });
		}

		// Update the "Status: Saving..." info.
		function displayStatus( editor ) {
		    const pendingActions = editor.plugins.get( 'PendingActions' );
		    const statusIndicator = document.querySelector( '#snippet-autosave-status' );

		    pendingActions.on( 'change:hasAny', ( evt, propertyName, newValue ) => {
		        if ( newValue ) {
		            statusIndicator.classList.add( 'busy' );
		        } else {
		            statusIndicator.classList.remove( 'busy' );
		        }
		    } );
		}

		//작성중인 게시글이 없을 경우 meeting_temp테이블에 empty record생성 
		function createMeetingTempRecord() {
			$.ajax({
				url: "/createMeetingTempRecord",
				success: function(response){
					
				}
			});
		}

		if(${mtvo == null}) {	// 기존 작성중인 게시글이 없을 경우 신규 임시저장 레코드 생성
			createMeetingTempRecord();
		}else {
			let answer = confirm("작성중인 게시글이 있습니다. 불러올까요?");
			if(answer) {		// 작성중인 게시글 불러오기. controller에서 model에 mtvo를 실은 것을 불러온다.
				$("#selectCourse").val(${mtvo.c_no});
				$("#m_title").val('${mtvo.m_title}');
				$("#editor").text('${mtvo.m_content}');
				$("#m_latitude").val(${mtvo.m_latitude});
				$("#m_longitude").val(${mtvo.m_longitude});
				$("#m_time").val('${mtvo.m_time}');
				$("#m_numpeople").val(${mtvo.m_numpeople});
				
				<c:if test="${mtvo.m_latitude!=null && mtvo.m_longitude!=null}">
					const meetingLatLng = new kakao.maps.LatLng(${mtvo.m_latitude}, ${mtvo.m_longitude});	// 미팅장소표시
					setCourse(${mtvo.c_no}, meetingLatLng);
					meetingMarker.setPosition(meetingLatLng);
					meetingMarker.setMap(map);
				</c:if>
				
				//console.log("주소:"+'${mtvo.m_locname}');
				$("#m_locname").val('${mtvo.m_locname}');
			}else {
				let urls = Array.from( new DOMParser().parseFromString( '${mtvo.m_content}', 'text/html' )
						.querySelectorAll( 'img' ) )
						.map( img => img.getAttribute( 'src' ) );
				if(urls.length > 0) {
					imageDelete(urls);
				}
			}
		}
		
		ClassicEditor
		.create( document.querySelector( '#editor' ), {
			removePlugins: [ 'ImageCaption' ],		// 불필요한 플러그인 삭제
			toolbar: {			
				items: [		// 툴바에 표시할 아이콘 정의
					'heading',
					'|',
					'bold',
					'italic',
					'link',
					'bulletedList',
					'numberedList',
					'|',
					'alignment',
					'indent',
					'outdent',
					'|',
					'imageUpload',
					'blockQuote',
					'insertTable',
					'mediaEmbed',
					'undo',
					'redo',
					'|',
					'fontBackgroundColor',
					'fontColor',
					'fontSize',
					'fontFamily',
					'specialCharacters',
					'underline',
					'|'
				]
			},
			language: 'ko',
			image: {
				// Configure the available styles.
	            styles: [
	                'alignLeft', 'alignCenter', 'alignRight'
	            ],

	            // Configure the available image resize options.
	            resizeOptions: [
	                {
	                    name: 'imageResize:original',
	                    label: 'Original',
	                    value: null
	                },
	                {
	                    name: 'imageResize:50',
	                    label: '50%',
	                    value: '50'
	                },
	                {
	                    name: 'imageResize:75',
	                    label: '75%',
	                    value: '75'
	                }
	            ],

	            // You need to configure the image toolbar, too, so it shows the new style
	            // buttons as well as the resize buttons.
	            toolbar: [
	                'imageStyle:alignLeft', 'imageStyle:alignCenter', 'imageStyle:alignRight',
	                '|',
	                'imageResize'
	                //'|',
	                //'imageTextAlternative'
	            ]
			},
			table: {
				contentToolbar: [
					'tableColumn',
					'tableRow',
					'mergeTableCells',
					'tableCellProperties',
					'tableProperties'
				]
			},
			licenseKey: '',
			//plugins: [ SimpleUploadAdapter ],
	        simpleUpload: {
	            // The URL that the images are uploaded to.
	            uploadUrl: "/meetingImageInsert?"+parameter+"="+token,

	            // Enable the XMLHttpRequest.withCredentials property.
	            withCredentials: true,		// 기본값

	            // Headers sent along with the XMLHttpRequest to the upload server.
	            headers: {
	                Authorization: 'Bearer <JSON Web Token>',	// 기본값
	                uploadFolder: 'meetingFile'
	            }
	        },
			autosave: {
				waitingTime: 1000,	// ms단위. 마지막 변화감지 후 설정한 시간만큼 대기 한 후 이벤트 처리
				save(editor) {
					return saveData(editor.getData());
				}
			},
			mediaEmbed : {
				previewsInData: true	// 이거 안하면 동영상 표시가 안됨. 
			}
			
		} )
		.then( editor => {
			window.editor = editor;		// 기본값
			displayStatus( editor );	// 기본값
			//console.log( editor );	// 에디터 객체 전체 정보
			current_urls = checkImageUrls(editor);
			// ***** 실시간 이미지 삭제 코드 시작 *****
			editor.model.document.on( 'change:data', (eventInfo) => {
				//console.log( eventInfo );
				//console.log("현재URL:"+current_urls);
				let after_urls = checkImageUrls(editor);
			    //console.log("이후URL:"+after_urls);
			    
			    let deleted_url;
			    if(current_urls.length > after_urls.length) {
				    console.log("이미지 삭제됨!");
					for(let i = 0; i < current_urls.length; i++) {
						let isChanged = true;
						for(let j = 0; j < after_urls.length; j++) {
							if(current_urls[i] === after_urls[j]) {
								isChanged = false;
								break;
							}
						}
						if(isChanged) {
							deleted_url = current_urls[i];
							console.log(deleted_url);
							imageDelete(deleted_url);
							break;
						}
					}
				}
			    current_urls = after_urls;
			    console.log("current_urls:"+current_urls);
			});
			// ***** 실시간 이미지 삭제 코드 끝 *****
		} )
		.catch( error => {
			console.error( 'Oops, something went wrong!' );
			console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
			console.warn( 'Build id: b5mnviaze78m-31mkvnarb2x6' );
			console.error( error );
			
		} );

		$("#btnAdd").click(function(){
			let real_content = editor.getData();
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
			if($.trim(real_content) == ''){
				alert('글 내용을 입력해주세요.');
				m_content.focus();
				return;
			}
			const insertMtForm = document.getElementById('insertMt');
			const mtFormData = new FormData(insertMtForm); // FormData : key, value값으로 mtFormData에 담아줌
			mtFormData.set("id",memberId);
			// console.log("현재url"+current_urls);
			mtFormData.set("image_urls", current_urls);
			mtFormData.set("real_content", real_content);
			$.ajax({
				url: '/user/insertMeeting?'+parameter+'='+token,
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
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a style="font-size: 30px;" class="navbar-brand" href="/mainPage">
				<span style="font-weight: bold;"><font color="#45A3F5" >오</font><font color="#bae4f0">늘</font><font color="#88bea6">의</font>
					<font color="#eccb6a">라</font><font color="#d0a183">이</font><font color="#c8572d">딩</font>
				</span>
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        	<span class="oi oi-menu"></span> Menu
			</button>
			<div style="display: block;">
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto">
						<c:choose>
							<c:when test="${m == null }">
								<li class="nav-item"><a style="font-size: 15px;" href="/login" class="nav-link">로그인</a></li>
								<li class="nav-item"><a style="font-size: 15px;" href="/signUp" class="nav-link">회원가입</a></li>
							</c:when>
							<c:when test="${m != null }">
								<li id="courseDropPoint"  class="nav-item dropdown">
									<a class="nav-link  dropdown-toggle" href="#" data-toggle="dropdown" style="font-size: 15px;">  ${m.nickName } 라이더 님  </a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="/myPage?id=${m.id}"> 정보 수정 </a></li>
										<li><a class="dropdown-item" href="/myPageSaveCourse"> 찜 목록 </a></li>
										<li><a class="dropdown-item" href="/myPageMyCourse"> 내 코스 </a></li>
										<li><a class="dropdown-item" href="/listReview?searchType=id&searchValue=${m.id }"> My 후기 </a></li>
										<li><a class="dropdown-item" href="/listMeeting?id=${m.id}"> My 번개 </a></li>
										<li><a class="dropdown-item" href="/myPageMyRank"> 랭킹 </a></li>
									</ul>
								</li>
								<li class="nav-item"><a style="font-size: 15px;" href="/logout" class="nav-link">로그아웃</a></li>
								<c:if test="${m.code_value == '00101' }">
									<li class="nav-item"><a style="font-size: 15px;" href="/admin/adminPage" class="nav-link">관리자 페이지</a></li>
								</c:if>
							</c:when>
						</c:choose>
					</ul>
				</div>    
				<div class="collapse navbar-collapse" id="ftco-nav">
					<ul class="navbar-nav ml-auto" >
						<li class="nav-item"><a href="/mainPage" class="nav-link">Home</a></li>
						<li id="courseDropPoint"  class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">  오늘의 라이딩  </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/listNotice"> 공지사항 </a></li>
							</ul>
						</li>
						<li id="courseDropPoint"  class="nav-item dropdown">
							<a class="nav-link  dropdown-toggle" href="#" data-toggle="dropdown">  라이딩 코스  </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/searchCourse"> 맞춤 코스 검색 </a></li>
								<li><a class="dropdown-item" href="/tagSearchCourse"> 태그 코스 검색 </a></li>
							</ul>
						</li>
						<li class="nav-item"><a href="/listReview" class="nav-link">라이딩 후기</a></li>
						<li class="nav-item active"><a href="/listMeeting" class="nav-link">번개 라이딩</a></li>
						<li class="nav-item"><a href="/user/makingCourse" class="nav-link">메이킹 코스</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
    <!-- END nav -->
    
    <section class="hero-wrap hero-wrap-2" style="background-image: url('/headerImg/meetingMain.jpg');" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-0 text-center">
					<p class="breadcrumbs"><span class="mr-2"><a href="/mainPage">Home <i class="fa fa-chevron-right"></i></a></span><span class="mr-2"><a href="/listMeeting">번개 라이딩 <i class="fa fa-chevron-right"></i></a></span> <span>번개 라이딩 등록 <i class="fa fa-chevron-right"></i></span></p>
					<h1 class="mb-3 bread">번개 등록</h1>
				</div>
			</div>
		</div>
    </section>
    
    <section class="ftco-section">
		<div class="container">
			<!-- 글등록 -->
			<form id="insertMt">
			
				<!-- 글번호, 제목 -->
				<section class="ftco-section ftco-agent" style="padding-bottom: 30px;">
					<div class="container">
						<div class="row justify-content-center pb-5">
							<div class="col-md-12 heading-section text-center ftco-animate">
								<span class="subheading">Today's Riding</span>
								<h2 class="mb-4"><input type="text" placeholder="제목을 입력해주세요." name="m_title" id="m_title"></h2>
							</div>
						</div>
					</div>
				</section> 

					<div class="selectMtAll">
						<!-- 코스 -->
						<div class="selectMt">
							<img src="../meetingImg/ridingRoute.png" class="mtIcon"><br>
							<select id="selectCourse" name="c_no" style="width: 100%;">
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
						<!-- 미팅날짜 -->
						<div class="selectMt">
							<img src="../meetingImg/calendar.png" class="mtIcon"><br>
							<input type="date" name="m_time" id="m_time">
						</div>
						<!-- 모임인원 -->
						<div class="selectMt">
							<img src="../meetingImg/meetingMember.png" class="mtIcon"><br>
							<input type="number" name="m_numpeople" id="m_numpeople" min="1" placeholder="모임인원을 입력해주세요." >
						</div>
					</div>
				
				<div id="selectLoc">
					<strong style="font-size: 20px;">지도를 클릭하여 미팅장소를 정하세요!</strong><br>
					<!-- 위도 --> <input type="hidden" name="m_latitude" id="m_latitude" value="37.53814589110931">
					<!-- 경도 --> <input type="hidden" name="m_longitude" id="m_longitude" value="126.98135334065803">
					<input type="text" name="m_locname" id="m_locname" value="" size="60" readonly="readonly" placeholder="미팅장소의 주소가 출력됩니다." style="text-align: center;">
		        </div>
		        
		        <!-- 지도 -->
				<div class="map_wrap">
					<div id="map" style="width:100%; height:100%; position:relative; overflow:hidden;"></div>
					<div class="hAddr">
						<span class="map_title">지도중심기준 주소</span>
						<span id="centerAddr"></span>
					</div>
				</div>

				<!-- 글내용 입력 -->
				<textarea id="editor" name="m_content"></textarea>
				
				<!-- autosave 상태표시창 -->
				<div id="snippet-autosave-status">
					<!-- <div id="snippet-autosave-status_label">Status:</div> -->
					<div id="snippet-autosave-status_spinner">
						<span id="snippet-autosave-status_spinner-label"></span>
						<span id="snippet-autosave-status_spinner-loader"></span>
					</div>
				</div>
				<div id="submitWrap">
					<button type="button" class="btn" id="btnAdd" style="background-color: #eccb6a">등록</button>
					<button type="reset" class="btn" id="btnCancel" style="background-color: #d0a183">취소</button>
				</div>
			</form>
		</div>
	</section>
	
	<!-- footer 시작 -->
	<footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Today's Riding</h2>
              <p>For your perfect ride.</p>
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
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>코스 찾기</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>라이딩 후기</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>번개 라이딩</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>FAQs</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">About Ora</h2>
              <ul class="list-unstyled">
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>오늘의 라이딩</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>공지사항</a></li>
                <li><a href="#"><span class="fa fa-chevron-right mr-2"></span>QnA</a></li>
              </ul>
            </div>
          </div>
          
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Have a Questions?</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon fa fa-map"></span><span class="text">서울시 마포구 백범로 23</span></li>
	                <li><a href="#"><span class="icon fa fa-phone"></span><span class="text">+82 02 1234 5678</span></a></li>
	                <li><a href="#"><span class="icon fa fa-envelope pr-4"></span><span class="text">ora@bit.com</span></a></li>
	              </ul>
	            </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> 오늘의 라이딩 All rights reserved
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer> 	
    
	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


	<script src="/resources/js/jquery.min.js"></script>
	<script src="/resources/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="/resources/js/popper.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/js/jquery.easing.1.3.js"></script>
	<script src="/resources/js/jquery.waypoints.min.js"></script>
	<script src="/resources/js/jquery.stellar.min.js"></script>
	<script src="/resources/js/owl.carousel.min.js"></script>
	<script src="/resources/js/jquery.magnific-popup.min.js"></script>
	<script src="/resources/js/jquery.animateNumber.min.js"></script>
	<script src="/resources/js/scrollax.min.js"></script>
	<script src="/resources/js/main.js"></script>
    
</body>
</html>