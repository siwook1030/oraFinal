window.onload = function(){



	
		//----------------------------------------------------------------------------------------------- 무인자전거
	kakao.maps.event.addListener(map, 'idle', removePlaceOveray);

	const redC = '/detailCourseImg/redC.png'; // 따릉이 0개
	const yellowC = '/detailCourseImg/yellowC.png'; // 따릉이 1~4개  
	const greenC = '/detailCourseImg/greenC.png'; // 따릉이 5개 이상  
	const publicC = '/detailCourseImg/greenC.png'; // 서울을 제외한 나머지 공공자전거 마커이미지

	
	const cycleSize = new kakao.maps.Size(8, 8); 
	
	// 따릉 마커 이미지를 생성합니다
	const redImage = new kakao.maps.MarkerImage(redC, cycleSize);
	const yellowImage = new kakao.maps.MarkerImage(yellowC, cycleSize);
	const greenImage = new kakao.maps.MarkerImage(greenC, cycleSize);
	const publicCImage = new kakao.maps.MarkerImage(publicC, cycleSize);

		
	let cycleMakerArr = [];
	publicCycle.addEventListener("change", function(e) {
		const check = e.target.value;
		const cName = (e.target.options[e.target.selectedIndex]).text;
		const cycleUrl = (e.target.options[e.target.selectedIndex]).getAttribute("cycleUrl");
		cycleMakerArr.forEach(function(cm, i) {
			cm.setMap(null);
		})
		placeOverlay.setMap(null);
		cycleMakerArr = [];
		if(check == '0'){  // 아무것도 안함
			return;
		}
		else if(check == '1'){ // 서울
			setSeoulCycle(cName,cycleUrl);
		}
		else if(check == '2'){
			setDajeonCycle(cName,cycleUrl);
		}
		else if(check == '3'){
			setSejongYeosuCycle(cName,cycleUrl);
		}
		else{ // 경기도
			setGgCycle(check,cName,cycleUrl);
		}
	});
	
	function setSeoulCycle(cName,cycleUrl){
		for(let i=1; i<=2001; i+=1000){
			$.ajax({
				url:"http://openapi.seoul.go.kr:8088/6a625562487369773231685a644f53/json/bikeList/"+i+"/"+(i+999),
				success:function(data){
					const cycList = data.rentBikeStatus.row;
					cycList.forEach(function(cyc, i) {
						setCycleMarker(cyc,cName,cycleUrl);
					})
				},
				error: function() {
					alert("서버에러");
				}		
			})
		}
	}
	
	function setCycleMarker(cyc,cName,cycleUrl){
		const parkingCnt = cyc.parkingBikeTotCnt;
		let cImg = greenImage;
		if(parkingCnt == 0){
			cImg = redImage;
		}
		else if(parkingCnt >=1 && parkingCnt <=4){
			cImg = yellowImage;
		}
		
		const cyclePosition = new kakao.maps.LatLng(cyc.stationLatitude, cyc.stationLongitude);  
		// 따릉이 마커를 생성합니다 
		const cycleMarker = new kakao.maps.Marker({  
		    map: map,
		    position: cyclePosition,
		    image: cImg
		});	
		cycleMakerArr.push(cycleMarker);
            kakao.maps.event.addListener(cycleMarker, 'click', function() {
                displaySeoulC(cyc,cName,cycleUrl);
            });
	}
	
	function displaySeoulC (cyc,cName,cycleUrl) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="'+cycleUrl+'" target="_blank" title="'+cName+'">'+cName+'</a>';   
	
	    
	        content += '    <span>' + cyc.stationName + '</span>';
	        
	   
	    content += '    <span class="tel">' + "현재 대여가능수 "+cyc.parkingBikeTotCnt + '</span>' + 
	               ' <span class="jibun" >' + "전체 거치대수 "+cyc.rackTotCnt +  '</span>';
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(cyc.stationLatitude, cyc.stationLongitude));
	    placeOverlay.setMap(map);  
	}

	function setGgCycle(code,cName,cycleUrl){
		$.ajax({
			url:"https://openapi.gg.go.kr/BICYCL?key=e2d851f8493c448c964a25461359f1f5&pIndex=1&pSize=1000&SIGUN_NM="+code,
			type:"get",
			success:function(data){
				console.log(data);
				const cycList = data.querySelectorAll('row');
				console.log(cycList[0]);
				for(let i=0; i<cycList.length; i++){
					setGgCycleMarker(cycList[i],cName,cycleUrl);
				}
			},
			error:function(){
				alert("에러발생");
			}
		})
	}
	
	function setGgCycleMarker(cyc,cName,cycleUrl){
			const cyclePosition = new kakao.maps.LatLng(cyc.querySelector('REFINE_WGS84_LAT').innerHTML, cyc.querySelector('REFINE_WGS84_LOGT').innerHTML);  
			// 경기도 마커를 생성합니다 
			const cycleMarker = new kakao.maps.Marker({  
			    map: map,
			    position: cyclePosition,
			    image: publicCImage
			});	
			cycleMakerArr.push(cycleMarker);
	            kakao.maps.event.addListener(cycleMarker, 'click', function() {
	            	displayGgC(cyc,cName,cycleUrl);
	            });
	}

	function displayGgC (cyc,cName,cycleUrl) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="'+cycleUrl+'" target="_blank" title="'+cName+'">'+cName+'</a>';   
	
	    
	        content += '    <span>' + cyc.querySelector('BICYCL_LEND_PLC_NM_INST_NM').innerHTML + '</span>';
	        
	   
	    content += '    <span class="tel">' + "전체 거치대수 "+cyc.querySelector('STANDS_CNT').innerHTML +  '</span>' + 
	              // ' <span class="jibun" >' + "전체 거치대수 "+place.STANDS_CNT +  '</span>';
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(cyc.querySelector('REFINE_WGS84_LAT').innerHTML, cyc.querySelector('REFINE_WGS84_LOGT').innerHTML));
	    placeOverlay.setMap(map);  
	}

	const cycleGeocoder = new kakao.maps.services.Geocoder(); // 대전은 위도경도데이터가 없어 주소로 위경도를 얻어와야함
	
	function setDajeonCycle(cName,cycleUrl){
		$.ajax({
			url:"/publicCycle/dajeonCycle.json",
			type:"get",
			dataType:"JSON",
			success:function(data){
				const cycList = data;
				cycList.forEach(function(cyc, i) {
					setDajeonCycleMarker(cyc,cName,cycleUrl);
				});		
			},
			error:function(){
				alert("에러발생");
			}
		})
	}

		function setDajeonCycleMarker(cyc,cName,cycleUrl){
			cycleGeocoder.addressSearch(cyc.addr, function(result, status) {
			     if (status === kakao.maps.services.Status.OK) {
			        const latLng = new kakao.maps.LatLng(result[0].y, result[0].x);

					const cyclePosition = latLng;
					// 대전 마커를 생성합니다 
					const cycleMarker = new kakao.maps.Marker({  
					    map: map,
					    position: cyclePosition,
					    image: publicCImage
					});	
					cycleMakerArr.push(cycleMarker);
			            kakao.maps.event.addListener(cycleMarker, 'click', function() {
			            	displayDajeonC(cyc,cName,cycleUrl,latLng);
			            });

			    } 
			});    
	
	}

	function displayDajeonC (cyc,cName,cycleUrl,latLng) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="'+cycleUrl+'" target="_blank" title="'+cName+'">'+cName+'</a>';   
	
	    
	        content += '    <span>' + cyc.station + '</span>';
	        
	   
	    content += '    <span class="jibun">('+cyc.loc+')</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(latLng);
	    placeOverlay.setMap(map);  
	}
		
	function setSejongYeosuCycle(cName,cycleUrl){
		let dataUrl = "";
		if(cName == '세종(어울링)'){
			dataUrl = "/publicCycle/sejongCycle.json";
		}
		else if(cName == '여수(여수랑)'){
			dataUrl = "/publicCycle/yeosuCycle.json"
		}
		$.ajax({
			url:dataUrl,
			type:"get",
			dataType:"JSON",
			success:function(data){
				const cycList = data;
				cycList.forEach(function(cyc, i) {
					setSejongYeosuCycleMarker(cyc,cName,cycleUrl);
				});		
			},
			error:function(){
				alert("에러발생");
			}
		})
	}

	function setSejongYeosuCycleMarker(cyc,cName,cycleUrl){
		const cyclePosition = new kakao.maps.LatLng(cyc.latitude, cyc.longitude);  
		// 경기도 마커를 생성합니다 
		const cycleMarker = new kakao.maps.Marker({  
		    map: map,
		    position: cyclePosition,
		    image: publicCImage
		});	
		cycleMakerArr.push(cycleMarker);
            kakao.maps.event.addListener(cycleMarker, 'click', function() {
            	displaySejongYeosuC(cyc,cName,cycleUrl);
            });
	}

	function displaySejongYeosuC (cyc,cName,cycleUrl) {
	    let content = '<div class="placeinfo">' +
	                    '   <a class="title" href="'+cycleUrl+'" target="_blank" title="'+cName+'">'+cName+'</a>';   
	
	    
	        content += '    <span>' + cyc.station + '</span>';
	        
	   
	    content += '    <span class="jibun">' + cyc.loc+  '</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(cyc.latitude, cyc.longitude));
	    placeOverlay.setMap(map);  
	}
// ----------------------------------------------------------------------------------------무인자전거 위치 끝
}