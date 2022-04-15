<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>map</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<c:set var="url" value="<%=request.getContextPath()%>" />
<link rel="stylesheet" href="${url}/css/mapstyle.css">
<script>
	$(function(){
		//console.log(${tourList }); //즉시 실행함수로 foreach문을 돌려서 확인먼저 하고 짜기. 
		let tag =""; //초기화
		
		${tourList}.forEach(item=>{//"""템플릿 리터럴""", jsp에서는 중괄호 한번 더, forEach/innerHTML 더 찾아보기
			tag += `<div>
					<a><img src="{'${item.firstimage2}'}"/></a>
					
					<li>${'${item.firstimage2}'}</li>
					<h1>${'${item.title}'}</h1>
					<li>${'${item.addr1}'}</li>
					<li>${'${item.overview}'}</li>
					</div>` 
		});
		//Document.getElementById("").innerHTML = tag;
		$("#listContent").html(tag);
		
	});
	jQuery(document).ready(function() {
		var a = jQuery('#original-image').attr("src");
		jQuery("#replace-image").attr("src", a);
	});
	//https://hooongs.tistory.com/89
	/* $("#listContent").ready(function(){
	var arrlistContent = new Array();
	arrlistContent = [];
	for (var i = 0; i < arrlistContent.length; i ++) {});
	}); */
	
	/* 
	*짜쓰 포문 쓰기
	innerHTML,,,

	foreach,,,
	el태그 쓰지x */
</script>

</head>

