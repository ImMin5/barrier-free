<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>map</title>
<c:set var="url" value="<%=request.getContextPath()%>" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<link rel="stylesheet" href="${url}/css/mapstyle.css">

<script>
	/* $.ajax({        
	   url: 'TourismDataOK.do',
	   type: 'get',
	      data : {"contentId" : contentid, "contentTypeId" : contenttypeid }, // contentid, contentTypeid 서버로 전송
	   dataType: 'json',
	   success: function(data){
	          var myItem = data.response.body.items.item; // 이 경로 내부에 데이터가 들어있음
	        
	       for(var i=0; myItem.length; i++){
	           var output = '';
	
	              // 14. [공통정보 조회] 오퍼레이션 명세 사용함.
	              // API 활용 메뉴얼에서 Response 할 수 있는 데이터들
	           output += myItem[i].firstimage2; // 썸네일
	              output += '<h1>'+myItem[i].title+'</h1>'; // 제목
	           output += '<h2>'+myItem[i].addr1+'</h2>'; // 주소
	              output += '<h2>'+myItem[i].overview+'</h2>'; // 콘텐츠 개요
	           document.body.innerHTML += output;
	       }
	   },
		error: function(XMLHttpRequest, textStatus, errorThrown) { 
	    	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
		} 
	});
	*/
</script>
</head>
<body>
    <div id="listWrap">
    	<!-- 리스트 -->
        <div id="list">
            <div class="topBotton">
                <button  onclick="location.href='/mapView'" class="listbutton">목록</button>
                <button  onclick="location.href='/planView'" class="planbutton">플래너</button>
			</div>
        <!-- 리스트 내용 -->
        <div class="listContent">
            <div class="listContentWrap">
                <!-- 
                <ul>
                	<c:forEach var="vo" items="tourList">
                		<li>${vo}</li>
                	</c:forEach>
                </ul> 
                -->
                <img class="listImg" src="../../img/map/map_0.jpg">
                <h1>제주동문시장</h1>
                <ul>
                    <li>주소: 제주 제주시 관덕로14길 20</li>
                    <li>싱싱한 농수산물, 의류, 잡화 등을 판매하는 역사가 오래된 실내 시장입니다.</li>
                </ul>
                <div class="listSubInfoWrap">
	                <div class="listSubInfo">
	                    <img class="listSubInfoImg" src="../../img/map/map_06.png">
	                    <span>100</span>
	                </div>
	                <div class="listSubInfo">
	                    <img class="listSubInfoImg" src="../../img/map/map_07.png">
	                    <span>100</span>
	                </div>
	                <div class="listSubInfo">
	                    <img class="listSubInfoImg" src="../../img/map/map_08.png">
	                    <span>100</span>
	                </div>
	                <div class="listSubInfo">
	                    <img class="listSubInfoImg" src="../../img/map/map_09.png">
	                    <span>200</span>
	                </div>
                </div>
            </div>
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
                <span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
                <span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
            </div>
        </div>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a4370da25b2b005f46ac559243f9b721"></script>
        <script>
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = { 
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  
            
            var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
                
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
        </script>
        <img src="../../img/map/map_14.png"/>
        <!-- 플래너 생성 버튼 -->
        <div class="planCreate">
        	
            <a href="#" class="button"><img src="../../img/map/map_14.png"/>플래너 생성</a>
        </div>
    </div>
</body>
</html>