<body>
	<div id="listWrap">
        <!-- 리스트 -->
        <div id="list">
            <!-- 리스트 버튼 -->
            <div class="topBotton">
                <button onclick="location.href='/mapView'" class="listbutton">목록</button>
                <button onclick="location.href='/planView'" class="planbutton">플래너</button>
            </div>
            <!-- 리스트 내용 -->
            <div class="listContentWrap">
               	<ul class="listContent" id="listContent">
					<%-- <c:forEach var="vo" items="${tourList }">
					    <li>${vo.get("firstimage2")}</li>
					    <img class="listImg" src="../../img/map/map_0.jpg">
					    <li>${vo.get("title")}</li>
					    <li>${vo.get("addr1")}</li>
					    <li>부안읍에서 격포항을 향하여 변산 해수욕장을 지나고 거의 격포에 이를 즈음 마포마을을 지나 방향을 바꾸어 왼쪽 도로의 약 2.5km 지점인 변산면 도청리에 위치하고 있다. 금구원조각미술관은 1966년 김오성이 세운 우리나라 최초의 조각공원으로 2003년 문화관광부에 등록된 사립박물관 제277호이다.</li>
					    <li>${vo.get("overview")}</li>
					</c:forEach> --%>
				</ul>
            </div>
        </div>
        <!-- 지도 -->
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            <!-- 지도타입 컨트롤 div 입니다 -->
            <div class="custom_typecontrol radius_border">
                <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
                <span id="btnSkyview" class="btn" onclick="setMapType('skyview')">스카이뷰</span>
            </div>
            <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
            <div class="custom_zoomcontrol radius_border">
                <span onclick="zoomIn()"><img src="../../img/map/map_18.png" alt="확대"></span>
                <span onclick="zoomOut()"><img src="../../img/map/map_19.png" alt="축소"></span>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4370da25b2b005f46ac559243f9b721"></script>
        <script>
    	$(function(){
    		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(33.3085171454, 126.6344317363), // 지도의 중심좌표
                level: 8 // 지도의 확대 레벨
            };

        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
        console.log(${tourList});
        var jobj = ${tourList};
       // alert(jobj[0].mapx+"/"+jobj[0].mapy);
        
     	// 마커를 표시할 위치와 title 객체 배열입니다 
        var positions =[]
       
        
		console.log()
        // 마커 이미지의 이미지 주소입니다
        var imageSrc = "/img/map/map_01.png"; 
            
        for (var i = 0; i < jobj.length; i ++) {
        	 var pos=	{
        	        	title: jobj[i].title, 
        	        	latlng: new kakao.maps.LatLng(jobj[i].mapy, jobj[i].mapx)
        	        	}
        	 positions.push(pos);
            // 마커 이미지의 이미지 크기 입니다
            var imageSize = new kakao.maps.Size(24, 35); 
            
            // 마커 이미지를 생성합니다    
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
            
            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                map: map, // 마커를 표시할 지도
                //position: positions[i].latlng, // 마커를 표시할 위치
                //title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                position: pos.latlng, // 마커를 표시할 위치
                title : pos.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                image : markerImage // 마커 이미지 
            });
        }
        
        marker.setMap(map);
    		
    	
            /* var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
                center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
                level : 14 // 지도의 확대 레벨 
            });
            //var map = new kakao.maps.Map(map, mapOption); // 지도를 생성합니다
            
         // 마커 클러스터러를 생성합니다 
            var clusterer = new kakao.maps.MarkerClusterer({
                map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
                averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
                minLevel: 10 // 클러스터 할 최소 지도 레벨 
            });
         	
           
            var jobj = ${tourList};
            
            console.log(jobj);
            alert(jobj);
    
            // 마커들을 저장할 변수 생성(마커 클러스터러 관련)
			var markers = [];
			var positions = [];
			
			for (var i = 0; i < positions.length; i++ ) {
			
			// 지도에 마커를 생성하고 표시한다.
			var marker = new kakao.maps.Marker({
				//position: new kakao.maps.LatLng(jboj.get("mapx"), jboj.get("mapy")), // 마커의 좌표
			    position: new kakao.maps.LatLng(positions[i].lat, positions[i].lng), //이렇게 하면 안먹힘
			    map: map // 마커를 표시할 지도 객체
			});
			
			// 생성된 마커를 마커 저장하는 변수에 넣음(마커 클러스터러 관련)
			markers.push(marker);
			}
			
			// 클러스터러에 마커들을 추가합니다
            clusterer.addMarkers(markers);
             */
			
            //https://bcdragonfly.tistory.com/16
            
            
            // 마커 생성 ----------------------------------------------------------//
            // 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
            /* var jobj = ${tourList};
            //var positions = [];
            for (var i = 0; i < Object.keys(jobj).length; i++) {
            	var positions = {
                    content: jobj.get("title");
                    latlng: new kakao.maps.LatLng(jboj.get("mapX"), jboj.get("mapY")),
                    //latlng: new kakao.maps.LatLng(jboj.get("mapX"), jboj.get("mapY")),
                };
            	positions.push(content);
            };
            console.log(positions);
            
         	// 마커 이미지의 이미지 주소입니다
            var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
            for (var i = 0; i < positions.length; i++) {
              // 마커 이미지의 이미지 크기 입니다
              var imageSize = new kakao.maps.Size(24, 35);
              // 마커 이미지를 생성합니다
              var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
              // 마커를 생성합니다
              var marker = new kakao.maps.Marker({
                map: map, // 마커를 표시할 지도
                position: jobj[i].latlng, // 마커를 표시할 위치
                title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                image: markerImage // 마커 이미지
              });
            
            
             */
            
            
            //https://velog.io/@woo0_hooo/django-%EC%B9%B4%EC%B9%B4%EC%98%A4%EB%A7%B5-api%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%B4-%EC%A7%80%EB%8F%84%EC%97%90-%EB%A7%88%EC%BB%A4-%EC%98%A4%EB%B2%84%EB%A0%88%EC%9D%B4
            /* for (var i = 0; i < positions.length; i ++) {
                // 마커를 생성합니다
                var marker = new kakao.maps.Marker({
                    map: map, // 마커를 표시할 지도
                    position: positions[i].latlng // 마커의 위치
                }); */
            
                // 마커에 표시할 인포윈도우를 생성합니다 
                /* var infowindow = new kakao.maps.InfoWindow({
                    content: positions[i].content // 인포윈도우에 표시할 내용
                }); */
                
                // 커스텀 오버레이에 표시할 컨텐츠 입니다
                // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
                // 별도의 이벤트 메소드를 제공하지 않습니다 
                /* var content2 = '<div class="wrap">' + 
                            '    <div class="info">' + 
                            '        <div class="title">' + 
                                        positions[i].content + 
                            '            <div class="close" onclick="closeOverlay('+i+')" title="닫기"></div>' + 
                            '        </div>' + 
                            '        <div class="body">' + 
                            '            <div class="img">' +
                            '                <img src="https://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
                            '           </div>' + 
                            '            <div class="desc">' + 
                            '                <div class="ellipsis">제주특별자치도 제주시 첨단로 242</div>' + 
                            '                <div class="jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' + 
                            '                <div><a href="https://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' + 
                            '            </div>' + 
                            '        </div>' + 
                            '    </div>' +    
                            '</div>';
                
                var overlay = new kakao.maps.CustomOverlay({
                                content: content2,
                                map: map,
                                position: marker.getPosition()       
                            });	
                overlayArr.push(overlay); */
                    
                // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
                // 이벤트 리스너로는 클로저를 만들어 등록합니다 
                // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
                //kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
                //kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
                
                // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
                //kakao.maps.event.addListener(marker, 'click', function() {
                    //$(".wrap").show();
                    //overlay.setMap(map);
                //});
                // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
                
            //}

            /* function closeOverlay(i) {
                //alert(i)
                overlayArr[i].setMap(null);     
            } */
            // 마커 위에 커스텀오버레이를 표시합니다
            // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
            /* var overlay = new kakao.maps.CustomOverlay({
                        content: content2,
                        map: map,
                        position: marker.getPosition()       
                    });	 */

            // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
            /* function makeOverListener(map, marker, infowindow) {
                return function() {
                    infowindow.open(map, marker);
                };
            } */

            // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
            /* function makeOutListener(infowindow) {
                return function() {
                    infowindow.close();
                };
            } */


            // 지도 확대 ----------------------------------------------------------//
            // 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
            function setMapType(maptype) {
                var roadmapControl = document.getElementById('btnRoadmap');
                var skyviewControl = document.getElementById('btnSkyview');
                if (maptype === 'roadmap') {
                    map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);
                    roadmapControl.className = 'selected_btn';
                    skyviewControl.className = 'btn';
                } else {
                    map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);
                    skyviewControl.className = 'selected_btn';
                    roadmapControl.className = 'btn';
                }
            }
            // 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
            function zoomIn() {
                map.setLevel(map.getLevel() - 1);
            }

            // 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
            function zoomOut() {
                map.setLevel(map.getLevel() + 1);
            }
            });///////
        </script>
        <!-- 플래너 생성 버튼 -->
        <div class="planCreate">
            <a href="#" class="button">플래너 생성 +</a>
        </div>
    </div>
</body>
</html>